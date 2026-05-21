// UCL Intr0 — JS/Canvas port of the 1996 DOS demo.
// Port of the algorithms documented in ../UCL-SRC.analysis.md.
//
// Loads the original COM file, slices the data regions out of it, then
// runs three render passes per frame:
//   1) advance the scroll-text bitmap ring by one column-strip
//   2) project that ring through a per-row perspective LUT (the "floor")
//   3) wobble + project the UCL 3-D point cloud, plot each point with a
//      depth-bucketed brush
// Then a separable box-blur with -1 decay gives the painterly trails,
// and the indexed framebuffer is uploaded through a 256-entry palette
// into a Canvas ImageData.

const W = 320, H = 200;
const ORIG_BYTES = 5798;
const FILE_OFFSET = 0x100;
const fileOf = a => a - FILE_OFFSET;

// ---------------------------------------------------------------- palette
// Reproduces the VGA DAC programming at asm 0x220-0x259: three ramps of
// 64, 64, 128 entries. Each writes (R, G, B) bytes at port 0x3C9, where
// values are 6-bit. We convert to 8-bit for canvas.
function buildPalette() {
  const dac = new Uint8Array(256 * 3); // 6-bit values
  // ramp 1: R grows every 2 entries, G=B grow every entry
  let al = 0, ah = 0;
  for (let i = 0; i < 64; i++) {
    dac[i*3+0] = ah;
    dac[i*3+1] = al;
    dac[i*3+2] = al;
    al = (al + 1) & 0xFF;
    if (al & 1) ah = (ah + 1) & 0xFF;
  }
  // ramp 2: R=G grow every 2 entries, B grows every entry
  al = 0; ah = 0;
  for (let i = 64; i < 128; i++) {
    dac[i*3+0] = al;
    dac[i*3+1] = al;
    dac[i*3+2] = ah;
    ah = (ah + 1) & 0xFF;
    if (ah & 1) al = (al + 1) & 0xFF;
  }
  // ramp 3: 128 entries of (0,0,0) initially. The original later overrides
  // these for the exit fade; we leave them dark.
  // expand 6-bit → 8-bit (replicate top 2 bits into low 2)
  const rgba = new Uint8Array(256 * 4);
  for (let i = 0; i < 256; i++) {
    const r = dac[i*3+0], g = dac[i*3+1], b = dac[i*3+2];
    rgba[i*4+0] = (r << 2) | (r >> 4);
    rgba[i*4+1] = (g << 2) | (g >> 4);
    rgba[i*4+2] = (b << 2) | (b >> 4);
    rgba[i*4+3] = 255;
  }
  return rgba;
}

// ---------------------------------------------------------------- noise
// Reproduces the LFSR-ish 32-bit recurrence at asm 0x107-0x138.
//   state[i] = ((state[i-1] * 0x7FF62182) >> 30) - state[i-2]
//   noise[i] = (state[i] >> 23) as signed byte
// Seed dwords are pulled from the binary at offsets 0x179E (s2) and
// 0x17A2 (s1) — preserves the exact wave the original generates.
function buildNoise(mem) {
  const rd32 = a => {
    const o = fileOf(a);
    return (mem[o] | (mem[o+1] << 8) | (mem[o+2] << 16) | (mem[o+3] << 24)) | 0;
  };
  let s1 = rd32(0x17A2);
  let s2 = rd32(0x179E);
  const MUL = BigInt(0x7FF62182 | 0);
  const noise = new Int8Array(256);
  noise[0] = 0x02; noise[1] = 0x06;  // dummy prefix at [0x1B9E..0x1B9F]
  for (let i = 0; i < 254; i++) {
    const prod = BigInt(s1) * MUL;
    let eax = Number(BigInt.asIntN(32, prod >> 30n)) | 0;
    eax = (eax - s2) | 0;
    noise[i + 2] = (eax >> 23) & 0xFF;   // Int8Array reinterprets sign
    s2 = s1;
    s1 = eax;
  }
  return noise;
}

// ---------------------------------------------------------------- font
// Unpacks the 8×8 packed font at 0x149A (96 glyphs × 8 bytes) the way
// asm 0x13A-0x156 does: each source bit becomes 0x00 or 0x3F. Output is
// 96 * 64 = 6144 bytes of 8-bpp glyph atlas indexed by (char - 0x20).
function unpackFont(mem) {
  const src = mem.subarray(fileOf(0x149A), fileOf(0x149A) + 96 * 8);
  const out = new Uint8Array(96 * 64);
  for (let g = 0; g < 96; g++) {
    for (let row = 0; row < 8; row++) {
      const b = src[g * 8 + row];
      for (let bit = 0; bit < 8; bit++) {
        out[g * 64 + row * 8 + bit] = (b & (0x80 >> bit)) ? 0x3F : 0x00;
      }
    }
  }
  return out;
}

// ---------------------------------------------------------------- UCL 3D
// Decodes the 40×9×8 packed bitmap at 0xAF1 into a flat point cloud,
// exactly as asm 0x184-0x1CC does it. A *cleared* bit becomes a point
// (the original treats the bitmap as inverted).
function decodeUCLPoints(mem) {
  const src = mem.subarray(fileOf(0xAF1));
  const pts = [];
  let p = 0;
  for (let row = 0; row < 40; row++) {
    for (let col = 0; col < 9; col++) {
      const byte = src[p++];
      for (let bit = 0; bit < 8; bit++) {
        // asm: shl dh,1; jc skip — so bit=1 means "skip", bit=0 means "plot"
        if (byte & (0x80 >> bit)) continue;
        const x = (col * 8 + bit) * 3 - 0x6C;
        const y = row * 3 - 0x5A;
        const z = 0x17C;
        pts.push(x, y, z);
      }
    }
  }
  return new Int16Array(pts);
}

// ---------------------------------------------------------------- perspective LUT
// 64 rows. First word of each entry is the screen byte-offset where that
// scan-line starts (line 0 = 0xF8C0 = row 199 col 0 — the bottom of the
// screen; subsequent lines start further toward screen-centre as they
// recede). Second word is the per-texture-sample fixed-point step added
// to a 16-bit accumulator at each iteration; the screen pixel-position
// advances by one whenever the accumulator overflows. Smaller step ⇒
// fewer screen pixels covered ⇒ row appears narrower in the distance.
// Built at asm 0x157-0x172.
function buildPerspectiveLUT() {
  const lut = new Uint16Array(64 * 2);
  let diStart = 0xF8C0, step = 0xFFFF;
  for (let i = 0; i < 64; i++) {
    lut[i*2+0] = diStart;
    lut[i*2+1] = step;
    diStart = (diStart - 0x13F) & 0xFFFF;
    step    = (step    - 0x19A) & 0xFFFF;
  }
  return lut;
}

// ---------------------------------------------------------------- music
// Web-Audio approximation of the original's OPL2 song driver.
//
// The original (asm 0x5DB) walks 9 song streams in lock-step at a tick
// rate of ~9 Hz. Per channel per tick:
//   - decrement an 8-bit signed duration counter; if still positive, skip
//   - read next byte from the stream:
//       0x00        → end-of-stream, rewind to the channel's saved start
//       bit-7 set   → duration override: new duration = byte - 0x81
//       else        → note byte: play it
// Note byte: low nibble (0..11) indexes a 12-entry F-number table at
// 0x66A; upper nibble carries OPL2 block bits. The asm sends low byte
// to OPL register A0+ch, high byte (after adding block bits) to B0+ch.
// We don't talk to a real OPL2 — instead we convert (F-num, block) to
// Hz via the OPL2 frequency formula and play a 2-osc FM voice through
// Web Audio.
class MusicPlayer {
  constructor(mem, audioCtx) {
    this.mem = mem;
    this.ctx = audioCtx;
    this.master = audioCtx.createGain();
    this.master.gain.value = 0.18;
    // Low-shelf EQ to bring back the bass the sine-FM voices lose. The
    // OPL2 chip itself had a colored low-end, and at low frequencies a
    // 1:1-ratio FM voice puts most of its energy into sidebands rather
    // than the fundamental, so without this the bass channels almost
    // disappear in the mix.
    this.bassBoost = audioCtx.createBiquadFilter();
    this.bassBoost.type = 'lowshelf';
    this.bassBoost.frequency.value = 180;
    this.bassBoost.gain.value = 14;            // dB
    this.bassBody = audioCtx.createBiquadFilter();
    this.bassBody.type = 'peaking';
    this.bassBody.frequency.value = 280;
    this.bassBody.Q.value = 0.8;
    this.bassBody.gain.value = 6;
    // Limiter to catch summed-voice peaks before they hard-clip into
    // crunchy distortion. Aggressive threshold + fast attack keeps low
    // notes intact while taming the spikes when multiple bass voices
    // overlap.
    this.limiter = audioCtx.createDynamicsCompressor();
    this.limiter.threshold.value = -10;
    this.limiter.knee.value = 6;
    this.limiter.ratio.value = 12;
    this.limiter.attack.value = 0.003;
    this.limiter.release.value = 0.18;
    this.master.connect(this.bassBoost);
    this.bassBoost.connect(this.bassBody);
    this.bassBody.connect(this.limiter);
    this.limiter.connect(audioCtx.destination);

    // 9 channels, each (cur, rew, dur). Initial values live in the
    // binary at 0x6EC..0x710 as (current_ptr, rewind_ptr) word pairs.
    this.channels = [];
    for (let ch = 0; ch < 9; ch++) {
      const o = fileOf(0x6EC) + ch * 4;
      const cur = mem[o]   | (mem[o+1] << 8);
      const rew = mem[o+2] | (mem[o+3] << 8);
      this.channels.push({ cur, rew, dur: 0, lastEnv: null });
    }

    // 12-entry F-num table at 0x66A. Each entry is a (lo, hi) word where
    // lo goes to OPL register A0 and hi (+block bits) goes to B0. The hi
    // byte already has the key-on bit (0x20) set.
    this.note = [];
    for (let i = 0; i < 12; i++) {
      const o = fileOf(0x66A) + i * 2;
      this.note.push({ lo: mem[o], hi: mem[o+1] });
    }

    this.nextTickTime = audioCtx.currentTime + 0.05;
    this.TICK = 1 / 9.1;        // seconds between music ticks
  }

  // Drain song bytes for any channel whose duration has expired, scheduling
  // every note that should sound up to `audioCtx.currentTime + lookahead`.
  scheduler() {
    const lookahead = 0.12;
    const horizon = this.ctx.currentTime + lookahead;
    while (this.nextTickTime < horizon) {
      this.tick(this.nextTickTime);
      this.nextTickTime += this.TICK;
    }
  }

  tick(when) {
    for (let ch = 0; ch < 9; ch++) {
      const c = this.channels[ch];
      // asm: `sub byte [bx+0x661], 1; jns skip` — decrement-then-skip-
      // while-positive. So duration is a signed byte; once it goes
      // negative we process song bytes until a duration override is
      // hit (which sets a non-negative value), or a note is played
      // (which leaves duration as it is, so the next tick fires again).
      c.dur = (c.dur - 1) & 0xFF;
      if ((c.dur & 0x80) === 0) continue;     // still positive ⇒ skip

      for (let safety = 0; safety < 64; safety++) {
        const al = this.mem[fileOf(c.cur)];
        c.cur = (c.cur + 1) & 0xFFFF;
        if (al === 0) {                       // end-of-stream → rewind
          c.cur = c.rew;
          continue;
        }
        if (al & 0x80) {                      // duration override
          c.dur = (al - 0x81) & 0xFF;         // -1..0x7E
          break;
        }
        // Note byte: low nibble = chromatic step, upper nibble = octave/block bits.
        const noteIdx = al & 0x0F;
        const blockBits = (al >> 2) & 0xFC;
        if (noteIdx >= 12) break;             // unused indices 12..15
        const entry = this.note[noteIdx];
        const bReg = (entry.hi + blockBits) & 0xFF;
        const fnum  = ((bReg & 0x03) << 8) | entry.lo;
        const block = (bReg >> 2) & 0x07;
        // OPL2: f_Hz = F-num × 49716 / 2^(20 - block)
        const freq = fnum * 49716 / Math.pow(2, 20 - block);
        if (freq > 20 && freq < 12000) this.playNote(ch, freq, when);
        break;                                // one note per channel per tick
      }
    }
  }

  playNote(ch, freq, when) {
    const c = this.channels[ch];
    const ctx = this.ctx;

    // Cross-fade out the previous voice over ~60 ms rather than a hard
    // 5 ms cut — notes blend into each other so the overall texture
    // sounds sustained instead of staccato.
    if (c.lastEnv) {
      try {
        c.lastEnv.gain.cancelScheduledValues(when);
        c.lastEnv.gain.setValueAtTime(c.lastEnv.gain.value, when);
        c.lastEnv.gain.linearRampToValueAtTime(0, when + 0.06);
      } catch (_) { /* node already ended */ }
    }

    // Two-operator FM: `mod` modulates `car`'s frequency. The deviation
    // (`modGain`) is the FM index — sets the "brightness" of the timbre.
    const mod      = ctx.createOscillator();
    const car      = ctx.createOscillator();
    const modGain  = ctx.createGain();
    const env      = ctx.createGain();

    mod.type = 'sine';
    car.type = 'triangle';                  // richer fundamental than sine
    mod.frequency.value = freq;             // 1:1 modulator ratio
    car.frequency.value = freq;
    // Modulation index scaled aggressively low for bass — at freq=80 Hz
    // we want almost pure carrier (index ≈ 0.15) so the fundamental
    // dominates. Higher freqs keep the FM grit.
    const modIndex = Math.min(1.4, Math.max(0.15, freq / 900));
    modGain.gain.value  = freq * modIndex;

    mod.connect(modGain);
    modGain.connect(car.frequency);
    car.connect(env);
    env.connect(this.master);

    // Envelope: attack → sustain plateau → long release. The plateau
    // keeps the note ringing at full amplitude until the channel's
    // next note (or the release-ramp end), giving the music sustained
    // continuity instead of plucked-staccato bursts. Bass notes get a
    // longer plateau + release so low-end energy carries between hits.
    const lowBoost  = freq < 200 ? 1.35 : freq < 400 ? 1.15 : 1.0;
    const peak      = 0.22 * lowBoost;
    const attack    = 0.010;
    // Sustain ≈ one tick interval (≈110 ms) so consecutive notes on a
    // channel just overlap, no more. Release short enough that 9
    // channels firing together don't smear into a wash.
    const sustain   = freq < 200 ? 0.24 : 0.14;
    const release   = freq < 200 ? 0.32 : 0.22;
    env.gain.setValueAtTime(0, when);
    env.gain.linearRampToValueAtTime(peak, when + attack);
    env.gain.setValueAtTime(peak, when + attack + sustain);
    env.gain.exponentialRampToValueAtTime(0.0008, when + attack + sustain + release);

    const total = attack + sustain + release + 0.05;
    mod.start(when);
    car.start(when);
    mod.stop(when + total);
    car.stop(when + total);

    c.lastEnv = env;
  }
}

// ---------------------------------------------------------------- demo state
class Demo {
  constructor(mem, ctx) {
    this.mem = mem;
    this.ctx = ctx;
    this.imageData = ctx.createImageData(W, H);
    this.palette = buildPalette();
    this.noise = buildNoise(mem);
    this.font = unpackFont(mem);
    this.points = decodeUCLPoints(mem);   // Int16, flat (x,y,z) triples
    this.perspective = buildPerspectiveLUT();

    // Indexed framebuffer (and one previous-frame buffer for blur trails).
    this.fb = new Uint8Array(W * H);

    // Pre-rasterise the entire scroll message into one tall bitmap, 320
    // wide × N rows tall (N depends on the message). Each text line is
    // 8 rows tall; 0x7F in the source is the line separator (this is the
    // 'jz 0x2ea' branch in the regen loop at asm 0x2B0 — it just *stops*
    // the regen pass; the next regen picks up after the 0x7F, drawing
    // into the next 8-row band). 0x7E ('~') toggles a colour bank.
    this.textBitmap = this._rasterizeAllText(mem);
    // Start scrollPos far enough negative that every visible bitmap row
    // is < 0 — those rows are drawn as "blank" (pure gradient backdrop)
    // and the demo opens with an empty floor for ~64 scrollPos ticks
    // before the first text line crosses the horizon. Mirrors the
    // original starting with a zeroed GS bitmap.
    this.scrollPos = -80;
    // Sub-frame counter so we advance scrollPos every Nth animation
    // frame rather than every frame — keeps each text line readable
    // for a few seconds at modern frame rates.
    this._scrollTick = 0;
    this.SCROLL_FRAMES_PER_ROW = 3;

    // 3-D point cloud state
    this.frame = 0;
    this.wobX = 0;       // [0xAE8]
    this.wobY = 0;       // [0xAEA]
    this.focalX = 7;     // [0xAEC] — animates up to 0x133
    this.focalY = 10;    // [0xAEE] — animates up to 0x100

    // Tracks the screen positions of each brush plotted in the previous
    // frame, so we can erase them this frame (asm 0x334-0x348). Pairs
    // of (x, y) per entry.
    this.prevBrushes = new Int16Array(this.points.length / 3 * 2);
    this.prevBrushCount = 0;
  }

  // Rasterise the full message text (0x0C83..0x1499 in the binary) into
  // one big bitmap, 320 wide × (N×8) tall. Each character is laid out
  // exactly as the asm regen does: 16 pixels wide × 8 tall, with each
  // source-byte's high bit duplicated horizontally (so pixels become
  // 0x00 or 0x3F). 0x7F is treated as a line-break that advances to the
  // next 8-row band, x position reset to 0. 0x7E toggles a colour bank
  // that we encode by writing 0x3F or 0x1F (later the floor projection
  // maps both through the same `(v + cl - 0x3F)` formula, so the colour
  // ramp just shifts).
  _rasterizeAllText(mem) {
    // Start at 0xC86 (= the binary's initial value of [0xAE5], the
    // scroll-text read pointer). Earlier bytes are the trailing "..$"
    // of the DOS print-string "Preparing data...$" that the demo emits
    // at startup — they share memory with the scroll-text region but
    // are not part of the message.
    const text = mem.subarray(fileOf(0xC86), fileOf(0x149A));
    // estimate row count: every 0x7F bumps a row; cap at a generous size
    let lines = 1;
    for (const b of text) if (b === 0x7F) lines++;
    const HCHAR = 8, WCHAR = 16, CHARS_PER_LINE = 20;
    const bmpH = (lines + 4) * HCHAR;
    const bmp = new Uint8Array(W * bmpH);
    let lineY = 0;          // current line's top row in bitmap
    let colX = 0;           // current x within line (in pixels)
    let bank = 0x3F;        // colour magnitude for filled glyph pixels
    for (let i = 0; i < text.length; i++) {
      const b = text[i];
      if (b === 0x7F) { lineY += HCHAR; colX = 0; continue; }
      if (b === 0x7E) { bank = (bank === 0x3F) ? 0x1F : 0x3F; continue; }
      if (b < 0x20 || b > 0x7F) continue;
      if (colX + WCHAR > W) { lineY += HCHAR; colX = 0; }
      const glyph = this.font.subarray((b - 0x20) * 64);
      for (let row = 0; row < HCHAR; row++) {
        const dst = (lineY + row) * W + colX;
        for (let bit = 0; bit < 8; bit++) {
          const v = glyph[row * 8 + bit] ? bank : 0;
          bmp[dst + bit*2 + 0] = v;
          bmp[dst + bit*2 + 1] = v;       // 2× horizontal as in the asm
        }
      }
      colX += WCHAR;
    }
    return bmp;
  }

  // Advance the scroll position — text appears at the nearest scan-line
  // (bottom of the floor band) and is pushed upward toward the horizon
  // over successive frames. We only advance every N frames so each text
  // line stays readable for a few seconds; mod-wrap loops the message.
  stepScrollText() {
    this._scrollTick++;
    if (this._scrollTick >= this.SCROLL_FRAMES_PER_ROW) {
      this._scrollTick = 0;
      const bmpH = (this.textBitmap.length / W) | 0;
      this.scrollPos++;
      if (this.scrollPos >= bmpH) this.scrollPos = 0;  // wrap once message ends
    }
  }

  // ----- perspective floor: project the scroll bitmap onto the screen -----
  // Faithful port of asm 0x2F7-0x332. For each of 64 scan-lines we walk
  // 320 texture samples; di (the screen byte-offset) starts at the LUT's
  // recorded value and advances only when a 16-bit accumulator overflows
  // — so far lines, which have a smaller `step`, cover fewer screen
  // pixels and the same bitmap row gets squeezed toward screen-centre.
  // The pixel formula `texture + cl - 0x3F` paints a gradient backdrop
  // even where the bitmap is empty (cl counts 0x40 → 1 across 64 lines).
  projectFloor() {
    const fb = this.fb;
    const bmp = this.textBitmap;
    const bmpH = (bmp.length / W) | 0;
    const lut = this.perspective;
    const screenBytes = W * H;
    for (let line = 0; line < 64; line++) {
      const cl = 0x40 - line;
      let di = lut[line*2+0];
      const step = lut[line*2+1];
      let acc = 0;

      // Each text row first appears at line 0 (nearest, bottom of band),
      // then moves up toward line 63 (horizon) over successive frames.
      // Negative rawRow → row hasn't entered the visible band yet, so
      // we treat texture as 0 (just the gradient backdrop). Once rawRow
      // ≥ 0 we wrap inside the bitmap via mod.
      const rawRow = this.scrollPos + (63 - line);
      const isBlank = rawRow < 0;
      const bmpBase = isBlank ? 0 : (rawRow % bmpH) * W;

      for (let texX = 0; texX < W; texX++) {
        if (di < screenBytes) {
          const v = isBlank ? 0 : bmp[bmpBase + texX];
          fb[di] = (v + cl - 0x3F) & 0xFF;
        }
        acc += step;
        if (acc >= 0x10000) {     // 16-bit overflow ⇒ advance one screen pixel
          acc -= 0x10000;
          di++;
        }
      }
    }
  }

  // ----- 3D point cloud: project UCL letters with wobble -----
  projectUCL() {
    const pts = this.points;
    const fb = this.fb;
    const noise = this.noise;
    const n = pts.length;

    // STEP 1: erase last frame's brushes (asm 0x334-0x348). The original
    // calls the brush dispatcher with eax=0 — after `dec al; and al,0x3F`
    // that selects the LARGE brush, plotting color 0 (black). We do the
    // same: stomp each previous (x,y) with the 6×6 brush in colour 0.
    {
      const prev = this.prevBrushes;
      const cnt = this.prevBrushCount;
      for (let k = 0; k < cnt; k++) {
        const px = prev[k*2+0], py = prev[k*2+1];
        this.plotBrush(px, py, 0, 0x3F);     // large brush, colour 0
      }
    }

    // tick animation parameters
    const fIdx = this.frame & 0xFF;
    const fNoise = noise[fIdx];
    this.wobX = (this.wobX + (fNoise >> 5)) | 0;
    this.wobY = (this.wobY - ((fNoise >> 5) - 1)) | 0;
    if (this.focalX !== 0x133) this.focalX = Math.min(0x133, this.focalX + 5);
    if (this.focalY !== 0x100) this.focalY = Math.min(0x100, this.focalY + 5);

    // STEP 2: project each point and plot a brush with the depth colour;
    // remember the (x,y) for next frame's erase pass.
    let count = 0;
    const prev = this.prevBrushes;
    for (let i = 0; i < n; i += 3) {
      const x = pts[i+0], y = pts[i+1], z0 = pts[i+2];
      const nx = noise[(this.wobX + x) & 0xFF];
      const ny = noise[(this.wobY + y) & 0xFF];
      const z = ((nx + ny) >> 1) + z0;
      if (z <= 1) continue;
      const sx = ((x * this.focalX / z) | 0) + 160;
      const sy = ((y * this.focalY / z) | 0) + 100;
      let c = (-(((z - 0xFA) >> 3) + 0x82)) & 0xFF;
      const sizeIdx = (c - 1) & 0x3F;
      this.plotBrush(sx, sy, c, sizeIdx);
      prev[count*2+0] = sx;
      prev[count*2+1] = sy;
      count++;
    }
    this.prevBrushCount = count;
    this.frame++;
  }

  // The original brush dispatcher (asm 0x503) picks one of three solid
  // rounded-square shapes based on `(color-1) & 0x3F`:
  //   sizeIdx < 0x26  -> small  4×4
  //   sizeIdx < 0x30  -> medium 5×5
  //   else            -> large  6×6
  // All pixels in a single brush carry the *same* colour byte.
  plotBrush(x, y, c, sizeIdx) {
    let mask, w, h, ox;
    if (sizeIdx < 0x26) {
      // small: .XX. / XXXX / XXXX / .XX.
      mask = [0x6, 0xF, 0xF, 0x6]; w = 4; h = 4;
    } else if (sizeIdx < 0x30) {
      // medium: .XXX. / XXXXX / XXXXX / XXXXX / .XXX.
      mask = [0x0E, 0x1F, 0x1F, 0x1F, 0x0E]; w = 5; h = 5;
    } else {
      // large: .XXXX. / XXXXXX / ... / .XXXX.
      mask = [0x1E, 0x3F, 0x3F, 0x3F, 0x3F, 0x1E]; w = 6; h = 6;
    }
    const fb = this.fb;
    // Clip to the screen so a brush near the edge still draws partially —
    // the original wraps via segment math; we just clip.
    for (let dy = 0; dy < h; dy++) {
      const py = y + dy;
      if (py < 0 || py >= H) continue;
      const row = mask[dy];
      const base = py * W;
      for (let dx = 0; dx < w; dx++) {
        if (!(row & (1 << (w - 1 - dx)))) continue;
        const px = x + dx;
        if (px < 0 || px >= W) continue;
        fb[base + px] = c;            // solid — same colour for every pixel
      }
    }
  }

  // ----- box-blur with -1 decay (post-process trails) -----
  blur() {
    const fb = this.fb;
    // forward pass: down + right + self averaging then -1
    for (let y = 1; y < H - 1; y++) {
      let i = y * W + 1;
      for (let x = 1; x < W - 1; x++, i++) {
        let s = fb[i] + fb[i+1] + fb[i-1] + fb[i+W];
        s >>= 2;
        if (s > 0) s -= 1;
        fb[i] = s;
      }
    }
    // reverse pass: up + left + self
    for (let y = H - 2; y >= 1; y--) {
      let i = y * W + W - 2;
      for (let x = W - 2; x >= 1; x--, i--) {
        let s = fb[i] + fb[i+1] + fb[i-1] + fb[i-W];
        s >>= 2;
        if (s > 0) s -= 1;
        fb[i] = s;
      }
    }
  }

  // ----- blit indexed framebuffer through palette to canvas -----
  blit() {
    const fb = this.fb;
    const pal = this.palette;
    const out = this.imageData.data;
    for (let i = 0, j = 0; i < fb.length; i++, j += 4) {
      const c = fb[i] * 4;
      out[j+0] = pal[c+0];
      out[j+1] = pal[c+1];
      out[j+2] = pal[c+2];
      out[j+3] = 255;
    }
    this.ctx.putImageData(this.imageData, 0, 0);
  }

  frameOnce() {
    this.stepScrollText();
    this.projectFloor();
    this.projectUCL();
    // No per-frame blur: the original only blurs during the exit fade
    // (asm 0x460-0x4C2). The "lighting/shadow" effect around the letters
    // comes from the offscreen buffer never being cleared — wobbling
    // brushes leave trails that visually read as soft halos.
    this.blit();
  }
}

// ---------------------------------------------------------------- bootstrap
async function main() {
  const buf = await (await fetch('UCL-SRC.COM')).arrayBuffer();
  const mem = new Uint8Array(buf);
  if (mem.length !== ORIG_BYTES) {
    console.warn(`unexpected binary size ${mem.length}, expected ${ORIG_BYTES}`);
  }
  const canvas = document.getElementById('screen');
  const ctx = canvas.getContext('2d');
  let demo = new Demo(mem, ctx);

  document.getElementById('reset').addEventListener('click', () => {
    demo = new Demo(mem, ctx);
  });

  // ---- music --------------------------------------------------------
  // Browsers require a user gesture to start an AudioContext, so the
  // music doesn't begin until the user clicks "Sound on" (or anywhere
  // on the page). The scheduler polls every ~25 ms and queues every
  // music tick due within a 120 ms look-ahead — sample-accurate timing
  // even when the JS thread is busy with rendering.
  let music = null;
  let musicTimer = null;
  function startMusic() {
    if (music) return;
    const AC = window.AudioContext || window.webkitAudioContext;
    if (!AC) return;
    const audioCtx = new AC();
    music = new MusicPlayer(mem, audioCtx);
    musicTimer = setInterval(() => music.scheduler(), 25);
    soundBtn.textContent = 'Sound off';
  }
  function stopMusic() {
    if (!music) return;
    clearInterval(musicTimer);
    music.ctx.close();
    music = null; musicTimer = null;
    soundBtn.textContent = 'Sound on';
  }
  const soundBtn = document.getElementById('sound');
  soundBtn.addEventListener('click', () => music ? stopMusic() : startMusic());

  const fpsEl = document.getElementById('fps');
  let lastT = performance.now(), frames = 0, fps = 0;

  function loop(t) {
    demo.frameOnce();
    frames++;
    if (t - lastT > 500) {
      fps = (frames * 1000 / (t - lastT)).toFixed(0);
      fpsEl.textContent = `${fps} fps`;
      lastT = t; frames = 0;
    }
    requestAnimationFrame(loop);
  }
  requestAnimationFrame(loop);
}

main().catch(e => {
  document.body.insertAdjacentHTML('beforeend',
    `<pre style="color:#f88; max-width: 80ch;">${e.stack || e}</pre>`);
});
