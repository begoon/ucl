# UCL-SRC.COM — reverse-engineering notes for a JS reimplementation

DOS COM file, 5798 bytes (0x16A6). Origin 0x100 (CS=DS=ES=SS=PSP). Released
03-03-96 by "SkullCODEr" / United Crackers League. The greeting it `int 21h`-prints
identifies itself as "-UCL- Intr0 by SkullC0DEr".

Important correction: the music driver is **AdLib / OPL2 FM synthesis** (writes to
ports `0x388 / 0x389`), not General MIDI. Re-implementing in JS you'd use a Web
Audio FM model, or run an OPL2 emulator (e.g. `opl3.js`) and feed it the same
register sequence.

## Memory map of the binary

| Range            | Purpose                                                           |
|------------------|-------------------------------------------------------------------|
| `0x100 – 0x65F`  | Code                                                              |
| `0x661 – 0x669`  | 9 bytes: per-channel "ticks until next event" countdown           |
| `0x66A – 0x683`  | OPL2 frequency table (F-number low+high for one octave, 12 notes) |
| `0x684 – 0x68C`  | OPL2 patch parameters (per-channel timbre bytes)                  |
| `0x68D – 0x6EB`  | 9 song-pointer words + per-channel state                          |
| `0x6EC – 0xABF`  | Song data — 9 streams of `note,duration` bytes (see ISR)          |
| `0xAC0`          | "Frames until next music tick" countdown for timer ISR            |
| `0xAC1 – 0xAE2`  | Timer interrupt service routine (`int 08h` handler)               |
| `0xAE3 / 0xAE5`  | Word vars: scroll-bitmap write ptr / scroll-text read ptr         |
| `0xAE8 / 0xAEA`  | Word vars: noise-driven X/Y wobble offsets for UCL flag           |
| `0xAEC / 0xAEE`  | Word vars: dynamic X/Y "focal length" (perspective scale)         |
| `0xAF0`          | Frame counter (drives [[noise-table]] index)                      |
| `0xAF1 – 0xC57`  | Packed bitmap of the UCL letters (40 × 9 × 8 bits)                |
| `0xC59 – 0xC82`  | DOS string "-UCL- Intr0 by SkullC0DEr\r\nPreparing data...$"      |
| `0xC83 – 0x1484` | Scroll-text body (greets + member list)                           |
| `0x1485 – 0x1499`| Final "loop forever" scroll fragment (`~{\|}}+*%…`)               |
| `0x149A – 0x1799`| Packed 8×8 font, 96 glyphs × 8 bytes (chars 0x20-0x7F)            |
| `0x179A – 0x179B`| Word: end-of-bitmap pointer for scroll-text wraparound test       |
| `0x179C – 0x179F`| Word: palette-shift toggle / misc state                           |
| `0x17A0 – 0x17A5`| 6 bytes: LFSR / random-state header                               |
| `0x17A6 – ...`   | (Code generates noise table at runtime to `0x1B9E` — see below)   |

Within DOS COM layout the program also uses two extra 64 KB segments above the
PSP: `ES = DS + 0x1000` (the offscreen render buffer that becomes the source for
the post-processing blur and the VGA blit) and `GS = DS + 0x2000` (a second
double-buffer used in the screen copy).

## Initialisation walk-through (`0x100 – 0x25C`)

1. `int 21h ah=9` — print the "Preparing data…" banner.
2. **Noise/sine table generation** at `0x107 – 0x138`. A 32-bit LFSR-ish
   recurrence runs 0xFE iterations:
   ```
   eax = signed_high32(state[i-1] * 0x7FF62182) - state[i-2]
   state[i] = eax
   noise[i] = (eax >> 0x17) as byte   // ~9-bit-scaled "smooth random"
   ```
   producing a 254-byte wraparound noise table at `0x1B9E`. This is the wave
   used to wobble the UCL flag and the credit-frame "drunken" motion.
3. **Font unpack** at `0x13A – 0x156`. Reads 0x300 source bytes from `0x149A`,
   expands each bit into a byte (`0x00` or `0x3F`) at `0x1C9E`. Result: 96
   glyphs × 8 rows × 8 columns = 6144 bytes of an 8-bpp font where pixel
   value is brightness (`0x3F` ≈ palette index for bright).
4. **Build perspective-step LUT** at `0x157 – 0x172`. 64 entries of (dx, bx)
   pairs decremented per iteration. Used as Bresenham-style increments when
   stretching one row of the scroll-text bitmap onto a perspective-rotated
   trapezoid (this is the "starship text into infinity" effect — actually a
   row-by-row textured floor cast).
5. **Build `y * 320` row-offset LUT** at `0x174 – 0x182`, 200 entries at
   `0x499E` (classic mode 13h row table for fast plotting).
6. **Unpack UCL letter point cloud** at `0x184 – 0x1CC`. The packed bitmap at
   `0xAF1` is read as 40 rows × 9 cols × 8 bits. For every set bit it writes a
   six-byte 3-D point `(x, y, z)` to `0x4B2E`:
   ```
   x = (col*8 + bit) * 3 - 0x6C        // ≈ -108..+108  (centered)
   y = row * 3 - 0x5A                  // ≈  -90..+27
   z = 0x17C                           // = 380 (initial depth)
   ```
   Point count is saved to `[0x629E]` for the inner loop.
7. **Reprogram PIT channel 0** at `0x1D0 – 0x1DE` to mode 3, divisor 0xFFFF —
   slowest tick (~18.2 Hz default but the demo uses the IRQ mainly to step
   the music; rendering is decoupled and runs unsynchronised in the main
   loop).
8. **Init AdLib** at `0x1DF` (`call 0x597`) — see music section below.
9. **Hook `int 08h`** at `0x1E2 – 0x1F5` to the routine at `0xAC1`.
10. **Set up two extra video buffers** at `0x1F7 – 0x21A`: zero 0x3E80 dwords
    at `ES:0` (= 64000 bytes — exactly one mode-13h frame) and 0x1400 dwords
    at `GS:0` (another buffer used during composition).
11. **Enter mode 13h** (`int 10h ax=0x13`).
12. **Program the VGA palette** at `0x220 – 0x259`. Three ramps written via
    `0x3C8/0x3C9`:
    * Entries `0x00 – 0x3F`: dim-to-bright red ramp (R increments, G/B stay 0)
    * Entries `0x40 – 0x7F`: green ramp with rising R
    * Entries `0x80 – 0xFF`: blue/grey ramp
    These 3 64-entry ramps drive the three logical "layers" (UCL flag, scroll
    text, credit frame) — see "Pixel value semantics" below.
13. `sti`, set `[0xABF]=1` (master "run" flag for the ISR), fall into the
    main loop at `0x262`/`0x293`.

## Main render loop (`0x262 – 0x403`)

This is one frame. Reading top-down:

### A. Copy "render texture" into a backbuffer (`0x262 – 0x275`)

```
ES ← GS (and swap with old ES); DS ← GS
rep movsd 0x1400  ; 20480 dwords = 80 KB ... actually only top portion
```
Effectively this clears the working buffer for this frame and pulls the
previous frame's content forward — used by the trailing blur at `0x460`.

### B. Scroll text rasterisation (`0x276 – 0x2E2`)

Source: ASCII characters in the credit body. Render target: a tall (16-row)
ring buffer of 320-pixel rows starting at `0x349E` in DS, indexed by the
running pointer `[0xAE3]`.

```
si = [0xAE3]                ; circular bitmap-write head
copy 0x50 dwords (= 320 bytes) from si → 0x4EC0   ; this row goes into the
                                                   ; perspective texture
[0xAE3] += 320              ; advance one row
if (si - 0x349E) == [0x179C]:    ; full pass through text done
    si = 0x349E                  ; reset bitmap head
    [0xAE3] = 0x349E
    zero 0x500 dwords from 0x349E        ; clear bitmap ring
    si = [0xAE5]                          ; current text read ptr
    foreach char c = lodsb until c == 0x7F (end-of-text):
        if c == 0x7E:                     ; '~' → toggle color attribute
            [0x179C] ^= 0x1E00
            continue
        c -= 0x20
        glyph = 0x1C9E + c*0x40            ; 64-byte expanded glyph (8×8)
        for col = 0..7:
            blit one column of 8 bytes into the bitmap, advance write head
            by 2 (so glyph pixels straddle two screen columns)
        advance to next char column with a +0x130 gap
    if si reached 0x149A:  si = 0x1485   ; loop the final UCL bracket forever
    [0xAE5] = si
```

So the text is **pre-rasterised one new column-strip per frame** into a
20-row × 320-col ring bitmap; rendering each frame just needs to project the
ring through the perspective table.

### C. Perspective-project the scroll bitmap (`0x2F7 – 0x332`)

64 horizontal rows, each scaled by the precomputed LUT at `0x489E`:

```
si = 0x4EC0   ; latest row of scroll bitmap
bp = 0x489E   ; perspective LUT
for row = 0..63:
    di = lut[row].x_offset                ; screen X start
    bx = lut[row].x_step                  ; fixed-point per-pixel step
    bp_fixed = 0
    for col = 0..319:
        al = gs:[si + col]                ; sample texture
        al = (al + cl - 0x3F)             ; depth-fade
        es:[di] = al                      ; plot
        bp_fixed += bx
        di += carry
    si -= 320                              ; previous bitmap row
    bp += 2
```

Result: the text bitmap appears as a floor stretching to a vanishing point
above the visible area — the classic "Star Wars" effect, here used for
credit text.

### D. UCL flag rendering — fake 3-D point cloud with wave wobble (`0x334 – 0x3BF`)

Outer loop runs `[0x629E]` times (number of "on" pixels in the UCL bitmap).
For every 3-D point `(dx, bx, dz)` stored at `0x4B2E` (6 bytes per point):

```
; sin/sin wobble using the noise table at 0x1B9E
bp_idx = ([0xAE8] + dx) & 0xFF
di_idx = ([0xAEA] + bx) & 0xFF
bp = signed_noise[bp_idx]
di = signed_noise[di_idx]
z' = bp + di + point.z              ; perturbed depth

; perspective divide
sx = (dx * [0xAEC]) / z' + 0xA0     ; centre at x=160
sy = (bx * [0xAEE]) / z' + 0x64     ; centre at y=100

screen_offset = row_lut[sy] + sx

; depth → color
color = -(((z' - 0xFA) >> 3) + 0x82)   ; nearer ⇒ darker red ramp

; *** scatter-plot the pixel with a glyph-shaped brush (call 0x503) ***
plot_brush(es:[screen_offset], color)

; per-frame motion update for the wave
[0xAE8] += (signed_noise[frame] >> 5)
[0xAEA] -= (signed_noise[frame] >> 5) - 1
frame = ++[0xAF0]

; "breathing" focal length — animates until it locks
if [0xAEC] != 0x133:  [0xAEC] += 5
if [0xAEE] != 0x100:  [0xAEE] += 5
```

The `call 0x503` brush is a small dispatcher that smears the pixel into a
3×3 / 5×4 / 5×3 block (see `0x503 – 0x596`) depending on its depth bucket —
this gives the letters the "fat 3-D blocks" appearance instead of one screen
pixel per UCL bitmap bit.

### E. Post-process blur + blit (`0x460 – 0x4C2`, helper `0x4E1`)

After every UCL+scroll frame is drawn into the `ES` backbuffer:

```
; box-blur two passes (top-down and bottom-up) over 64000 pixels
for di = 0..63935:
    a = ES:[di+1] + ES:[di-1] + ES:[di+320]   ; 3-tap horizontal+down
    a = (a + ES:[di]) >> 2
    if a != 0: a -= 1                          ; persistent decay
    ES:[di] = a
; second pass uses [di-320] (upward) — vertical motion-blur trail
```

Then `0x4E1` waits for VGA vertical retrace by spin-reading the input-status
register at `0x3DA` bit 3, and `0x4EE` does `rep movsd 0x3E80` to copy the
64 KB backbuffer to `0xA000:0000` (real VGA RAM) — single straight blit, no
fancy page flip.

The blur decay also doubles as the "fade out at the bottom" you see under
the scrolling text — pixels that aren't being plotted each frame get
darkened by 1 every two passes and eventually reach palette index 0.

### F. Exit (`0x404 – 0x4E0`)

Reads keyboard scan code from port `0x60`, exits on ESC (scan code `0x01`).
Exit path:

* Restores `int 08h` from the saved old handler at `[0x6A70/0x6A72]`.
* Calls `0x597` again to silence AdLib (zeros all key-on bits).
* `int 10h ax=0x03` returns to text mode.

The "shutdown" path between exit detection and the actual mode-3 switch
includes an unusual `out`-loop at `0x40E – 0x41D`: it converts the final
frame to grayscale-with-bit-6-set, presumably to bleach the screen white
before fading. Plus a palette wipe at `0x41F – 0x45E` that walks the palette
to gradually fade everything to black, polling vsync between iterations. Not
strictly necessary in a JS port but it's a nice touch.

## AdLib OPL2 music driver (`0x597 – 0x65F` + ISR at `0xAC1`)

### Init `0x597`

Writes a hand-crafted patch program to the OPL2 chip, channel by channel:

* Register `0x20+op` — modulator characteristics (multiplier, vibrato, KSR)
* Register `0xBD` — rhythm/AM/VIB/dep flags
* `0x40+op`, `0x60+op`, `0x80+op`, `0xE0+op` — level / attack-decay /
  sustain-release / waveform select per operator (the bytes used as `bx`
  offsets into table at `0x684` are exactly the per-channel timbres)
* `0xA0+ch`, `0xB0+ch` — F-number low/high (note pitch) zeroed
* `0xC0+ch` — feedback/connection

The 7-NOP delay (`call 0x64C` with `cx=7` then `cl=0x30`) is the standard
OPL2 "write status latency" wait.

### Per-frame music step `0x5DB` (called from ISR)

Iterates 9 channels. For each channel:

```
1. Decrement [0x661 + ch] (per-channel duration left).
2. If still > 0: keep playing, continue.
3. Otherwise read next byte from song pointer:
     - 0x00            → channel finished; load next pointer from buffer+2
                         (rewind / loop)
     - bit7 set        → al & 0x7F is "duration override" with sign bit, stored.
     - else            → it's a packed note byte:
                            note  = al & 0x0F             (0..11 = chromatic)
                            extra = (al >> 2) & 0xFC      (octave block bits)
                            send "key off" to channel (0xB0+ch ← 0)
                            f_number = note_table[note]    ; from 0x66A
                            send 0xA0+ch ← low(f_number)
                            send 0xB0+ch ← high(f_number) | extra | 0x20  (key on)
4. Save updated read pointer back to [di].
```

### Timer ISR `0xAC1`

```
push ax / push ds; ds = cs
if [0xABF]:                       ; demo running flag
   if --[0xAC0] == 0:
      [0xAC0] = 2                 ; advance music every 2 timer ticks (~9 Hz)
      pusha; call 0x5DB; popa     ; step all 9 channels
out 0x20, 0x20                    ; EOI to PIC
iret
```

### Song format summary

Nine independent byte streams at `0x6EC..0xABF`. Each stream is a list of
events:

```
byte b:
  b == 0x00  → end-of-stream / loop
  b & 0x80   → set "duration = (b & 0x7F)" for following notes
  else       → note-on event encoding pitch + octave (see above), takes
               effect immediately; duration uses the most recent override
```

So a JS port can dump the 9 streams once at startup and feed them to any
OPL2 emulator at 9 Hz.

## Pixel value semantics (matters for JS palette)

Because the palette is split into three 64-entry ramps, the renderer uses
the high two bits of the colour byte to choose which "layer" the pixel
belongs to:

* `0x00 – 0x3F` — UCL flag (red ramp; depth-shaded)
* `0x40 – 0x7F` — credit text floor (green-ramp on red base)
* `0x80 – 0xBF` — credit-frame highlights (blue-ramp)
* `0xC0 – 0xFF` — exit fade (gray/white)

The `add al, cl` and `add al, 0x40 / 0x80` operations you see scattered
through the rendering code are picking which ramp a given pixel falls into.
When porting to JS, the easiest replication is: keep a 256-entry RGBA
palette table and look up per pixel exactly as the original does — don't
try to compute the colour from a formula or you'll mismatch the ramps.

## Suggested JS port architecture

1. **One static palette** of 256 RGB triples, reproduced from the three
   ramps in `0x220 – 0x259`.
2. **One 320×200 `Uint8ClampedArray`** as the indexed framebuffer; convert
   to RGBA into an `ImageData` once per frame.
3. **Two precomputed tables**:
   * `noise[256]` from the LFSR recurrence (or just bake the bytes once
     and ship them as a `Uint8Array` literal — they're deterministic).
   * `perspective[64] = {x0, xStep}` for the scroll-text floor.
4. **Three render passes per frame**, in this order:
   * Step the scroll-text bitmap ring (one column per frame is enough).
   * For each row 0..63, sample the bitmap with the per-row x-step into
     the framebuffer.
   * For each 3-D point of UCL: wobble z with noise[(x+ox)&0xFF] +
     noise[(y+oy)&0xFF], perspective-project, plot a 3×3 / 5×4 brush
     into the framebuffer with depth-shade.
5. **Post-process blur** (the same 3-tap recurrence) — this is what gives
   everything the painterly trail and is structurally important to the
   feel, not optional.
6. **Audio**: either drop in `opl3.js` and feed it the same OPL2 register
   writes, or port the patch + song to Web Audio with FM-OP graphs.
7. **Timing**: don't try to emulate the 18.2 Hz PIT — drive everything off
   `requestAnimationFrame` and step the music every (frame_dt * 9) ms.

## Strings inside the binary (verbatim, for the scroll)

The scroll-text body — including the ASCII-art UCL logo (drawn with the
custom glyphs `{ | } * + % ~`), the member greets, and the credits — lives
at `0xC83 – 0x1499`. The "~" character is treated as an in-band escape
that toggles `[0x179C] ^= 0x1E00` (a colour-attribute flip), so each `~`
in the message switches the text colour between two ramp shades. The
demo's literal exit string "C U l8!" is at the end of the body, before
the looping closing-bracket fragment.

## File offsets relative to file vs. memory addresses

The COM file loads at CS:0x100, so for hex-edit purposes:

```
file_offset = mem_addr - 0x100
```

(e.g. the song data starts at file offset `0x6EC - 0x100 = 0x5EC`).
