#!/usr/bin/env python3
"""Spectral and dynamics analysis of a captured WAV — used to compare
the DOSBox-X reference recording against the JS port's output and
identify what to tune in the OPL2 emulator (per-band energy, RMS
envelope, dominant frequencies, voice onset times).

Reports only aggregate technical characteristics — no melody/note
extraction.
"""
import sys, wave, struct, math, pathlib
import numpy as np

def load_wav(path):
    with wave.open(str(path), 'rb') as w:
        sr = w.getframerate()
        n  = w.getnframes()
        nc = w.getnchannels()
        sw = w.getsampwidth()
        raw = w.readframes(n)
    fmt = {1:'b', 2:'h', 4:'i'}[sw]
    arr = np.array(struct.unpack(f'<{n*nc}{fmt}', raw), dtype=np.float64)
    if nc == 2:
        arr = arr.reshape(-1, 2).mean(axis=1)
    arr /= float(1 << (8*sw - 1))
    return sr, arr

def report(path):
    sr, x = load_wav(path)
    dur = len(x) / sr
    print(f"=== {path}")
    print(f"sample-rate    : {sr} Hz")
    print(f"duration       : {dur:.2f} s, {len(x)} samples, mono")

    # Overall dynamics
    rms = math.sqrt(np.mean(x*x))
    peak = float(np.max(np.abs(x)))
    print(f"global RMS     : {rms:.4f}    ({20*math.log10(rms+1e-12):.1f} dBFS)")
    print(f"global peak    : {peak:.4f}    ({20*math.log10(peak+1e-12):.1f} dBFS)")

    # RMS envelope, 50 ms windows
    win = int(sr * 0.05)
    n_win = len(x) // win
    env = np.sqrt(np.mean(x[:n_win*win].reshape(n_win, win)**2, axis=1))
    # Onset estimate: first window over -30 dBFS
    thr = 10 ** (-30/20)
    onset = next((i for i,v in enumerate(env) if v > thr), None)
    print(f"onset (-30 dB) : {onset*0.05:.2f} s" if onset is not None else "onset          : (never)")

    # Energy bands — FFT once per 0.5 s window, average magnitude per band
    bands = [(0,  120,  "sub  (<120Hz)"),
             (120, 300, "bass (120-300)"),
             (300, 800, "low-mid"),
             (800, 2400,"mid"),
             (2400, 6000,"high-mid"),
             (6000, 16000,"high")]
    seg = int(sr * 0.5)
    n_seg = len(x) // seg
    band_E = np.zeros(len(bands))
    for s in range(n_seg):
        chunk = x[s*seg:(s+1)*seg] * np.hanning(seg)
        spec = np.abs(np.fft.rfft(chunk))
        freqs = np.fft.rfftfreq(seg, 1/sr)
        for i,(lo,hi,_) in enumerate(bands):
            mask = (freqs >= lo) & (freqs < hi)
            band_E[i] += float(np.mean(spec[mask]**2))
    band_E /= n_seg
    total = band_E.sum() + 1e-30
    print("spectral energy distribution:")
    for (lo,hi,name), e in zip(bands, band_E):
        pct = 100 * e / total
        bar = '#' * int(pct / 2)
        print(f"  {name:14s} {pct:5.1f}%  {bar}")

    # Dominant frequency in 4 equal time slices (helps spot which voices
    # are active when in the timeline — without transcribing notes).
    print("dominant freq band per timeline slice (5 slices):")
    slice_n = 5
    sl = len(x) // slice_n
    for i in range(slice_n):
        chunk = x[i*sl:(i+1)*sl]
        if len(chunk) < seg: continue
        chunk = chunk[:len(chunk)//seg*seg].reshape(-1, seg) * np.hanning(seg)
        spec = np.mean(np.abs(np.fft.rfft(chunk, axis=1)), axis=0)
        freqs = np.fft.rfftfreq(seg, 1/sr)
        # mask DC and very-low to avoid the residual offset
        spec[freqs < 30] = 0
        peak_idx = np.argmax(spec)
        t0 = i*sl/sr
        print(f"  {t0:5.1f}-{t0+sl/sr:5.1f} s : peak ~ {freqs[peak_idx]:6.1f} Hz "
              f"(level {20*math.log10(spec[peak_idx]+1e-12):.1f} dBFS-rel)")

if __name__ == "__main__":
    for p in sys.argv[1:]:
        report(pathlib.Path(p))
