#!/usr/bin/env python3
"""Convert ndisasm output for the code range into byte-exact nasm source.

Each instruction is emitted as a `db <bytes>` so the encoding is preserved
verbatim (TASM and NASM disagree on a handful of ambiguous reg-reg ops).
The mnemonic from ndisasm rides along as a comment, and branch targets get
proper labels so navigation still works.

Result: re-assembles byte-for-byte while staying human-readable.
"""
import re
import pathlib

HERE        = pathlib.Path(__file__).resolve().parent
NDISASM_OUT = HERE / "initial" / "UCL-SRC.asm"
ASM_PATH    = HERE / "UCL-SRC.asm"

CODE_START = 0x100
CODE_END   = 0x661   # exclusive

BRANCH_OPS = {
    "jmp","call",
    "ja","jae","jb","jbe","jc","jcxz","je","jg","jge","jl","jle","jna",
    "jnae","jnb","jnbe","jnc","jne","jng","jnge","jnl","jnle","jno","jnp",
    "jns","jnz","jo","jp","jpe","jpo","js","jz",
    "loop","loope","loopne","loopnz","loopz",
}

line_re = re.compile(r"^([0-9A-F]{8})\s+([0-9A-F]+)\s+(.*)$")
hex_imm = re.compile(r"0x([0-9a-f]+)")

# --- pass 1: parse ---
insns = []          # (addr, [bytes], mnemonic, operands)
targets = set([CODE_START])
for raw in NDISASM_OUT.read_text().splitlines():
    m = line_re.match(raw)
    if not m: continue
    addr = int(m.group(1), 16)
    if not (CODE_START <= addr < CODE_END): continue
    bs = m.group(2)
    bytes_ = [int(bs[i:i+2], 16) for i in range(0, len(bs), 2)]
    text = m.group(3).strip()
    parts = text.split(None, 1)
    mn = parts[0]
    operands = parts[1] if len(parts) > 1 else ""
    insns.append((addr, bytes_, mn, operands))
    if mn in BRANCH_OPS:
        tm = hex_imm.search(operands)
        if tm:
            targets.add(int(tm.group(1), 16))

# --- pass 2: emit ---
def label(a): return f"L_{a:04x}"

def fmt_comment(mn, operands):
    if not operands:
        return mn
    # rewrite branch operand addresses to label names for readability
    if mn in BRANCH_OPS:
        tm = hex_imm.search(operands)
        if tm:
            tgt = int(tm.group(1), 16)
            operands = operands[:tm.start()] + label(tgt) + operands[tm.end():]
    return f"{mn} {operands}"

emitted = []
for addr, bytes_, mn, operands in insns:
    if addr in targets:
        emitted.append(f"{label(addr)}:")
    byte_str = ",".join(f"0x{b:02x}" for b in bytes_)
    pad = " " * max(0, 30 - len(byte_str))
    emitted.append(f"    db {byte_str}{pad}; {addr:04x}  {fmt_comment(mn, operands)}")

code_block = "\n".join(emitted) + "\n"

# --- pass 3: splice into UCL-SRC.asm ---
asm = ASM_PATH.read_text().splitlines()
db_re = re.compile(r"^\s*db .*; ([0-9a-f]{4})\s*$")
first_idx = last_idx = None
for i, line in enumerate(asm):
    m = db_re.match(line)
    if not m: continue
    a = int(m.group(1), 16)
    if CODE_START <= a < CODE_END:
        if first_idx is None: first_idx = i
        last_idx = i

assert first_idx is not None

# Preserve any trailing bytes of the last `db` line that fall past CODE_END
last_line = asm[last_idx]
m = db_re.match(last_line)
last_line_addr = int(m.group(1), 16)
bytes_on_last = [int(b, 16) for b in re.findall(r"0x([0-9a-f]{2})", last_line)]
overflow = last_line_addr + len(bytes_on_last) - CODE_END
trailing = []
if overflow > 0:
    leftover = bytes_on_last[len(bytes_on_last)-overflow:]
    trailing.append("    db " + ",".join(f"0x{b:02x}" for b in leftover)
                    + f"    ; {CODE_END:04x}")

new_asm = (asm[:first_idx]
           + code_block.rstrip("\n").splitlines()
           + trailing
           + asm[last_idx+1:])
ASM_PATH.write_text("\n".join(new_asm) + "\n")
print(f"emitted {len(insns)} instructions, {len(targets)} labels at lines {first_idx+1}..{last_idx+1}")
