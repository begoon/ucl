set shell := ["bash", "-euo", "pipefail", "-c"]

ASM := "UCL-PLAIN.asm"
OUT := "build/UCL-PLAIN.COM"
ORIG := "UCL-expected.bin"

default: check

[doc("Reassemble the disassembly with nasm")]
build:
    mkdir -p build
    nasm -f bin -o {{ OUT }} {{ ASM }}

[doc("Round-trip check: build then cmp against original")]
check: build
    cmp {{ OUT }} {{ ORIG }} && echo "OK  byte-for-byte match ($(wc -c < {{ ORIG }}) bytes)"

[doc("Show a unified hex diff of the two binaries")]
diff: build
    diff -u <(xxd {{ ORIG }}) <(xxd {{ OUT }}) | head -200 || true

[doc("Count differing bytes — useful progress metric")]
bytes-different: build
    cmp -l {{ ORIG }} {{ OUT }} | wc -l | awk '{print $1, "bytes differ"}'

[doc("First N differing offsets in the original (hex)")]
first-diffs N="20": build
    cmp -l {{ ORIG }} {{ OUT }} | head -{{ N }} | awk '{printf "0x%04x: orig=0x%02x built=0x%02x\n", $1-1, strtonum("0"$2), strtonum("0"$3)}'

[doc("Regenerate the all-db baseline (destroys current annotations!)")]
baseline:
    python3 gen_baseline.py {{ ORIG }} {{ ASM }}

[doc("Clean build artefacts")]
clean:
    rm -rf build

[doc("Serve the JS port locally — open http://localhost:8000/docs/")]
serve PORT="8000":
    python3 -m http.server {{ PORT }}

fading-text:
    #!/bin/bash
    python3 -c "
    data = open('dos/UCL-PLAIN.COM','rb').read()
    text = data[0xC86-0x100:0x1485-0x100]
    print(text.replace(b'\x7e', b'').replace(b'\x7f', b'\n').decode('latin-1'))
    " >fading-text.txt
