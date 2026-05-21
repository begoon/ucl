# UCL intro — derivation of `UCL-PLAIN.COM` from `UCL.COM`

This directory contains the original distribution of the **`-UCL- Intr0 by
SkullC0DEr`** DOS intro, plus the tooling needed to recover the unpacked
form from the encrypted/packed original.

## Files

| File          | Size  | Role                                              |
| ------------- | ----- | ------------------------------------------------- |
| `UCL.COM`     | 3966  | Original release: XOR-encrypted, packed payload.  |
| `UCL-PLAIN.COM` | 5798  | Fully unpacked binary, suitable for disassembly.  |
| `decode.c`    | 1094  | C implementation of the XOR/add decryption pass.  |
| `decode.py`   | ~1.5k | Python 3 port of `decode.c`; byte-identical out.  |
| `UNP.EXE`     | 20837 | Ben Castricum's generic DOS executable unpacker.  |

## Derivation chain

`UCL-PLAIN.COM` is a two-step derivative of `UCL.COM`:

```text
UCL.COM  ──[ decode.c / decode.py ]──▶  UCL-DEC.COM  ──[ UNP.EXE ]──▶  UCL-PLAIN.COM
         (XOR/add decryption,                       (PKLITE v1.50,
          same size)                                 expands to 5798 bytes)
```

UNP.EXE identifies the inner packer as **PKLITE V1.50** — i.e. `UCL.COM` is a
PKLITE-compressed COM wrapped in a custom XOR/add encryption layer.

### Why this order, not the reverse

- `decode.c` is hard-wired to `UCL.COM`'s leading `JMP` stub: it dereferences
  the JMP target to find the decryption parameters (`CX`, `DI`, 16-byte XOR
  pad). `UCL-PLAIN.COM` does not start with `JMP`, so the decoder cannot be
  applied to it.
- `UNP.EXE` recognises known packers by signature. `UCL.COM`'s first bytes
  are XOR-encrypted, so UNP cannot identify it directly. Only after
  decryption does the inner self-extractor (a print-stub at offset `0x80`
  followed by a UCL/LZ-style depacker) become visible to UNP.

The same identifying strings — `-UCL- Intr0 by SkullC0DEr`, `Preparing
data...`, `UNITED CRACKERS LEAGUE` — appear in both `UCL-DEC.COM` (scattered
inside the packed payload) and `UCL-PLAIN.COM` (cleanly laid out), confirming
they are the same program at different stages of unwrapping.

## How the decoder works

`UCL.COM` begins with a near `JMP` to a small decryption stub near the end of
the file. `decode.c` simulates the DOS loader by placing the file at
offset `0x100` of a scratch buffer (the COM runtime address inside the PSP
segment), then:

1. Reads the JMP displacement to locate the stub: `jmp = *(u16*)&buf[0x101] +
   3 + 0x100` → **`0x104B`**.
2. Reads decryption parameters from the stub:
   - `CX = 0x0F4B` — number of bytes to decrypt.
   - `DI = 0x106E` — pointer to a 16-byte XOR pad.
3. Iterates `i = 0 .. CX-1` over the body starting at `SI = 0x100`:

   ```text
   buf[SI] = (buf[SI] XOR pad[i AND 0x0F]) + (SI AND 0xFF)
   SI = SI + 1
   ```

4. Patches the leading JMP back to the saved entry word and writes the result
   as `UCL-DEC.COM` (same size, 3966 bytes).

The output is still a packed self-extractor — it has a normal entry point
(`MOV AX,0900; INT 21h` print stub at file offset `0x80`) and a recognisable
packer body that `UNP.EXE` can then unpack.

## Reproduction

### Step 1 — decrypt (either language works)

C path:

```bash
cc decode.c -o decode && ./decode
```

Python path:

```bash
python3 decode.py
```

Both emit the same diagnostics and produce a byte-identical `UCL-DEC.COM`:

```text
Read 0F7E (3966) bytes
Jump 104B
CX = 0F4B, DI = 106E
```

### Step 2 — unpack via UNP.EXE under DOSBox-X

```bash
dosbox-x -c "mount c ." -c "c:" -c "UNP UCL-DEC.COM UCL-PLAIN.COM" -c "exit"
```

The resulting `UCL-PLAIN.COM` (5798 bytes) is the plain binary suitable for
disassembly, and matches the `UCL-PLAIN.COM` shipped in this directory.

### One-shot — `just check`

The bundled `Justfile` runs both steps in a `build/` sandbox and compares
the result against `UCL-PLAIN.COM`:

```bash
just check
```

Expected final line:

```text
OK  UNP(decode.py(UCL.COM)) == UCL-PLAIN.COM (5798 bytes)
```
