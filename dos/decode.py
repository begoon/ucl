#!/usr/bin/env python3
"""Python port of decode.c — strips the XOR/add encryption layer from UCL.COM.

Reads ``UCL.COM`` from the current directory and writes ``UCL-DEC.COM``.
The resulting file is the same size; it is the decrypted self-extractor that
UNP.EXE can then unpack into UCL-SRC.COM.
"""

from pathlib import Path


def u16(buf: bytearray, off: int) -> int:
    return buf[off] | (buf[off + 1] << 8)


def main() -> None:
    data = Path("UCL.COM").read_bytes()
    sz = len(data)

    # Mirror the C layout: 30000-byte scratch buffer, file loaded at
    # offset 0x100 (the COM file's runtime address inside the PSP segment).
    buf = bytearray(30000)
    buf[0x100 : 0x100 + sz] = data

    print(f"Read {sz:04X} ({sz}) bytes")

    jmp = u16(buf, 0x101) + 3 + 0x100
    print(f"Jump {jmp:04X}")

    # Patch the original two-byte JMP at 0x100 with the saved entry word, and
    # restore the third byte — mirrors decode.c lines 20-21.
    entry = u16(buf, jmp + 3)
    buf[0x100] = entry & 0xFF
    buf[0x101] = (entry >> 8) & 0xFF
    buf[0x102] = buf[jmp + 8]

    cx = u16(buf, jmp + 10)
    di = u16(buf, jmp + 13)
    print(f"CX = {cx:04X}, DI = {di:04X}")

    si = 0x100
    for i in range(cx):
        ch = buf[si]
        p = buf[di + (i & 0x0F)]
        ch ^= p
        # matches C: dx = si - 1 right after si++, i.e. the current index
        dx = si
        ch = (ch + (dx & 0xFF)) & 0xFF
        buf[si] = ch
        si += 1

    Path("UCL-DEC.COM").write_bytes(bytes(buf[0x100 : 0x100 + sz]))


if __name__ == "__main__":
    main()
