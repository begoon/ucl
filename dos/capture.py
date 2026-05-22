#!/usr/bin/env python3
"""Open the DOS demo in DOSBox-X for `DURATION` seconds, leaving the
window visible so the user can click `Capture → Wave Output → Start`
the moment it appears. DOSBox-X auto-exits after the time limit and
flushes the WAV; this script then copies it to dos/build/reference.wav.

Usage:
    python3 capture.py [seconds]    # default 35
"""
import os, sys, subprocess, shutil, pathlib

HERE = pathlib.Path(__file__).resolve().parent
DURATION = int(sys.argv[1]) if len(sys.argv) > 1 else 35

SANDBOX = HERE / "build" / "capture-run"
if SANDBOX.exists(): shutil.rmtree(SANDBOX)
SANDBOX.mkdir(parents=True)
shutil.copy(HERE / "UCL-PLAIN.COM", SANDBOX / "UCL.COM")
(SANDBOX / "capture").mkdir()
conf = (HERE / "capture.conf").read_text().replace("mount c .", f"mount c {SANDBOX}")
conf_path = SANDBOX / "capture.conf"
conf_path.write_text(conf)

print("DOSBox-X will open. As soon as it does, click:")
print("    Capture → Wave Output → Start")
print(f"It will auto-exit after {DURATION} seconds.\n")
subprocess.run(
    ["dosbox-x", "-conf", str(conf_path),
     "-nogui", "-nopromptfolder", "-fastlaunch",
     "-time-limit", str(DURATION)],
    cwd=SANDBOX,
)

wavs = sorted((SANDBOX / "capture").glob("*.wav"))
if not wavs:
    print("\nNo WAV produced — did you click Capture → Wave Output → Start?", file=sys.stderr)
    sys.exit(1)
dest = HERE / "build" / "reference.wav"
shutil.copy(wavs[-1], dest)
print(f"\nCaptured {dest.stat().st_size} bytes → {dest}")
