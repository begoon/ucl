#!/usr/bin/env python3
"""Generate an all-`db` baseline .asm from the COM binary.
Output reassembles byte-for-byte by construction; we promote
ranges to real instructions incrementally."""
import sys, pathlib
bin_path = pathlib.Path(sys.argv[1])
asm_path = pathlib.Path(sys.argv[2])
data = bin_path.read_bytes()
out = ["; UCL-SRC.COM round-trip-matching source",
       "; Generated baseline: every byte as `db`.",
       "; Promote spans to real instructions incrementally.",
       "",
       "    cpu 386",
       "    bits 16",
       "    org 0x100",
       ""]
PER_LINE = 16
for i in range(0, len(data), PER_LINE):
    chunk = data[i:i+PER_LINE]
    bytes_str = ",".join(f"0x{b:02x}" for b in chunk)
    out.append(f"    db {bytes_str}    ; {0x100+i:04x}")
asm_path.write_text("\n".join(out) + "\n")
print(f"wrote {asm_path} ({len(data)} bytes baseline)")
