00000100  B409              mov ah,0x9
00000102  BA590C            mov dx,0xc59
00000105  CD21              int byte 0x21
00000107  BFA617            mov di,0x17a6
0000010A  BEA01B            mov si,0x1ba0
0000010D  C744FE0206        mov word [si-0x2],0x602
00000112  B9FE00            mov cx,0xfe
00000115  66BB8221F67F      mov ebx,0x7ff62182
0000011B  668B45FC          mov eax,[di-0x4]
0000011F  66F7EB            imul ebx
00000122  660FACD01E        shrd eax,edx,byte 0x1e
00000127  662B45F8          sub eax,[di-0x8]
0000012B  66AB              stosd
0000012D  6650              push eax
0000012F  66C1F817          sar eax,byte 0x17
00000133  8804              mov [si],al
00000135  46                inc si
00000136  6658              pop eax
00000138  E2E5              loop 0x11f
0000013A  BE9A14            mov si,0x149a
0000013D  BF9E1C            mov di,0x1c9e
00000140  BA0003            mov dx,0x300
00000143  AC                lodsb
00000144  8AE0              mov ah,al
00000146  B90800            mov cx,0x8
00000149  32C0              xor al,al
0000014B  D0E4              shl ah,0x0
0000014D  7302              jnc 0x151
0000014F  B03F              mov al,0x3f
00000151  AA                stosb
00000152  E2F5              loop 0x149
00000154  4A                dec dx
00000155  75EC              jnz 0x143
00000157  BF9E48            mov di,0x489e
0000015A  B140              mov cl,0x40
0000015C  BBFFFF            mov bx,0xffff
0000015F  BAC0F8            mov dx,0xf8c0
00000162  8915              mov [di],dx
00000164  895D02            mov [di+0x2],bx
00000167  83C704            add di,0x4
0000016A  81EA3F01          sub dx,0x13f
0000016E  81EB9A01          sub bx,0x19a
00000172  E2EE              loop 0x162
00000174  BF9E49            mov di,0x499e
00000177  B1C8              mov cl,0xc8
00000179  33DB              xor bx,bx
0000017B  B84001            mov ax,0x140
0000017E  F7E3              mul bx
00000180  AB                stosw
00000181  43                inc bx
00000182  E2F7              loop 0x17b
00000184  BEF10A            mov si,0xaf1
00000187  BF2E4B            mov di,0x4b2e
0000018A  33ED              xor bp,bp
0000018C  32ED              xor ch,ch
0000018E  32C9              xor cl,cl
00000190  32D2              xor dl,dl
00000192  AC                lodsb
00000193  8AF0              mov dh,al
00000195  D0E6              shl dh,0x0
00000197  721E              jc 0x1b7
00000199  8AC1              mov al,cl
0000019B  C0E003            shl al,byte 0x3
0000019E  02C2              add al,dl
000001A0  B403              mov ah,0x3
000001A2  F6E4              mul ah
000001A4  2D6C00            sub ax,0x6c
000001A7  AB                stosw
000001A8  8AC5              mov al,ch
000001AA  B403              mov ah,0x3
000001AC  F6E4              mul ah
000001AE  2D5A00            sub ax,0x5a
000001B1  AB                stosw
000001B2  B87C01            mov ax,0x17c
000001B5  AB                stosw
000001B6  45                inc bp
000001B7  FEC2              inc dl
000001B9  80FA08            cmp dl,0x8
000001BC  75D7              jnz 0x195
000001BE  FEC1              inc cl
000001C0  80F909            cmp cl,0x9
000001C3  75CB              jnz 0x190
000001C5  FEC5              inc ch
000001C7  80FD28            cmp ch,0x28
000001CA  75C2              jnz 0x18e
000001CC  892E9E62          mov [0x629e],bp
000001D0  FA                cli
000001D1  B036              mov al,0x36
000001D3  E643              out byte 0x43,al
000001D5  B0FF              mov al,0xff
000001D7  EB00              jmp 0x1d9
000001D9  E640              out byte 0x40,al
000001DB  EB00              jmp 0x1dd
000001DD  E640              out byte 0x40,al
000001DF  E8B503            call 0x597
000001E2  B80835            mov ax,0x3508
000001E5  CD21              int byte 0x21
000001E7  891E706A          mov [0x6a70],bx
000001EB  8C06726A          mov word [0x6a72],es
000001EF  BAC10A            mov dx,0xac1
000001F2  B80825            mov ax,0x2508
000001F5  CD21              int byte 0x21
000001F7  8CD8              mov ax,ds
000001F9  050010            add ax,0x1000
000001FC  8EC0              mov es,ax
000001FE  050010            add ax,0x1000
00000201  8EE8              mov gs,ax
00000203  B9803E            mov cx,0x3e80
00000206  6633C0            xor eax,eax
00000209  8BF8              mov di,ax
0000020B  F366AB            rep stosd
0000020E  06                push es
0000020F  0FA8              push gs
00000211  07                pop es
00000212  B90014            mov cx,0x1400
00000215  8BF8              mov di,ax
00000217  F366AB            rep stosd
0000021A  07                pop es
0000021B  B81300            mov ax,0x13
0000021E  CD10              int byte 0x10
00000220  BAC803            mov dx,0x3c8
00000223  33C0              xor ax,ax
00000225  EE                out dx,al
00000226  42                inc dx
00000227  B94000            mov cx,0x40
0000022A  86C4              xchg al,ah
0000022C  EE                out dx,al
0000022D  86C4              xchg al,ah
0000022F  EE                out dx,al
00000230  EE                out dx,al
00000231  FEC0              inc al
00000233  8AD8              mov bl,al
00000235  80E301            and bl,0x1
00000238  02E3              add ah,bl
0000023A  E2EE              loop 0x22a
0000023C  B140              mov cl,0x40
0000023E  33C0              xor ax,ax
00000240  EE                out dx,al
00000241  EE                out dx,al
00000242  86C4              xchg al,ah
00000244  EE                out dx,al
00000245  86C4              xchg al,ah
00000247  FEC4              inc ah
00000249  8ADC              mov bl,ah
0000024B  80E301            and bl,0x1
0000024E  02C3              add al,bl
00000250  E2EE              loop 0x240
00000252  33C0              xor ax,ax
00000254  B180              mov cl,0x80
00000256  EE                out dx,al
00000257  EE                out dx,al
00000258  EE                out dx,al
00000259  E2FB              loop 0x256
0000025B  FB                sti
0000025C  FE06BF0A          inc byte [0xabf]
00000260  EB31              jmp 0x293
00000262  06                push es
00000263  1E                push ds
00000264  0FA8              push gs
00000266  0FA8              push gs
00000268  1F                pop ds
00000269  07                pop es
0000026A  33FF              xor di,di
0000026C  BE4001            mov si,0x140
0000026F  B90014            mov cx,0x1400
00000272  F366A5            rep movsd
00000275  1F                pop ds
00000276  2E8B36E30A        mov si,[cs:0xae3]
0000027B  BFC04E            mov di,0x4ec0
0000027E  B95000            mov cx,0x50
00000281  F366A5            rep movsd
00000284  07                pop es
00000285  8936E30A          mov [0xae3],si
00000289  81EE9E34          sub si,0x349e
0000028D  3B369C17          cmp si,[0x179c]
00000291  7564              jnz 0x2f7
00000293  BE9E34            mov si,0x349e
00000296  8936E30A          mov [0xae3],si
0000029A  56                push si
0000029B  6633C0            xor eax,eax
0000029E  B90005            mov cx,0x500
000002A1  668904            mov [si],eax
000002A4  83C604            add si,0x4
000002A7  49                dec cx
000002A8  75F7              jnz 0x2a1
000002AA  5F                pop di
000002AB  8B36E50A          mov si,[0xae5]
000002AF  AC                lodsb
000002B0  3C7F              cmp al,0x7f
000002B2  7436              jz 0x2ea
000002B4  3C7E              cmp al,0x7e
000002B6  742C              jz 0x2e4
000002B8  B90800            mov cx,0x8
000002BB  2C20              sub al,0x20
000002BD  0FB6E8            movzx bp,al
000002C0  C1E506            shl bp,byte 0x6
000002C3  57                push di
000002C4  B308              mov bl,0x8
000002C6  3E8A869E1C        mov al,[ds:bp+0x1c9e]
000002CB  45                inc bp
000002CC  8AE0              mov ah,al
000002CE  8905              mov [di],ax
000002D0  83C702            add di,0x2
000002D3  FECB              dec bl
000002D5  75EF              jnz 0x2c6
000002D7  81C73001          add di,0x130
000002DB  49                dec cx
000002DC  75E6              jnz 0x2c4
000002DE  5F                pop di
000002DF  83C710            add di,0x10
000002E2  EBCB              jmp 0x2af
000002E4  81369C17001E      xor word [0x179c],0x1e00
000002EA  81FE9A14          cmp si,0x149a
000002EE  7503              jnz 0x2f3
000002F0  BE8514            mov si,0x1485
000002F3  8936E50A          mov [0xae5],si
000002F7  B94000            mov cx,0x40
000002FA  BEC04E            mov si,0x4ec0
000002FD  BD9E48            mov bp,0x489e
00000300  BA4001            mov dx,0x140
00000303  33FF              xor di,di
00000305  3E8B7E00          mov di,[ds:bp+0x0]
00000309  83C502            add bp,0x2
0000030C  3E8B5E00          mov bx,[ds:bp+0x0]
00000310  56                push si
00000311  55                push bp
00000312  BD0000            mov bp,0x0
00000315  658A04            mov al,[gs:si]
00000318  46                inc si
00000319  02C1              add al,cl
0000031B  2C3F              sub al,0x3f
0000031D  268805            mov [es:di],al
00000320  03EB              add bp,bx
00000322  83D700            adc di,0x0
00000325  4A                dec dx
00000326  75ED              jnz 0x315
00000328  5D                pop bp
00000329  5E                pop si
0000032A  81EE4001          sub si,0x140
0000032E  83C502            add bp,0x2
00000331  49                dec cx
00000332  75CC              jnz 0x300
00000334  8B0E9A17          mov cx,[0x179a]
00000338  BEA062            mov si,0x62a0
0000033B  6633C0            xor eax,eax
0000033E  8B3C              mov di,[si]
00000340  83C602            add si,0x2
00000343  E8BD01            call 0x503
00000346  49                dec cx
00000347  75F5              jnz 0x33e
00000349  8B0E9E62          mov cx,[0x629e]
0000034D  BE2E4B            mov si,0x4b2e
00000350  BBA062            mov bx,0x62a0
00000353  53                push bx
00000354  8B14              mov dx,[si]
00000356  8B5C02            mov bx,[si+0x2]
00000359  8B2EE80A          mov bp,[0xae8]
0000035D  8B3EEA0A          mov di,[0xaea]
00000361  03EA              add bp,dx
00000363  03FB              add di,bx
00000365  81E5FF00          and bp,0xff
00000369  81E7FF00          and di,0xff
0000036D  3E0FBEAE9E1B      movsx bp,byte [ds:bp+0x1b9e]
00000373  0FBEBD9E1B        movsx di,byte [di+0x1b9e]
00000378  03EF              add bp,di
0000037A  D1FD              sar bp,0x0
0000037C  036C04            add bp,[si+0x4]
0000037F  83C606            add si,0x6
00000382  A1EC0A            mov ax,[0xaec]
00000385  F7EA              imul dx
00000387  F7FD              idiv bp
00000389  05A000            add ax,0xa0
0000038C  50                push ax
0000038D  A1EE0A            mov ax,[0xaee]
00000390  F7EB              imul bx
00000392  F7FD              idiv bp
00000394  056400            add ax,0x64
00000397  8BD8              mov bx,ax
00000399  5A                pop dx
0000039A  D1E3              shl bx,0x0
0000039C  8BBF9E49          mov di,[bx+0x499e]
000003A0  03FA              add di,dx
000003A2  5B                pop bx
000003A3  893F              mov [bx],di
000003A5  83C302            add bx,0x2
000003A8  8BC5              mov ax,bp
000003AA  2DFA00            sub ax,0xfa
000003AD  C1E803            shr ax,byte 0x3
000003B0  0482              add al,0x82
000003B2  F6D8              neg al
000003B4  8AE0              mov ah,al
000003B6  50                push ax
000003B7  50                push ax
000003B8  6658              pop eax
000003BA  E84601            call 0x503
000003BD  49                dec cx
000003BE  7593              jnz 0x353
000003C0  81EBA062          sub bx,0x62a0
000003C4  D1EB              shr bx,0x0
000003C6  891E9A17          mov [0x179a],bx
000003CA  A0F00A            mov al,[0xaf0]
000003CD  FEC0              inc al
000003CF  A2F00A            mov [0xaf0],al
000003D2  0FB6D8            movzx bx,al
000003D5  8A879E1B          mov al,[bx+0x1b9e]
000003D9  C0F805            sar al,byte 0x5
000003DC  0006E80A          add [0xae8],al
000003E0  FEC8              dec al
000003E2  2806EA0A          sub [0xaea],al
000003E6  B80500            mov ax,0x5
000003E9  813EEC0A3301      cmp word [0xaec],0x133
000003EF  7404              jz 0x3f5
000003F1  0106EC0A          add [0xaec],ax
000003F5  813EEE0A0001      cmp word [0xaee],0x100
000003FB  7404              jz 0x401
000003FD  0106EE0A          add [0xaee],ax
00000401  E8DD00            call 0x4e1
00000404  E460              in al,byte 0x60
00000406  247F              and al,0x7f
00000408  3C01              cmp al,0x1
0000040A  0F8554FE          jnz 0x262
0000040E  B900FA            mov cx,0xfa00
00000411  268A05            mov al,[es:di]
00000414  3C80              cmp al,0x80
00000416  7202              jc 0x41a
00000418  B000              mov al,0x0
0000041A  0C40              or al,0x40
0000041C  AA                stosb
0000041D  E2F2              loop 0x411
0000041F  E8BF00            call 0x4e1
00000422  BAC803            mov dx,0x3c8
00000425  33C0              xor ax,ax
00000427  EE                out dx,al
00000428  42                inc dx
00000429  33DB              xor bx,bx
0000042B  B93F00            mov cx,0x3f
0000042E  8AC4              mov al,ah
00000430  EE                out dx,al
00000431  8AC3              mov al,bl
00000433  EE                out dx,al
00000434  8AC7              mov al,bh
00000436  EE                out dx,al
00000437  FEC4              inc ah
00000439  E2F3              loop 0x42e
0000043B  B17E              mov cl,0x7e
0000043D  8AC4              mov al,ah
0000043F  EE                out dx,al
00000440  8AC3              mov al,bl
00000442  EE                out dx,al
00000443  8AC7              mov al,bh
00000445  EE                out dx,al
00000446  8AC1              mov al,cl
00000448  2401              and al,0x1
0000044A  02D8              add bl,al
0000044C  E2EF              loop 0x43d
0000044E  B142              mov cl,0x42
00000450  B83F3F            mov ax,0x3f3f
00000453  EE                out dx,al
00000454  86C4              xchg al,ah
00000456  EE                out dx,al
00000457  86C4              xchg al,ah
00000459  50                push ax
0000045A  B000              mov al,0x0
0000045C  EE                out dx,al
0000045D  58                pop ax
0000045E  E2F3              loop 0x453
00000460  B9BFF8            mov cx,0xf8bf
00000463  BF0000            mov di,0x0
00000466  8BEF              mov bp,di
00000468  8BC7              mov ax,di
0000046A  AA                stosb
0000046B  268A05            mov al,[es:di]
0000046E  B400              mov ah,0x0
00000470  26024501          add al,[es:di+0x1]
00000474  80D400            adc ah,0x0
00000477  260245FF          add al,[es:di-0x1]
0000047B  80D400            adc ah,0x0
0000047E  2602854001        add al,[es:di+0x140]
00000483  80D400            adc ah,0x0
00000486  C1E802            shr ax,byte 0x2
00000489  7403              jz 0x48e
0000048B  FEC8              dec al
0000048D  45                inc bp
0000048E  AA                stosb
0000048F  E2DA              loop 0x46b
00000491  B93F01            mov cx,0x13f
00000494  268A05            mov al,[es:di]
00000497  B400              mov ah,0x0
00000499  26024501          add al,[es:di+0x1]
0000049D  80D400            adc ah,0x0
000004A0  260245FF          add al,[es:di-0x1]
000004A4  80D400            adc ah,0x0
000004A7  260285C0FE        add al,[es:di-0x140]
000004AC  80D400            adc ah,0x0
000004AF  C1E802            shr ax,byte 0x2
000004B2  7403              jz 0x4b7
000004B4  FEC8              dec al
000004B6  45                inc bp
000004B7  AA                stosb
000004B8  E2DA              loop 0x494
000004BA  B000              mov al,0x0
000004BC  AA                stosb
000004BD  E82E00            call 0x4ee
000004C0  0BED              or bp,bp
000004C2  759C              jnz 0x460
000004C4  FA                cli
000004C5  0E                push cs
000004C6  1F                pop ds
000004C7  FE0EBF0A          dec byte [0xabf]
000004CB  E8C900            call 0x597
000004CE  8B16706A          mov dx,[0x6a70]
000004D2  8E1E726A          mov ds,word [0x6a72]
000004D6  B80825            mov ax,0x2508
000004D9  CD21              int byte 0x21
000004DB  B80300            mov ax,0x3
000004DE  CD10              int byte 0x10
000004E0  C3                ret
000004E1  BADA03            mov dx,0x3da
000004E4  EC                in al,dx
000004E5  A808              test al,0x8
000004E7  75FB              jnz 0x4e4
000004E9  EC                in al,dx
000004EA  A808              test al,0x8
000004EC  74FB              jz 0x4e9
000004EE  1E                push ds
000004EF  06                push es
000004F0  06                push es
000004F1  1F                pop ds
000004F2  6800A0            push word 0xa000
000004F5  07                pop es
000004F6  33F6              xor si,si
000004F8  8BFE              mov di,si
000004FA  B9803E            mov cx,0x3e80
000004FD  F366A5            rep movsd
00000500  07                pop es
00000501  1F                pop ds
00000502  C3                ret
00000503  FEC8              dec al
00000505  243F              and al,0x3f
00000507  3C26              cmp al,0x26
00000509  7274              jc 0x57f
0000050B  3C30              cmp al,0x30
0000050D  723A              jc 0x549
0000050F  8AC4              mov al,ah
00000511  6626894501        mov [es:di+0x1],eax
00000516  662689854001      mov [es:di+0x140],eax
0000051C  662689858002      mov [es:di+0x280],eax
00000522  66268985C003      mov [es:di+0x3c0],eax
00000528  662689850005      mov [es:di+0x500],eax
0000052E  662689854106      mov [es:di+0x641],eax
00000534  2689854401        mov [es:di+0x144],ax
00000539  2689858402        mov [es:di+0x284],ax
0000053E  268985C403        mov [es:di+0x3c4],ax
00000543  2689850405        mov [es:di+0x504],ax
00000548  C3                ret
00000549  8AC4              mov al,ah
0000054B  26894501          mov [es:di+0x1],ax
0000054F  26884503          mov [es:di+0x3],al
00000553  662689854001      mov [es:di+0x140],eax
00000559  662689858002      mov [es:di+0x280],eax
0000055F  66268985C003      mov [es:di+0x3c0],eax
00000565  2689850105        mov [es:di+0x501],ax
0000056A  2688850305        mov [es:di+0x503],al
0000056F  2688854401        mov [es:di+0x144],al
00000574  2688858402        mov [es:di+0x284],al
00000579  268885C403        mov [es:di+0x3c4],al
0000057E  C3                ret
0000057F  8AC4              mov al,ah
00000581  26894501          mov [es:di+0x1],ax
00000585  662689854001      mov [es:di+0x140],eax
0000058B  662689858002      mov [es:di+0x280],eax
00000591  268985C103        mov [es:di+0x3c1],ax
00000596  C3                ret
00000597  B82001            mov ax,0x120
0000059A  E89300            call 0x630
0000059D  B80008            mov ax,0x800
000005A0  E88D00            call 0x630
000005A3  B4BD              mov ah,0xbd
000005A5  E88800            call 0x630
000005A8  B90900            mov cx,0x9
000005AB  33DB              xor bx,bx
000005AD  BF8D06            mov di,0x68d
000005B0  8B35              mov si,[di]
000005B2  47                inc di
000005B3  47                inc di
000005B4  8AA78406          mov ah,[bx+0x684]
000005B8  BD0400            mov bp,0x4
000005BB  E86B00            call 0x629
000005BE  80C41D            add ah,0x1d
000005C1  4D                dec bp
000005C2  75F7              jnz 0x5bb
000005C4  80C440            add ah,0x40
000005C7  E85F00            call 0x629
000005CA  8AE3              mov ah,bl
000005CC  80C4C0            add ah,0xc0
000005CF  E85D00            call 0x62f
000005D2  33C0              xor ax,ax
000005D4  E87900            call 0x650
000005D7  43                inc bx
000005D8  E2D6              loop 0x5b0
000005DA  C3                ret
000005DB  B90900            mov cx,0x9
000005DE  BFEC06            mov di,0x6ec
000005E1  33DB              xor bx,bx
000005E3  80AF610601        sub byte [bx+0x661],0x1
000005E8  7933              jns 0x61d
000005EA  8B35              mov si,[di]
000005EC  AC                lodsb
000005ED  0AC0              or al,al
000005EF  7433              jz 0x624
000005F1  7908              jns 0x5fb
000005F3  2C81              sub al,0x81
000005F5  88876106          mov [bx+0x661],al
000005F9  EB20              jmp 0x61b
000005FB  50                push ax
000005FC  33C0              xor ax,ax
000005FE  E84F00            call 0x650
00000601  58                pop ax
00000602  8AD0              mov dl,al
00000604  250F00            and ax,0xf
00000607  8BE8              mov bp,ax
00000609  03ED              add bp,bp
0000060B  3E8B866A06        mov ax,[ds:bp+0x66a]
00000610  C0EA02            shr dl,byte 0x2
00000613  80E2FC            and dl,0xfc
00000616  02E2              add ah,dl
00000618  E83500            call 0x650
0000061B  8935              mov [di],si
0000061D  83C704            add di,0x4
00000620  43                inc bx
00000621  E2C0              loop 0x5e3
00000623  C3                ret
00000624  8B7502            mov si,[di+0x2]
00000627  EBC3              jmp 0x5ec
00000629  E80300            call 0x62f
0000062C  80C403            add ah,0x3
0000062F  AC                lodsb
00000630  50                push ax
00000631  51                push cx
00000632  86C4              xchg al,ah
00000634  BA8803            mov dx,0x388
00000637  EE                out dx,al
00000638  B90700            mov cx,0x7
0000063B  E80E00            call 0x64c
0000063E  BA8903            mov dx,0x389
00000641  8AC4              mov al,ah
00000643  EE                out dx,al
00000644  B130              mov cl,0x30
00000646  E80300            call 0x64c
00000649  59                pop cx
0000064A  58                pop ax
0000064B  C3                ret
0000064C  EC                in al,dx
0000064D  E2FD              loop 0x64c
0000064F  C3                ret
00000650  53                push bx
00000651  86E3              xchg ah,bl
00000653  80C4A0            add ah,0xa0
00000656  E8D7FF            call 0x630
00000659  8AC3              mov al,bl
0000065B  80C410            add ah,0x10
0000065E  5B                pop bx
0000065F  EBCF              jmp 0x630
00000661  0000              add [bx+si],al
00000663  0000              add [bx+si],al
00000665  0000              add [bx+si],al
00000667  0000              add [bx+si],al
00000669  006B21            add [bp+di+0x21],ch
0000066C  81219821          and word [bx+di],0x2198
00000670  B021              mov al,0x21
00000672  CA21E5            retf word 0xe521
00000675  2102              and [bp+si],ax
00000677  2220              and ah,[bx+si]
00000679  224122            and al,[bx+di+0x22]
0000067C  6322              arpl [bp+si],sp
0000067E  8722              xchg sp,[bp+si]
00000680  642300            and ax,[fs:bx+si]
00000683  0020              add [bx+si],ah
00000685  2122              and [bp+si],sp
00000687  2829              sub [bx+di],ch
00000689  2A30              sub dh,[bx+si]
0000068B  3132              xor [bp+si],si
0000068D  9F                lahf
0000068E  06                push es
0000068F  AA                stosb
00000690  06                push es
00000691  B506              mov ch,0x6
00000693  B506              mov ch,0x6
00000695  C006CB06CB        rol byte [0x6cb],byte 0xcb
0000069A  06                push es
0000069B  D6                salc
0000069C  06                push es
0000069D  E106              loope 0x6a5
0000069F  80400880          add byte [bx+si+0x8],0x80
000006A3  F5                cmc
000006A4  F5                cmc
000006A5  F7D6              not si
000006A7  0000              add [bx+si],al
000006A9  0440              add al,0x40
000006AB  1008              adc [bx+si],cl
000006AD  80D5C5            adc ch,0xc5
000006B0  F7D6              not si
000006B2  0000              add [bx+si],al
000006B4  06                push es
000006B5  91                xchg ax,cx
000006B6  40                inc ax
000006B7  8780F36F          xchg ax,[bx+si+0x6ff3]
000006BB  2303              and ax,[bp+di]
000006BD  0101              add [bx+di],ax
000006BF  0AD1              or dl,cl
000006C1  C08780F36F        rol byte [bx-0xc80],byte 0x6f
000006C6  2303              and ax,[bp+di]
000006C8  0201              add al,[bx+di]
000006CA  084080            or [bx+si-0x80],al
000006CD  000D              add [di],cl
000006CF  7570              jnz 0x741
000006D1  47                inc di
000006D2  57                push di
000006D3  0100              add [bx+si],ax
000006D5  07                pop es
000006D6  91                xchg ax,cx
000006D7  808780F36F        add byte [bx-0xc80],0x6f
000006DC  2303              and ax,[bp+di]
000006DE  0201              add al,[bx+di]
000006E0  0001              add [bx+di],al
000006E2  0012              add [bp+si],dl
000006E4  88D5              mov ch,dl
000006E6  C5                db 0xc5
000006E7  F7D6              not si
000006E9  0000              add [bx+si],al
000006EB  06                push es
000006EC  1007              adc [bx],al
000006EE  1007              adc [bx],al
000006F0  AB                stosw
000006F1  07                pop es
000006F2  AB                stosw
000006F3  07                pop es
000006F4  D107              rol word [bx],0x0
000006F6  D107              rol word [bx],0x0
000006F8  0F09              wbinvd
000006FA  0F09              wbinvd
000006FC  B309              mov bl,0x9
000006FE  B309              mov bl,0x9
00000700  16                push ss
00000701  0A160A30          or dl,[0x300a]
00000705  0A30              or dh,[bx+si]
00000707  0A360A36          or dh,[0x360a]
0000070B  0A930A93          or dl,[bp+di-0x6cf6]
0000070F  0AC0              or al,al
00000711  22852281          and al,[di-0x7ede]
00000715  22872287          and al,[bx-0x78de]
00000719  22872285          and al,[bx-0x7ade]
0000071D  22812287          and al,[bx+di-0x78de]
00000721  22872284          and al,[bx-0x7bde]
00000725  2222              and ah,[bp+si]
00000727  2222              and ah,[bp+si]
00000729  8522              test [bp+si],sp
0000072B  81228722          and word [bp+si],0x2287
0000072F  8722              xchg sp,[bp+si]
00000731  8722              xchg sp,[bp+si]
00000733  8522              test [bp+si],sp
00000735  81228722          and word [bp+si],0x2287
00000739  8722              xchg sp,[bp+si]
0000073B  8422              test [bp+si],ah
0000073D  2222              and ah,[bp+si]
0000073F  22822282          and al,[bp+si-0x7dde]
00000743  22812287          and al,[bx+di-0x78de]
00000747  22852281          and al,[di-0x7ede]
0000074B  22872282          and al,[bx-0x7dde]
0000074F  22822281          and al,[bp+si-0x7ede]
00000753  22872282          and al,[bx-0x7dde]
00000757  22822281          and al,[bp+si-0x7ede]
0000075B  22812283          and al,[bx+di-0x7cde]
0000075F  2222              and ah,[bp+si]
00000761  22822282          and al,[bp+si-0x7dde]
00000765  22812287          and al,[bx+di-0x78de]
00000769  22852281          and al,[di-0x7ede]
0000076D  22872282          and al,[bx-0x7dde]
00000771  22822281          and al,[bp+si-0x7ede]
00000775  22872282          and al,[bx-0x7dde]
00000779  22822281          and al,[bp+si-0x7ede]
0000077D  22812283          and al,[bx+di-0x7cde]
00000781  2222              and ah,[bp+si]
00000783  22872287          and al,[bx-0x78de]
00000787  22872287          and al,[bx-0x78de]
0000078B  22872287          and al,[bx-0x78de]
0000078F  22872287          and al,[bx-0x78de]
00000793  22852281          and al,[di-0x7ede]
00000797  22872287          and al,[bx-0x78de]
0000079B  22872285          and al,[bx-0x7ade]
0000079F  22812287          and al,[bx+di-0x78de]
000007A3  22872284          and al,[bx-0x7bde]
000007A7  2222              and ah,[bp+si]
000007A9  2200              and al,[bx+si]
000007AB  FC                cld
000007AC  20BF208F          and [bx-0x70e0],bh
000007B0  208F208F          and [bx-0x70e0],cl
000007B4  208F208F          and [bx-0x70e0],cl
000007B8  208F208F          and [bx-0x70e0],cl
000007BC  20972087          and [bx-0x78e0],dl
000007C0  20872087          and [bx-0x78e0],al
000007C4  20872087          and [bx-0x78e0],al
000007C8  20872087          and [bx-0x78e0],al
000007CC  20BF2083          and [bx-0x7ce0],bh
000007D0  00C0              add al,al
000007D2  42                inc dx
000007D3  8152814281        adc word [bp+si-0x7f],0x8142
000007D8  52                push dx
000007D9  8142815281        add word [bp+si-0x7f],0x8152
000007DE  42                inc dx
000007DF  8152814081        adc word [bp+si-0x7f],0x8140
000007E4  50                push ax
000007E5  8140815081        add word [bx+si-0x7f],0x8150
000007EA  40                inc ax
000007EB  8150814081        adc word [bx+si-0x7f],0x8140
000007F0  50                push ax
000007F1  814A815A81        or word [bp+si-0x7f],0x815a
000007F6  4A                dec dx
000007F7  815A814A81        sbb word [bp+si-0x7f],0x814a
000007FC  5A                pop dx
000007FD  814A815A81        or word [bp+si-0x7f],0x815a
00000802  49                dec cx
00000803  8159814981        sbb word [bx+di-0x7f],0x8149
00000808  59                pop cx
00000809  8149815981        or word [bx+di-0x7f],0x8159
0000080E  49                dec cx
0000080F  8159814281        sbb word [bx+di-0x7f],0x8142
00000814  52                push dx
00000815  8142815281        add word [bp+si-0x7f],0x8152
0000081A  42                inc dx
0000081B  8152814281        adc word [bp+si-0x7f],0x8142
00000820  52                push dx
00000821  8140815081        add word [bx+si-0x7f],0x8150
00000826  40                inc ax
00000827  8150814081        adc word [bx+si-0x7f],0x8140
0000082C  50                push ax
0000082D  8140815081        add word [bx+si-0x7f],0x8150
00000832  4A                dec dx
00000833  815A814A81        sbb word [bp+si-0x7f],0x814a
00000838  5A                pop dx
00000839  814A815A81        or word [bp+si-0x7f],0x815a
0000083E  4A                dec dx
0000083F  815A814981        sbb word [bp+si-0x7f],0x8149
00000844  59                pop cx
00000845  8149815981        or word [bx+di-0x7f],0x8159
0000084A  49                dec cx
0000084B  8159814981        sbb word [bx+di-0x7f],0x8149
00000850  59                pop cx
00000851  8142815281        add word [bp+si-0x7f],0x8152
00000856  42                inc dx
00000857  8152814281        adc word [bp+si-0x7f],0x8142
0000085C  52                push dx
0000085D  8142815281        add word [bp+si-0x7f],0x8152
00000862  40                inc ax
00000863  8150814081        adc word [bx+si-0x7f],0x8140
00000868  50                push ax
00000869  8140815081        add word [bx+si-0x7f],0x8150
0000086E  40                inc ax
0000086F  8150814A81        adc word [bx+si-0x7f],0x814a
00000874  5A                pop dx
00000875  814A815A81        or word [bp+si-0x7f],0x815a
0000087A  4A                dec dx
0000087B  815A814A81        sbb word [bp+si-0x7f],0x814a
00000880  5A                pop dx
00000881  8149815981        or word [bx+di-0x7f],0x8159
00000886  49                dec cx
00000887  8159814981        sbb word [bx+di-0x7f],0x8149
0000088C  59                pop cx
0000088D  8149815981        or word [bx+di-0x7f],0x8159
00000892  42                inc dx
00000893  8152814281        adc word [bp+si-0x7f],0x8142
00000898  52                push dx
00000899  8142815281        add word [bp+si-0x7f],0x8152
0000089E  42                inc dx
0000089F  8152814081        adc word [bp+si-0x7f],0x8140
000008A4  50                push ax
000008A5  8140815081        add word [bx+si-0x7f],0x8150
000008AA  40                inc ax
000008AB  8150814081        adc word [bx+si-0x7f],0x8140
000008B0  50                push ax
000008B1  814A815A81        or word [bp+si-0x7f],0x815a
000008B6  4A                dec dx
000008B7  815A814A81        sbb word [bp+si-0x7f],0x814a
000008BC  5A                pop dx
000008BD  814A815A81        or word [bp+si-0x7f],0x815a
000008C2  49                dec cx
000008C3  8159814981        sbb word [bx+di-0x7f],0x8149
000008C8  59                pop cx
000008C9  8149815985        or word [bx+di-0x7f],0x8559
000008CE  42                inc dx
000008CF  8142814281        add word [bp+si-0x7f],0x8142
000008D4  42                inc dx
000008D5  8142814281        add word [bp+si-0x7f],0x8142
000008DA  42                inc dx
000008DB  8142814081        add word [bp+si-0x7f],0x8140
000008E0  40                inc ax
000008E1  8140814081        add word [bx+si-0x7f],0x8140
000008E6  40                inc ax
000008E7  8140814081        add word [bx+si-0x7f],0x8140
000008EC  40                inc ax
000008ED  814A814A81        or word [bp+si-0x7f],0x814a
000008F2  4A                dec dx
000008F3  814A814A81        or word [bp+si-0x7f],0x814a
000008F8  4A                dec dx
000008F9  814A814A81        or word [bp+si-0x7f],0x814a
000008FE  49                dec cx
000008FF  8149814981        or word [bx+di-0x7f],0x8149
00000904  49                dec cx
00000905  8149814981        or word [bx+di-0x7f],0x8149
0000090A  49                dec cx
0000090B  8149C100C0        or word [bx+di-0x3f],0xc000
00000910  42                inc dx
00000911  8F                db 0x8f
00000912  52                push dx
00000913  8150815281        adc word [bx+si-0x7f],0x8152
00000918  54                push sp
00000919  855583            test [di-0x7d],dx
0000091C  57                push di
0000091D  855585            test [di-0x7b],dx
00000920  59                pop cx
00000921  83578155          adc word [bx-0x7f],0x55
00000925  8154815581        adc word [si-0x7f],0x8155
0000092A  54                push sp
0000092B  8152835081        adc word [bp+si-0x7d],0x8150
00000930  52                push dx
00000931  8F                db 0x8f
00000932  52                push dx
00000933  8150815281        adc word [bx+si-0x7f],0x8152
00000938  54                push sp
00000939  855583            test [di-0x7d],dx
0000093C  57                push di
0000093D  855585            test [di-0x7b],dx
00000940  59                pop cx
00000941  83578155          adc word [bx-0x7f],0x55
00000945  8154815581        adc word [si-0x7f],0x8155
0000094A  54                push sp
0000094B  8152835081        adc word [bp+si-0x7d],0x8150
00000950  52                push dx
00000951  8F                db 0x8f
00000952  52                push dx
00000953  8150815281        adc word [bx+si-0x7f],0x8152
00000958  54                push sp
00000959  855583            test [di-0x7d],dx
0000095C  57                push di
0000095D  855585            test [di-0x7b],dx
00000960  59                pop cx
00000961  83578155          adc word [bx-0x7f],0x55
00000965  8154815581        adc word [si-0x7f],0x8155
0000096A  54                push sp
0000096B  8152835091        adc word [bp+si-0x7d],0x9150
00000970  52                push dx
00000971  8150815281        adc word [bx+si-0x7f],0x8152
00000976  54                push sp
00000977  855583            test [di-0x7d],dx
0000097A  57                push di
0000097B  855585            test [di-0x7b],dx
0000097E  59                pop cx
0000097F  83578155          adc word [bx-0x7f],0x55
00000983  8154815581        adc word [si-0x7f],0x8155
00000988  54                push sp
00000989  815283508B        adc word [bp+si-0x7d],0x8b50
0000098E  42                inc dx
0000098F  81458147B1        add word [di-0x7f],0xb147
00000994  42                inc dx
00000995  894081            mov [bx+si-0x7f],ax
00000998  42                inc dx
00000999  8144814589        add word [si-0x7f],0x8945
0000099E  47                inc di
0000099F  8145814781        add word [di-0x7f],0x8147
000009A4  45                inc bp
000009A5  894285            mov [bp+si-0x7b],ax
000009A8  42                inc dx
000009A9  854983            test [bx+di-0x7d],cx
000009AC  47                inc di
000009AD  8145814781        add word [di-0x7f],0x8147
000009B2  00FF              add bh,bh
000009B4  8154853283        adc word [si-0x7b],0x8332
000009B9  32854485          xor al,[di-0x7abc]
000009BD  30833085          xor [bp+di-0x7ad0],al
000009C1  44                inc sp
000009C2  853A              test [bp+si],di
000009C4  833A85            cmp word [bp+si],0xffffffffffffff85
000009C7  44                inc sp
000009C8  8539              test [bx+di],di
000009CA  833985            cmp word [bx+di],0xffffffffffffff85
000009CD  54                push sp
000009CE  8532              test [bp+si],si
000009D0  833285            xor word [bp+si],0xffffffffffffff85
000009D3  44                inc sp
000009D4  8530              test [bx+si],si
000009D6  833085            xor word [bx+si],0xffffffffffffff85
000009D9  44                inc sp
000009DA  853A              test [bp+si],di
000009DC  833A85            cmp word [bp+si],0xffffffffffffff85
000009DF  44                inc sp
000009E0  8539              test [bx+di],di
000009E2  833985            cmp word [bx+di],0xffffffffffffff85
000009E5  54                push sp
000009E6  8532              test [bp+si],si
000009E8  833285            xor word [bp+si],0xffffffffffffff85
000009EB  44                inc sp
000009EC  8530              test [bx+si],si
000009EE  833085            xor word [bx+si],0xffffffffffffff85
000009F1  44                inc sp
000009F2  853A              test [bp+si],di
000009F4  833A85            cmp word [bp+si],0xffffffffffffff85
000009F7  44                inc sp
000009F8  8539              test [bx+di],di
000009FA  833985            cmp word [bx+di],0xffffffffffffff85
000009FD  54                push sp
000009FE  8532              test [bp+si],si
00000A00  833285            xor word [bp+si],0xffffffffffffff85
00000A03  44                inc sp
00000A04  8530              test [bx+si],si
00000A06  833085            xor word [bx+si],0xffffffffffffff85
00000A09  44                inc sp
00000A0A  853A              test [bp+si],di
00000A0C  833A85            cmp word [bp+si],0xffffffffffffff85
00000A0F  44                inc sp
00000A10  8539              test [bx+di],di
00000A12  8339C5            cmp word [bx+di],0xffffffffffffffc5
00000A15  0032              add [bp+si],dh
00000A17  9F                lahf
00000A18  3A8F39FF          cmp cl,[bx-0xc7]
00000A1C  D0                db 0xd0
00000A1D  32BF429F          xor bh,[bx-0x60be]
00000A21  4A                dec dx
00000A22  854A89            test [bp+si-0x77],cx
00000A25  49                dec cx
00000A26  8F428F            pop word [bp+si-0x71]
00000A29  40                inc ax
00000A2A  8F                db 0x8f
00000A2B  3A8F398F          cmp cl,[bx-0x70c7]
00000A2F  0042FF            add [bp+si-0x1],al
00000A32  FF                db 0xff
00000A33  FFC2              inc dx
00000A35  004081            add [bx+si-0x7f],al
00000A38  42                inc dx
00000A39  874282            xchg ax,[bp+si-0x7e]
00000A3C  47                inc di
00000A3D  82                db 0x82
00000A3E  49                dec cx
00000A3F  854785            test [bx-0x7b],ax
00000A42  49                dec cx
00000A43  83478145          add word [bx-0x7f],0x45
00000A47  8144814581        add word [si-0x7f],0x8145
00000A4C  44                inc sp
00000A4D  8142854085        add word [bp+si-0x7b],0x8540
00000A52  42                inc dx
00000A53  8544FF            test [si-0x1],ax
00000A56  FF954781          call word near [di-0x7eb9]
00000A5A  45                inc bp
00000A5B  8147814583        add word [bx-0x7f],0x8345
00000A60  44                inc sp
00000A61  8F                db 0x8f
00000A62  4A                dec dx
00000A63  8149814A87        or word [bx+di-0x7f],0x874a
00000A68  49                dec cx
00000A69  83478145          add word [bx-0x7f],0x45
00000A6D  8147815081        add word [bx-0x7f],0x8150
00000A72  52                push dx
00000A73  8152815289        adc word [bp+si-0x7f],0x8952
00000A78  50                push ax
00000A79  8152815581        adc word [bp+si-0x7f],0x8155
00000A7E  57                push di
00000A7F  895081            mov [bx+si-0x7f],dx
00000A82  52                push dx
00000A83  8152815289        adc word [bp+si-0x7f],0x8952
00000A88  57                push di
00000A89  8155815281        adc word [di-0x7f],0x8152
00000A8E  50                push ax
00000A8F  83528500          adc word [bp+si-0x7b],0x0
00000A93  FF                db 0xff
00000A94  FFC4              inc sp
00000A96  2B2B              sub bp,[bp+di]
00000A98  82                db 0x82
00000A99  2B832B2B          sub ax,[bp+di+0x2b2b]
00000A9D  82                db 0x82
00000A9E  2B832B2B          sub ax,[bp+di+0x2b2b]
00000AA2  82                db 0x82
00000AA3  2B832B2B          sub ax,[bp+di+0x2b2b]
00000AA7  82                db 0x82
00000AA8  2B832B2B          sub ax,[bp+di+0x2b2b]
00000AAC  82                db 0x82
00000AAD  2B832B2B          sub ax,[bp+di+0x2b2b]
00000AB1  82                db 0x82
00000AB2  2B832B2B          sub ax,[bp+di+0x2b2b]
00000AB6  82                db 0x82
00000AB7  2B832B2B          sub ax,[bp+di+0x2b2b]
00000ABB  82                db 0x82
00000ABC  2BC1              sub ax,cx
00000ABE  0000              add [bx+si],al
00000AC0  02501E            add dl,[bx+si+0x1e]
00000AC3  0E                push cs
00000AC4  1F                pop ds
00000AC5  803EBF0A00        cmp byte [0xabf],0x0
00000ACA  7410              jz 0xadc
00000ACC  FE0EC00A          dec byte [0xac0]
00000AD0  750A              jnz 0xadc
00000AD2  C606C00A02        mov byte [0xac0],0x2
00000AD7  60                pusha
00000AD8  E800FB            call 0x5db
00000ADB  61                popa
00000ADC  B020              mov al,0x20
00000ADE  E620              out byte 0x20,al
00000AE0  1F                pop ds
00000AE1  58                pop ax
00000AE2  CF                iret
00000AE3  9E                sahf
00000AE4  3486              xor al,0x86
00000AE6  0C02              or al,0x2
00000AE8  0000              add [bx+si],al
00000AEA  0000              add [bx+si],al
00000AEC  07                pop es
00000AED  0006000A          add [0xa00],al
00000AF1  81FF81C0          cmp di,0xc081
00000AF5  0003              add [bp+di],al
00000AF7  81FFFF9D          cmp di,0x9dff
00000AFB  FF9DCFFF          call word far [di-0x31]
00000AFF  FB                sti
00000B00  9D                popf
00000B01  FF                db 0xff
00000B02  FF9DFF9D          call word far [di-0x6201]
00000B06  CF                iret
00000B07  FF                db 0xff
00000B08  FB                sti
00000B09  9D                popf
00000B0A  FF                db 0xff
00000B0B  FF9DFF9D          call word far [di-0x6201]
00000B0F  CF                iret
00000B10  FF                db 0xff
00000B11  FB                sti
00000B12  9D                popf
00000B13  FF                db 0xff
00000B14  FF9DFF9D          call word far [di-0x6201]
00000B18  CF                iret
00000B19  FF                db 0xff
00000B1A  FB                sti
00000B1B  9D                popf
00000B1C  FF                db 0xff
00000B1D  FF81FF9D          inc word [bx+di-0x6201]
00000B21  C00003            rol byte [bx+si],byte 0x3
00000B24  81FFFFFF          cmp di,0xffff
00000B28  FF9DFFFF          call word far [di-0x1]
00000B2C  FF                db 0xff
00000B2D  FF                db 0xff
00000B2E  FF                db 0xff
00000B2F  FF81FF9D          inc word [bx+di-0x6201]
00000B33  C0FFFF            sar bh,byte 0xff
00000B36  81FFFF9D          cmp di,0x9dff
00000B3A  FF9DCEFF          call word far [di-0x32]
00000B3E  FF9DFFFF          call word far [di-0x1]
00000B42  9D                popf
00000B43  FF9DCEFF          call word far [di-0x32]
00000B47  FF9DFFFF          call word far [di-0x1]
00000B4B  9D                popf
00000B4C  FF9DCEFF          call word far [di-0x32]
00000B50  FF9DFFFF          call word far [di-0x1]
00000B54  9D                popf
00000B55  FF9DCEFF          call word far [di-0x32]
00000B59  FF9DFFFF          call word far [di-0x1]
00000B5D  9D                popf
00000B5E  FF9DCEFF          call word far [di-0x32]
00000B62  FF9DFFFF          call word far [di-0x1]
00000B66  9D                popf
00000B67  FF9DCEFF          call word far [di-0x32]
00000B6B  FF9DFFFF          call word far [di-0x1]
00000B6F  9D                popf
00000B70  FF9DCEFF          call word far [di-0x32]
00000B74  FF9DFFFF          call word far [di-0x1]
00000B78  9D                popf
00000B79  FF9DCEFF          call word far [di-0x32]
00000B7D  FF9DFFFF          call word far [di-0x1]
00000B81  9C                pushf
00000B82  3F                aas
00000B83  9D                popf
00000B84  CE                into
00000B85  1F                pop ds
00000B86  FF9C3FFF          call word far [si-0xc1]
00000B8A  9F                lahf
00000B8B  BF9DCF            mov di,0xcf9d
00000B8E  DF                db 0xdf
00000B8F  FF9FBFFF          call word far [bx-0x41]
00000B93  9F                lahf
00000B94  BF9DCF            mov di,0xcf9d
00000B97  DF                db 0xdf
00000B98  FF9FBFFF          call word far [bx-0x41]
00000B9C  9F                lahf
00000B9D  BF9DCF            mov di,0xcf9d
00000BA0  DF                db 0xdf
00000BA1  FF9FBFFF          call word far [bx-0x41]
00000BA5  9F                lahf
00000BA6  BF9DCF            mov di,0xcf9d
00000BA9  DF                db 0xdf
00000BAA  FF9FBFFF          call word far [bx-0x41]
00000BAE  9F                lahf
00000BAF  BF9DCF            mov di,0xcf9d
00000BB2  DF                db 0xdf
00000BB3  FF9FBFFF          call word far [bx-0x41]
00000BB7  9F                lahf
00000BB8  BF9DCF            mov di,0xcf9d
00000BBB  DF                db 0xdf
00000BBC  FF9FBFFF          call word far [bx-0x41]
00000BC0  9F                lahf
00000BC1  BF9DCF            mov di,0xcf9d
00000BC4  DF                db 0xdf
00000BC5  FF9FBFFF          call word far [bx-0x41]
00000BC9  9F                lahf
00000BCA  BF9DCF            mov di,0xcf9d
00000BCD  DF                db 0xdf
00000BCE  FF9FBFFF          call word far [bx-0x41]
00000BD2  9F                lahf
00000BD3  BF9DCF            mov di,0xcf9d
00000BD6  DF                db 0xdf
00000BD7  FF9FBFFF          call word far [bx-0x41]
00000BDB  9F                lahf
00000BDC  BF9DCF            mov di,0xcf9d
00000BDF  DF                db 0xdf
00000BE0  FF9FBFFF          call word far [bx-0x41]
00000BE4  9F                lahf
00000BE5  BF9DCF            mov di,0xcf9d
00000BE8  DF                db 0xdf
00000BE9  FF9FBFFF          call word far [bx-0x41]
00000BED  9F                lahf
00000BEE  BF9DCF            mov di,0xcf9d
00000BF1  DF                db 0xdf
00000BF2  FF9FBFFF          call word far [bx-0x41]
00000BF6  9F                lahf
00000BF7  BF9DCF            mov di,0xcf9d
00000BFA  DF                db 0xdf
00000BFB  FF9FBFFF          call word far [bx-0x41]
00000BFF  9F                lahf
00000C00  BF9DCF            mov di,0xcf9d
00000C03  DF                db 0xdf
00000C04  FF9FBFFF          call word far [bx-0x41]
00000C08  9F                lahf
00000C09  BF9DCF            mov di,0xcf9d
00000C0C  DF                db 0xdf
00000C0D  FF9FBFFF          call word far [bx-0x41]
00000C11  9C                pushf
00000C12  3F                aas
00000C13  9D                popf
00000C14  CF                iret
00000C15  DF                db 0xdf
00000C16  FF9FBFFF          call word far [bx-0x41]
00000C1A  9D                popf
00000C1B  FF9DCFDF          call word far [di-0x2031]
00000C1F  FF9FBFFF          call word far [bx-0x41]
00000C23  9D                popf
00000C24  001D              add [di],bl
00000C26  CF                iret
00000C27  C0039F            rol byte [bp+di],byte 0x9f
00000C2A  80079D            add byte [bx],0x9d
00000C2D  3F                aas
00000C2E  FD                std
00000C2F  CF                iret
00000C30  FF                db 0xff
00000C31  FB                sti
00000C32  9F                lahf
00000C33  FFF7              push di
00000C35  9D                popf
00000C36  3F                aas
00000C37  FD                std
00000C38  CF                iret
00000C39  FF                db 0xff
00000C3A  FB                sti
00000C3B  9F                lahf
00000C3C  FFF7              push di
00000C3E  9D                popf
00000C3F  3F                aas
00000C40  FD                std
00000C41  CF                iret
00000C42  FF                db 0xff
00000C43  FB                sti
00000C44  9F                lahf
00000C45  FFF7              push di
00000C47  9D                popf
00000C48  3F                aas
00000C49  FD                std
00000C4A  CF                iret
00000C4B  FF                db 0xff
00000C4C  FB                sti
00000C4D  9F                lahf
00000C4E  FFF7              push di
00000C50  810001C0          add word [bx+si],0xc001
00000C54  0003              add [bp+di],al
00000C56  800007            add byte [bx+si],0x7
00000C59  2D5543            sub ax,0x4355
00000C5C  4C                dec sp
00000C5D  2D2049            sub ax,0x4920
00000C60  6E                outsb
00000C61  7472              jz 0xcd5
00000C63  3020              xor [bx+si],ah
00000C65  627920            bound di,[bx+di+0x20]
00000C68  53                push bx
00000C69  6B756C6C          imul si,[di+0x6c],0x6c
00000C6D  43                inc bx
00000C6E  304445            xor [si+0x45],al
00000C71  720D              jc 0xc80
00000C73  0A5072            or dl,[bx+si+0x72]
00000C76  657061            gs jo 0xcda
00000C79  7269              jc 0xce4
00000C7B  6E                outsb
00000C7C  6720646174        and [ecx+0x74],ah
00000C81  61                popa
00000C82  2E2E2E247F        cs and al,0x7f
00000C87  7F7F              jg 0xd08
00000C89  7E7B              jng 0xd06
00000C8B  2020              and [bx+si],ah
00000C8D  2020              and [bx+si],ah
00000C8F  252020            and ax,0x2020
00000C92  2020              and [bx+si],ah
00000C94  2020              and [bx+si],ah
00000C96  2020              and [bx+si],ah
00000C98  55                push bp
00000C99  4E                dec si
00000C9A  49                dec cx
00000C9B  54                push sp
00000C9C  45                inc bp
00000C9D  44                inc sp
00000C9E  7F7B              jg 0xd1b
00000CA0  2020              and [bx+si],ah
00000CA2  2020              and [bx+si],ah
00000CA4  257B7C            and ax,0x7c7b
00000CA7  7D2B              jnl 0xcd4
00000CA9  2A25              sub ah,[di]
00000CAB  43                inc bx
00000CAC  52                push dx
00000CAD  41                inc cx
00000CAE  43                inc bx
00000CAF  4B                dec bx
00000CB0  45                inc bp
00000CB1  52                push dx
00000CB2  53                push bx
00000CB3  7F7B              jg 0xd30
00000CB5  2020              and [bx+si],ah
00000CB7  2020              and [bx+si],ah
00000CB9  257B20            and ax,0x207b
00000CBC  2020              and [bx+si],ah
00000CBE  2020              and [bx+si],ah
00000CC0  7B20              jpo 0xce2
00000CC2  4C                dec sp
00000CC3  45                inc bp
00000CC4  41                inc cx
00000CC5  47                inc di
00000CC6  55                push bp
00000CC7  45                inc bp
00000CC8  7F7B              jg 0xd45
00000CCA  2020              and [bx+si],ah
00000CCC  2020              and [bx+si],ah
00000CCE  257B20            and ax,0x207b
00000CD1  2020              and [bx+si],ah
00000CD3  2020              and [bx+si],ah
00000CD5  7B7F              jpo 0xd56
00000CD7  7B7C              jpo 0xd55
00000CD9  7D2B              jnl 0xd06
00000CDB  2A25              sub ah,[di]
00000CDD  7B20              jpo 0xcff
00000CDF  2020              and [bx+si],ah
00000CE1  2020              and [bx+si],ah
00000CE3  7B7F              jpo 0xd64
00000CE5  2020              and [bx+si],ah
00000CE7  2020              and [bx+si],ah
00000CE9  2020              and [bx+si],ah
00000CEB  7B7C              jpo 0xd69
00000CED  7D2B              jnl 0xd1a
00000CEF  2A25              sub ah,[di]
00000CF1  7B7F              jpo 0xd72
00000CF3  2020              and [bx+si],ah
00000CF5  2020              and [bx+si],ah
00000CF7  2020              and [bx+si],ah
00000CF9  2020              and [bx+si],ah
00000CFB  2020              and [bx+si],ah
00000CFD  2020              and [bx+si],ah
00000CFF  7B7C              jpo 0xd7d
00000D01  7D2B              jnl 0xd2e
00000D03  2A25              sub ah,[di]
00000D05  7F7F              jg 0xd86
00000D07  7E20              jng 0xd29
00000D09  2020              and [bx+si],ah
00000D0B  2020              and [bx+si],ah
00000D0D  4F                dec di
00000D0E  7572              jnz 0xd82
00000D10  206C65            and [si+0x65],ch
00000D13  61                popa
00000D14  677565            a32 jnz 0xd7c
00000D17  7F20              jg 0xd39
00000D19  637265            arpl [bp+si+0x65],si
00000D1C  61                popa
00000D1D  7465              jz 0xd84
00000D1F  6420666F          and [fs:bp+0x6f],ah
00000D23  7220              jc 0xd45
00000D25  756E              jnz 0xd95
00000D27  6966797F20        imul sp,[bp+0x79],0x207f
00000D2C  2020              and [bx+si],ah
00000D2E  666F              outsd
00000D30  7263              jc 0xd95
00000D32  657320            gs jnc 0xd55
00000D35  6F                outsw
00000D36  6620616C          o32 and [bx+di+0x6c],ah
00000D3A  6C                insb
00000D3B  7F63              jg 0xda0
00000D3D  7261              jc 0xda0
00000D3F  636B2D            arpl [bp+di+0x2d],bp
00000D42  6D                insw
00000D43  61                popa
00000D44  6B657273          imul sp,[di+0x72],0x73
00000D48  207065            and [bx+si+0x65],dh
00000D4B  6F                outsw
00000D4C  706C              jo 0xdba
00000D4E  657F20            gs jg 0xd71
00000D51  61                popa
00000D52  7420              jz 0xd74
00000D54  45                inc bp
00000D55  782D              js 0xd84
00000D57  53                push bx
00000D58  6F                outsw
00000D59  7669              jna 0xdc4
00000D5B  657420            gs jz 0xd7e
00000D5E  55                push bp
00000D5F  6E                outsb
00000D60  696F6E7F7F        imul bp,[bx+0x6e],0x7f7f
00000D65  2020              and [bx+si],ah
00000D67  20416E            and [bx+di+0x6e],al
00000D6A  64206E6F          and [fs:bp+0x6f],ch
00000D6E  7720              ja 0xd90
00000D70  6C                insb
00000D71  657420            gs jz 0xd94
00000D74  7573              jnz 0xde9
00000D76  7F69              jg 0xde1
00000D78  6E                outsb
00000D79  7472              jz 0xded
00000D7B  6F                outsw
00000D7C  647563            fs jnz 0xde2
00000D7F  65206F75          and [gs:bx+0x75],ch
00000D83  7273              jc 0xdf8
00000D85  656C              gs insb
00000D87  7665              jna 0xdee
00000D89  733A              jnc 0xdc5
00000D8B  7F7F              jg 0xe0c
00000D8D  2020              and [bx+si],ah
00000D8F  2020              and [bx+si],ah
00000D91  2020              and [bx+si],ah
00000D93  43                inc bx
00000D94  52                push dx
00000D95  45                inc bp
00000D96  41                inc cx
00000D97  54                push sp
00000D98  4F                dec di
00000D99  52                push dx
00000D9A  7F20              jg 0xdbc
00000D9C  2020              and [bx+si],ah
00000D9E  2020              and [bx+si],ah
00000DA0  2D2D2D            sub ax,0x2d2d
00000DA3  2D2D2D            sub ax,0x2d2d
00000DA6  2D2D2D            sub ax,0x2d2d
00000DA9  7F20              jg 0xdcb
00000DAB  2020              and [bx+si],ah
00000DAD  43                inc bx
00000DAE  7261              jc 0xe11
00000DB0  636B65            arpl [bp+di+0x65],bp
00000DB3  722C              jc 0xde1
00000DB5  20436F            and [bp+di+0x6f],al
00000DB8  6465727F          gs jc 0xe3b
00000DBC  2020              and [bx+si],ah
00000DBE  2020              and [bx+si],ah
00000DC0  2020              and [bx+si],ah
00000DC2  4D                dec bp
00000DC3  7573              jnz 0xe38
00000DC5  696369616E        imul sp,[bp+di+0x69],0x6e61
00000DCA  7F20              jg 0xdec
00000DCC  2020              and [bx+si],ah
00000DCE  323A              xor bh,[bp+si]
00000DD0  353032            xor ax,0x3230
00000DD3  302F              xor [bx],ch
00000DD5  3131              xor [bx+di],si
00000DD7  382E3131          cmp [0x3131],ch
00000DDB  7F7F              jg 0xe5c
00000DDD  2020              and [bx+si],ah
00000DDF  2020              and [bx+si],ah
00000DE1  2020              and [bx+si],ah
00000DE3  4B                dec bx
00000DE4  50                push ax
00000DE5  4F                dec di
00000DE6  42                inc dx
00000DE7  4F                dec di
00000DE8  43                inc bx
00000DE9  4F                dec di
00000DEA  43                inc bx
00000DEB  7F20              jg 0xe0d
00000DED  2020              and [bx+si],ah
00000DEF  2020              and [bx+si],ah
00000DF1  2D2D2D            sub ax,0x2d2d
00000DF4  2D2D2D            sub ax,0x2d2d
00000DF7  2D2D2D            sub ax,0x2d2d
00000DFA  2D7F20            sub ax,0x207f
00000DFD  2020              and [bx+si],ah
00000DFF  43                inc bx
00000E00  6F                outsw
00000E01  6465722C          gs jc 0xe31
00000E05  204861            and [bx+si+0x61],cl
00000E08  636B65            arpl [bp+di+0x65],bp
00000E0B  727F              jc 0xe8c
00000E0D  204372            and [bp+di+0x72],al
00000E10  61                popa
00000E11  636B65            arpl [bp+di+0x65],bp
00000E14  722C              jc 0xe42
00000E16  204D75            and [di+0x75],cl
00000E19  7369              jnc 0xe84
00000E1B  636961            arpl [bx+di+0x61],bp
00000E1E  6E                outsb
00000E1F  7F20              jg 0xe41
00000E21  2020              and [bx+si],ah
00000E23  323A              xor bh,[bp+si]
00000E25  353032            xor ax,0x3230
00000E28  302F              xor [bx],ch
00000E2A  3332              xor si,[bp+si]
00000E2C  332E3636          xor bp,[0x3636]
00000E30  367F7F            ss jg 0xeb2
00000E33  2020              and [bx+si],ah
00000E35  2020              and [bx+si],ah
00000E37  2020              and [bx+si],ah
00000E39  204661            and [bp+0x61],al
00000E3C  6C                insb
00000E3D  43                inc bx
00000E3E  6F                outsw
00000E3F  6E                outsb
00000E40  7F20              jg 0xe62
00000E42  2020              and [bx+si],ah
00000E44  2020              and [bx+si],ah
00000E46  202D              and [di],ch
00000E48  2D2D2D            sub ax,0x2d2d
00000E4B  2D2D2D            sub ax,0x2d2d
00000E4E  2D7F20            sub ax,0x207f
00000E51  2020              and [bx+si],ah
00000E53  2020              and [bx+si],ah
00000E55  204372            and [bp+di+0x72],al
00000E58  61                popa
00000E59  636B65            arpl [bp+di+0x65],bp
00000E5C  727F              jc 0xedd
00000E5E  2020              and [bx+si],ah
00000E60  2020              and [bx+si],ah
00000E62  323A              xor bh,[bp+si]
00000E64  353032            xor ax,0x3230
00000E67  322F              xor ch,[bx]
00000E69  342E              xor al,0x2e
00000E6B  3939              cmp [bx+di],di
00000E6D  7F7F              jg 0xeee
00000E6F  2020              and [bx+si],ah
00000E71  2020              and [bx+si],ah
00000E73  2020              and [bx+si],ah
00000E75  204D65            and [di+0x65],cl
00000E78  7465              jz 0xedf
00000E7A  4F                dec di
00000E7B  7F20              jg 0xe9d
00000E7D  2020              and [bx+si],ah
00000E7F  2020              and [bx+si],ah
00000E81  202D              and [di],ch
00000E83  2D2D2D            sub ax,0x2d2d
00000E86  2D2D2D            sub ax,0x2d2d
00000E89  7F20              jg 0xeab
00000E8B  2020              and [bx+si],ah
00000E8D  2020              and [bx+si],ah
00000E8F  204372            and [bp+di+0x72],al
00000E92  61                popa
00000E93  636B65            arpl [bp+di+0x65],bp
00000E96  727F              jc 0xf17
00000E98  2020              and [bx+si],ah
00000E9A  2020              and [bx+si],ah
00000E9C  2032              and [bp+si],dh
00000E9E  3A35              cmp dh,[di]
00000EA0  3033              xor [bp+di],dh
00000EA2  302F              xor [bx],ch
00000EA4  3133              xor [bp+di],si
00000EA6  367F7F            ss jg 0xf28
00000EA9  2020              and [bx+si],ah
00000EAB  2020              and [bx+si],ah
00000EAD  20536B            and [bp+di+0x6b],dl
00000EB0  756C              jnz 0xf1e
00000EB2  6C                insb
00000EB3  43                inc bx
00000EB4  4F                dec di
00000EB5  44                inc sp
00000EB6  45                inc bp
00000EB7  727F              jc 0xf38
00000EB9  2020              and [bx+si],ah
00000EBB  2020              and [bx+si],ah
00000EBD  2D2D2D            sub ax,0x2d2d
00000EC0  2D2D2D            sub ax,0x2d2d
00000EC3  2D2D2D            sub ax,0x2d2d
00000EC6  2D2D2D            sub ax,0x2d2d
00000EC9  7F20              jg 0xeeb
00000ECB  2020              and [bx+si],ah
00000ECD  43                inc bx
00000ECE  7261              jc 0xf31
00000ED0  636B65            arpl [bp+di+0x65],bp
00000ED3  722C              jc 0xf01
00000ED5  20436F            and [bp+di+0x6f],al
00000ED8  6465722C          gs jc 0xf08
00000EDC  7F20              jg 0xefe
00000EDE  2020              and [bx+si],ah
00000EE0  2020              and [bx+si],ah
00000EE2  204465            and [si+0x65],al
00000EE5  6D                insw
00000EE6  6F                outsw
00000EE7  6D                insw
00000EE8  61                popa
00000EE9  6B65727F          imul sp,[di+0x72],0x7f
00000EED  2020              and [bx+si],ah
00000EEF  2020              and [bx+si],ah
00000EF1  2020              and [bx+si],ah
00000EF3  323A              xor bh,[bp+si]
00000EF5  3436              xor al,0x36
00000EF7  3331              xor si,[bx+di]
00000EF9  2F                das
00000EFA  37                aaa
00000EFB  7F7F              jg 0xf7c
00000EFD  2020              and [bx+si],ah
00000EFF  2020              and [bx+si],ah
00000F01  2020              and [bx+si],ah
00000F03  694E56454E        imul cx,[bp+0x56],0x4e45
00000F08  54                push sp
00000F09  4F                dec di
00000F0A  52                push dx
00000F0B  7F20              jg 0xf2d
00000F0D  2020              and [bx+si],ah
00000F0F  2020              and [bx+si],ah
00000F11  2D2D2D            sub ax,0x2d2d
00000F14  2D2D2D            sub ax,0x2d2d
00000F17  2D2D2D            sub ax,0x2d2d
00000F1A  2D7F20            sub ax,0x207f
00000F1D  2020              and [bx+si],ah
00000F1F  43                inc bx
00000F20  7261              jc 0xf83
00000F22  636B65            arpl [bp+di+0x65],bp
00000F25  722C              jc 0xf53
00000F27  20436F            and [bp+di+0x6f],al
00000F2A  6465727F          gs jc 0xfad
00000F2E  2020              and [bx+si],ah
00000F30  2020              and [bx+si],ah
00000F32  2032              and [bp+si],dh
00000F34  3A34              cmp dh,[si]
00000F36  363235            xor dh,[ss:di]
00000F39  2F                das
00000F3A  322E3132          xor ch,[0x3231]
00000F3E  7F7F              jg 0xfbf
00000F40  2020              and [bx+si],ah
00000F42  2020              and [bx+si],ah
00000F44  204C4F            and [si+0x4f],cl
00000F47  7264              jc 0xfad
00000F49  205661            and [bp+0x61],dl
00000F4C  6465727F          gs jc 0xfcf
00000F50  2020              and [bx+si],ah
00000F52  2020              and [bx+si],ah
00000F54  2D2D2D            sub ax,0x2d2d
00000F57  2D2D2D            sub ax,0x2d2d
00000F5A  2D2D2D            sub ax,0x2d2d
00000F5D  2D2D2D            sub ax,0x2d2d
00000F60  7F20              jg 0xf82
00000F62  2020              and [bx+si],ah
00000F64  2020              and [bx+si],ah
00000F66  2020              and [bx+si],ah
00000F68  43                inc bx
00000F69  7261              jc 0xfcc
00000F6B  636B65            arpl [bp+di+0x65],bp
00000F6E  727F              jc 0xfef
00000F70  2020              and [bx+si],ah
00000F72  2020              and [bx+si],ah
00000F74  2032              and [bp+si],dh
00000F76  3A34              cmp dh,[si]
00000F78  363135            xor [ss:di],si
00000F7B  2F                das
00000F7C  3132              xor [bp+si],si
00000F7E  2E317F7F          xor [cs:bx+0x7f],di
00000F82  2020              and [bx+si],ah
00000F84  2020              and [bx+si],ah
00000F86  205069            and [bx+si+0x69],dl
00000F89  58                pop ax
00000F8A  7445              jz 0xfd1
00000F8C  52                push dx
00000F8D  4D                dec bp
00000F8E  694F4D7F20        imul cx,[bx+0x4d],0x207f
00000F93  2020              and [bx+si],ah
00000F95  202D              and [di],ch
00000F97  2D2D2D            sub ax,0x2d2d
00000F9A  2D2D2D            sub ax,0x2d2d
00000F9D  2D2D2D            sub ax,0x2d2d
00000FA0  2D2D7F            sub ax,0x7f2d
00000FA3  204372            and [bp+di+0x72],al
00000FA6  61                popa
00000FA7  636B65            arpl [bp+di+0x65],bp
00000FAA  722C              jc 0xfd8
00000FAC  204772            and [bx+0x72],al
00000FAF  61                popa
00000FB0  66696369616E7F20  imul esp,[bp+di+0x69],0x207f6e61
00000FB8  2020              and [bx+si],ah
00000FBA  2020              and [bx+si],ah
00000FBC  2020              and [bx+si],ah
00000FBE  57                push di
00000FBF  7269              jc 0x102a
00000FC1  7465              jz 0x1028
00000FC3  727F              jc 0x1044
00000FC5  2020              and [bx+si],ah
00000FC7  2020              and [bx+si],ah
00000FC9  2032              and [bp+si],dh
00000FCB  3A35              cmp dh,[di]
00000FCD  3037              xor [bx],dh
00000FCF  302F              xor [bx],ch
00000FD1  3235              xor dh,[di]
00000FD3  2E397F7F          cmp [cs:bx+0x7f],di
00000FD7  2020              and [bx+si],ah
00000FD9  2020              and [bx+si],ah
00000FDB  2020              and [bx+si],ah
00000FDD  204D45            and [di+0x45],cl
00000FE0  4E                dec si
00000FE1  54                push sp
00000FE2  4F                dec di
00000FE3  52                push dx
00000FE4  7F20              jg 0x1006
00000FE6  2020              and [bx+si],ah
00000FE8  2020              and [bx+si],ah
00000FEA  202D              and [di],ch
00000FEC  2D2D2D            sub ax,0x2d2d
00000FEF  2D2D2D            sub ax,0x2d2d
00000FF2  2D7F20            sub ax,0x207f
00000FF5  2020              and [bx+si],ah
00000FF7  43                inc bx
00000FF8  7261              jc 0x105b
00000FFA  636B65            arpl [bp+di+0x65],bp
00000FFD  722C              jc 0x102b
00000FFF  20436F            and [bp+di+0x6f],al
00001002  6465727F          gs jc 0x1085
00001006  2020              and [bx+si],ah
00001008  2020              and [bx+si],ah
0000100A  2032              and [bp+si],dh
0000100C  3A34              cmp dh,[si]
0000100E  37                aaa
0000100F  382F              cmp [bx],ch
00001011  31362E32          xor [0x322e],si
00001015  7F7F              jg 0x1096
00001017  2020              and [bx+si],ah
00001019  2020              and [bx+si],ah
0000101B  2020              and [bx+si],ah
0000101D  50                push ax
0000101E  43                inc bx
0000101F  4F                dec di
00001020  52                push dx
00001021  2441              and al,0x41
00001023  49                dec cx
00001024  52                push dx
00001025  7F20              jg 0x1047
00001027  2020              and [bx+si],ah
00001029  2020              and [bx+si],ah
0000102B  2D2D2D            sub ax,0x2d2d
0000102E  2D2D2D            sub ax,0x2d2d
00001031  2D2D2D            sub ax,0x2d2d
00001034  2D7F20            sub ax,0x207f
00001037  204372            and [bp+di+0x72],al
0000103A  61                popa
0000103B  636B65            arpl [bp+di+0x65],bp
0000103E  722C              jc 0x106c
00001040  204861            and [bx+si+0x61],cl
00001043  636B65            arpl [bp+di+0x65],bp
00001046  727F              jc 0x10c7
00001048  2020              and [bx+si],ah
0000104A  2020              and [bx+si],ah
0000104C  2020              and [bx+si],ah
0000104E  20436F            and [bp+di+0x6f],al
00001051  6465727F          gs jc 0x10d4
00001055  2020              and [bx+si],ah
00001057  2020              and [bx+si],ah
00001059  323A              xor bh,[bp+si]
0000105B  353037            xor ax,0x3730
0000105E  302F              xor [bx],ch
00001060  3137              xor [bx],si
00001062  2E327F7F          xor bh,[cs:bx+0x7f]
00001066  2020              and [bx+si],ah
00001068  204368            and [bp+di+0x68],al
0000106B  61                popa
0000106C  726C              jc 0x10da
0000106E  657320            gs jnc 0x1091
00001071  4B                dec bx
00001072  6C                insb
00001073  7564              jnz 0x10d9
00001075  67657F20          gs a32 jg 0x1099
00001079  202D              and [di],ch
0000107B  2D2D2D            sub ax,0x2d2d
0000107E  2D2D2D            sub ax,0x2d2d
00001081  2D2D2D            sub ax,0x2d2d
00001084  2D2D2D            sub ax,0x2d2d
00001087  2D2D2D            sub ax,0x2d2d
0000108A  7F20              jg 0x10ac
0000108C  204372            and [bp+di+0x72],al
0000108F  61                popa
00001090  636B65            arpl [bp+di+0x65],bp
00001093  722C              jc 0x10c1
00001095  204861            and [bx+si+0x61],cl
00001098  636B65            arpl [bp+di+0x65],bp
0000109B  727F              jc 0x111c
0000109D  2020              and [bx+si],ah
0000109F  2020              and [bx+si],ah
000010A1  2020              and [bx+si],ah
000010A3  20436F            and [bp+di+0x6f],al
000010A6  6465727F          gs jc 0x1129
000010AA  2020              and [bx+si],ah
000010AC  2020              and [bx+si],ah
000010AE  323A              xor bh,[bp+si]
000010B0  353033            xor ax,0x3330
000010B3  302F              xor [bx],ch
000010B5  362E3635307F      ss xor ax,0x7f30
000010BB  7F20              jg 0x10dd
000010BD  2020              and [bx+si],ah
000010BF  2020              and [bx+si],ah
000010C1  205769            and [bx+0x69],dl
000010C4  7365              jnc 0x112b
000010C6  47                inc di
000010C7  7579              jnz 0x1142
000010C9  7F20              jg 0x10eb
000010CB  2020              and [bx+si],ah
000010CD  2020              and [bx+si],ah
000010CF  2D2D2D            sub ax,0x2d2d
000010D2  2D2D2D            sub ax,0x2d2d
000010D5  2D2D2D            sub ax,0x2d2d
000010D8  7F20              jg 0x10fa
000010DA  2020              and [bx+si],ah
000010DC  2020              and [bx+si],ah
000010DE  204372            and [bp+di+0x72],al
000010E1  61                popa
000010E2  636B65            arpl [bp+di+0x65],bp
000010E5  727F              jc 0x1166
000010E7  2020              and [bx+si],ah
000010E9  2032              and [bp+si],dh
000010EB  3A35              cmp dh,[di]
000010ED  3032              xor [bp+si],dh
000010EF  302F              xor [bx],ch
000010F1  3237              xor dh,[bx]
000010F3  312E3138          xor [0x3831],bp
000010F7  7F7F              jg 0x1178
000010F9  2020              and [bx+si],ah
000010FB  2020              and [bx+si],ah
000010FD  2020              and [bx+si],ah
000010FF  2020              and [bx+si],ah
00001101  6B61627F          imul sp,[bx+di+0x62],0x7f
00001105  2020              and [bx+si],ah
00001107  2020              and [bx+si],ah
00001109  2020              and [bx+si],ah
0000110B  202D              and [di],ch
0000110D  2D2D2D            sub ax,0x2d2d
00001110  2D7F20            sub ax,0x207f
00001113  2020              and [bx+si],ah
00001115  43                inc bx
00001116  7261              jc 0x1179
00001118  636B65            arpl [bp+di+0x65],bp
0000111B  722C              jc 0x1149
0000111D  20436F            and [bp+di+0x6f],al
00001120  6465727F          gs jc 0x11a3
00001124  2020              and [bx+si],ah
00001126  2020              and [bx+si],ah
00001128  20496E            and [bx+di+0x6e],cl
0000112B  7472              jz 0x119f
0000112D  6F                outsw
0000112E  6D                insw
0000112F  61                popa
00001130  6B65727F          imul sp,[di+0x72],0x7f
00001134  2020              and [bx+si],ah
00001136  2020              and [bx+si],ah
00001138  2032              and [bp+si],dh
0000113A  3A35              cmp dh,[di]
0000113C  3030              xor [bx+si],dh
0000113E  302F              xor [bx],ch
00001140  3333              xor si,[bp+di]
00001142  7F7F              jg 0x11c3
00001144  2020              and [bx+si],ah
00001146  2020              and [bx+si],ah
00001148  2020              and [bx+si],ah
0000114A  207453            and [si+0x53],dh
0000114D  724D              jc 0x119c
0000114F  61                popa
00001150  4E                dec si
00001151  7F20              jg 0x1173
00001153  2020              and [bx+si],ah
00001155  2020              and [bx+si],ah
00001157  202D              and [di],ch
00001159  2D2D2D            sub ax,0x2d2d
0000115C  2D2D2D            sub ax,0x2d2d
0000115F  2D7F20            sub ax,0x207f
00001162  2020              and [bx+si],ah
00001164  43                inc bx
00001165  7261              jc 0x11c8
00001167  636B65            arpl [bp+di+0x65],bp
0000116A  722C              jc 0x1198
0000116C  20436F            and [bp+di+0x6f],al
0000116F  6465727F          gs jc 0x11f2
00001173  2020              and [bx+si],ah
00001175  2020              and [bx+si],ah
00001177  2020              and [bx+si],ah
00001179  204861            and [bx+si+0x61],cl
0000117C  636B65            arpl [bp+di+0x65],bp
0000117F  727F              jc 0x1200
00001181  2020              and [bx+si],ah
00001183  2020              and [bx+si],ah
00001185  323A              xor bh,[bp+si]
00001187  353039            xor ax,0x3930
0000118A  302F              xor [bx],ch
0000118C  3131              xor [bx+di],si
0000118E  2E337F7F          xor di,[cs:bx+0x7f]
00001192  7F20              jg 0x11b4
00001194  2020              and [bx+si],ah
00001196  4E                dec si
00001197  6F                outsw
00001198  207072            and [bx+si+0x72],dh
0000119B  657369            gs jnc 0x1207
0000119E  64656E            gs outsb
000011A1  7421              jz 0x11c4
000011A3  217F20            and [bx+0x20],di
000011A6  20416C            and [bx+di+0x6c],al
000011A9  6C                insb
000011AA  206D65            and [di+0x65],ch
000011AD  6D                insw
000011AE  626572            bound sp,[di+0x72]
000011B1  7320              jnc 0x11d3
000011B3  686176            push word 0x7661
000011B6  657F20            gs jg 0x11d9
000011B9  2020              and [bx+si],ah
000011BB  657175            gs jno 0x1233
000011BE  61                popa
000011BF  6C                insb
000011C0  207269            and [bp+si+0x69],dh
000011C3  67687473          a32 push word 0x7374
000011C7  2121              and [bx+di],sp
000011C9  7F20              jg 0x11eb
000011CB  46                inc si
000011CC  756C              jnz 0x123a
000011CE  6C                insb
000011CF  206465            and [si+0x65],ah
000011D2  6D                insw
000011D3  6F                outsw
000011D4  637261            arpl [bp+si+0x61],si
000011D7  63792E            arpl [bx+di+0x2e],di
000011DA  2E2E7F7F          {pn} jg 0x125d
000011DE  7F57              jg 0x1237
000011E0  65206172          and [gs:bx+di+0x72],ah
000011E4  656E              gs outsb
000011E6  27                daa
000011E7  7420              jz 0x1209
000011E9  7365              jnc 0x1250
000011EB  61                popa
000011EC  7263              jc 0x1251
000011EE  68696E            push word 0x6e69
000011F1  677F66            a32 jg 0x125a
000011F4  6F                outsw
000011F5  7220              jc 0x1217
000011F7  6E                outsb
000011F8  7520              jnz 0x121a
000011FA  6D                insw
000011FB  656D              gs insw
000011FD  626572            bound sp,[di+0x72]
00001200  732C              jnc 0x122e
00001202  206275            and [bp+si+0x75],ah
00001205  64647F20          fs jg 0x1229
00001209  2020              and [bx+si],ah
0000120B  6966205520        imul sp,[bp+0x20],0x2055
00001210  61                popa
00001211  7265              jc 0x1278
00001213  206120            and [bx+di+0x20],ah
00001216  677238            a32 jc 0x1251
00001219  7F20              jg 0x123b
0000121B  637261            arpl [bp+si+0x61],si
0000121E  636B65            arpl [bp+di+0x65],bp
00001221  7220              jc 0x1243
00001223  55                push bp
00001224  206361            and [bp+di+0x61],ah
00001227  6E                outsb
00001228  206A6F            and [bp+si+0x6f],ch
0000122B  696E7F2020        imul bp,[bp+0x7f],0x2020
00001230  7573              jnz 0x12a5
00001232  206279            and [bp+si+0x79],ah
00001235  20706F            and [bx+si+0x6f],dh
00001238  7374              jnc 0x12ae
0000123A  696E672061        imul bp,[bp+0x67],0x6120
0000123F  7F20              jg 0x1261
00001241  6D                insw
00001242  657373            gs jnc 0x12b8
00001245  61                popa
00001246  676520746F20      and [gs:edi+ebp*2+0x20],dh
0000124C  61                popa
0000124D  6E                outsb
0000124E  7920              jns 0x1270
00001250  6F                outsw
00001251  667F20            jg 0x1274
00001254  2020              and [bx+si],ah
00001256  206F75            and [bx+0x75],ch
00001259  7220              jc 0x127b
0000125B  6D                insw
0000125C  656D              gs insw
0000125E  626572            bound sp,[di+0x72]
00001261  732E              jnc 0x1291
00001263  7F7F              jg 0x12e4
00001265  204F75            and [bx+0x75],cl
00001268  7220              jc 0x128a
0000126A  677265            a32 jc 0x12d2
0000126D  657473            gs jz 0x12e3
00001270  20666C            and [bp+0x6c],ah
00001273  7920              jns 0x1295
00001275  746F              jz 0x12e6
00001277  3A7F20            cmp bh,[bx+0x20]
0000127A  20416C            and [bx+di+0x6c],al
0000127D  6C                insb
0000127E  206372            and [bp+di+0x72],ah
00001281  61                popa
00001282  636B2D            arpl [bp+di+0x2d],bp
00001285  6D                insw
00001286  61                popa
00001287  6B657273          imul sp,[di+0x72],0x73
0000128B  7F20              jg 0x12ad
0000128D  67726F            a32 jc 0x12ff
00001290  7570              jnz 0x1302
00001292  7320              jnc 0x12b4
00001294  61                popa
00001295  7420              jz 0x12b7
00001297  45                inc bp
00001298  782D              js 0x12c7
0000129A  55                push bp
0000129B  53                push bx
0000129C  53                push bx
0000129D  52                push dx
0000129E  217F7F            and [bx+0x7f],di
000012A1  7F7F              jg 0x1322
000012A3  2020              and [bx+si],ah
000012A5  20694E            and [bx+di+0x4e],ch
000012A8  7472              jz 0x131c
000012AA  4F                dec di
000012AB  205265            and [bp+si+0x65],dl
000012AE  6C                insb
000012AF  6561              gs popa
000012B1  7365              jnc 0x1318
000012B3  647F61            fs jg 0x1317
000012B6  7420              jz 0x12d8
000012B8  3033              xor [bp+di],dh
000012BA  2D3033            sub ax,0x3330
000012BD  2D3936            sub ax,0x3639
000012C0  2039              and [bx+di],bh
000012C2  3A33              cmp dh,[bp+di]
000012C4  363A30            cmp dh,[ss:bx+si]
000012C7  32707F            xor dh,[bx+si+0x7f]
000012CA  2020              and [bx+si],ah
000012CC  206279            and [bp+si+0x79],ah
000012CF  2020              and [bx+si],ah
000012D1  53                push bx
000012D2  6B756C6C          imul si,[di+0x6c],0x6c
000012D6  43                inc bx
000012D7  4F                dec di
000012D8  44                inc sp
000012D9  45                inc bp
000012DA  727F              jc 0x135b
000012DC  7F43              jg 0x1321
000012DE  6F                outsw
000012DF  64653A20          cmp ah,[gs:bx+si]
000012E3  53                push bx
000012E4  6B756C6C          imul si,[di+0x6c],0x6c
000012E8  43                inc bx
000012E9  4F                dec di
000012EA  44                inc sp
000012EB  45                inc bp
000012EC  727F              jc 0x136d
000012EE  54                push sp
000012EF  6E                outsb
000012F0  7820              js 0x1312
000012F2  3220              xor ah,[bx+si]
000012F4  42                inc dx
000012F5  6F                outsw
000012F6  726C              jc 0x1364
000012F8  61                popa
000012F9  6E                outsb
000012FA  642F              fs das
000012FC  57                push di
000012FD  61                popa
000012FE  7463              jz 0x1363
00001300  6F                outsw
00001301  6D                insw
00001302  7F7F              jg 0x1383
00001304  47                inc di
00001305  7266              jc 0x136d
00001307  783A              js 0x1343
00001309  20536B            and [bp+di+0x6b],dl
0000130C  756C              jnz 0x137a
0000130E  6C                insb
0000130F  43                inc bx
00001310  4F                dec di
00001311  44                inc sp
00001312  45                inc bp
00001313  727F              jc 0x1394
00001315  47                inc di
00001316  7265              jc 0x137d
00001318  657473            gs jz 0x138e
0000131B  2032              and [bp+si],dh
0000131D  204175            and [bx+di+0x75],al
00001320  746F              jz 0x1391
00001322  44                inc sp
00001323  65736B            gs jnc 0x1391
00001326  217F7F            and [bx+0x7f],di
00001329  54                push sp
0000132A  7261              jc 0x138d
0000132C  783A              js 0x1368
0000132E  20536F            and [bp+di+0x6f],dl
00001331  6D                insw
00001332  65206F6C          and [gs:bx+0x6c],ch
00001336  64206D75          and [fs:di+0x75],ch
0000133A  7A61              jpe 0x139d
0000133C  787F              js 0x13bd
0000133E  7265              jc 0x13a5
00001340  6D                insw
00001341  61                popa
00001342  6B652062          imul sp,[di+0x20],0x62
00001346  7920              jns 0x1368
00001348  53                push bx
00001349  6B756C6C          imul si,[di+0x6c],0x6c
0000134D  43                inc bx
0000134E  4F                dec di
0000134F  44                inc sp
00001350  45                inc bp
00001351  727F              jc 0x13d2
00001353  54                push sp
00001354  6E                outsb
00001355  7820              js 0x1377
00001357  3220              xor ah,[bx+si]
00001359  46                inc si
0000135A  43                inc bx
0000135B  2034              and [si],dh
0000135D  205354            and [bp+di+0x54],dl
00001360  2033              and [bp+di],dh
00001362  2E3031            xor [cs:bx+di],dh
00001365  6221              bound sp,[bx+di]
00001367  7F7F              jg 0x13e8
00001369  46                inc si
0000136A  6F                outsw
0000136B  6E                outsb
0000136C  743A              jz 0x13a8
0000136E  20536B            and [bp+di+0x6b],dl
00001371  756C              jnz 0x13df
00001373  6C                insb
00001374  43                inc bx
00001375  4F                dec di
00001376  44                inc sp
00001377  45                inc bp
00001378  727F              jc 0x13f9
0000137A  57                push di
0000137B  697A204D44        imul di,[bp+si+0x20],0x444d
00001380  46                inc si
00001381  2031              and [bx+di],dh
00001383  2E3130            xor [cs:bx+si],si
00001386  206279            and [bp+si+0x79],ah
00001389  204149            and [bx+di+0x49],al
0000138C  4E                dec si
0000138D  47                inc di
0000138E  7F54              jg 0x13e4
00001390  686E78            push word 0x786e
00001393  2034              and [si],dh
00001395  205572            and [di+0x72],dl
00001398  206772            and [bx+0x72],ah
0000139B  3820              cmp [bx+si],ah
0000139D  7374              jnc 0x1413
0000139F  7566              jnz 0x1407
000013A1  66217F7F          and [bx+0x7f],edi
000013A5  7F20              jg 0x13c7
000013A7  2020              and [bx+si],ah
000013A9  205468            and [si+0x68],dl
000013AC  40                inc ax
000013AD  27                daa
000013AE  7320              jnc 0x13d0
000013B0  61                popa
000013B1  6C                insb
000013B2  6C                insb
000013B3  2E2E2E7F20        {pn} jg 0x13d8
000013B8  2020              and [bx+si],ah
000013BA  2020              and [bx+si],ah
000013BC  2020              and [bx+si],ah
000013BE  43                inc bx
000013BF  205520            and [di+0x20],dl
000013C2  6C                insb
000013C3  3821              cmp [bx+di],ah
000013C5  7F7F              jg 0x1446
000013C7  7E7B              jng 0x1444
000013C9  7C7D              jl 0x1448
000013CB  7D7D              jnl 0x144a
000013CD  7D7D              jnl 0x144c
000013CF  7D7D              jnl 0x144e
000013D1  7D2B              jnl 0x13fe
000013D3  2B2B              sub bp,[bp+di]
000013D5  2B2B              sub bp,[bp+di]
000013D7  2B2B              sub bp,[bp+di]
000013D9  2B2A              sub bp,[bp+si]
000013DB  257F7B            and ax,0x7b7f
000013DE  7C7D              jl 0x145d
000013E0  2020              and [bx+si],ah
000013E2  2020              and [bx+si],ah
000013E4  20474F            and [bx+0x4f],al
000013E7  4F                dec di
000013E8  44                inc sp
000013E9  2020              and [bx+si],ah
000013EB  2020              and [bx+si],ah
000013ED  202B              and [bp+di],ch
000013EF  2A25              sub ah,[di]
000013F1  7F7B              jg 0x146e
000013F3  7C7D              jl 0x1472
000013F5  7B7C              jpo 0x1473
000013F7  7D20              jnl 0x1419
000013F9  207B20            and [bp+di+0x20],bh
000013FC  2025              and [di],ah
000013FE  202B              and [bp+di],ch
00001400  2A7B7C            sub bh,[bp+di+0x7c]
00001403  2B2A              sub bp,[bp+si]
00001405  257F7B            and ax,0x7b7f
00001408  7C7D              jl 0x1487
0000140A  7B7C              jpo 0x1488
0000140C  207D20            and [di+0x20],bh
0000140F  7B20              jpo 0x1431
00001411  2025              and [di],ah
00001413  202B              and [bp+di],ch
00001415  2A20              sub ah,[bx+si]
00001417  202B              and [bp+di],ch
00001419  2A25              sub ah,[di]
0000141B  7F7B              jg 0x1498
0000141D  7C7D              jl 0x149c
0000141F  7B7C              jpo 0x149d
00001421  7D20              jnl 0x1443
00001423  2020              and [bx+si],ah
00001425  2B2A              sub bp,[bp+si]
00001427  25202B            and ax,0x2b20
0000142A  2A7B20            sub bh,[bp+di+0x20]
0000142D  2B2A              sub bp,[bp+si]
0000142F  257F7B            and ax,0x7b7f
00001432  7C7D              jl 0x14b1
00001434  7B7C              jpo 0x14b2
00001436  207D20            and [di+0x20],bh
00001439  2020              and [bx+si],ah
0000143B  2A25              sub ah,[di]
0000143D  202B              and [bp+di],ch
0000143F  2A20              sub ah,[bx+si]
00001441  202B              and [bp+di],ch
00001443  2A25              sub ah,[di]
00001445  7F7B              jg 0x14c2
00001447  7C7D              jl 0x14c6
00001449  7B7C              jpo 0x14c7
0000144B  7D20              jnl 0x146d
0000144D  202B              and [bp+di],ch
0000144F  2A25              sub ah,[di]
00001451  2020              and [bx+si],ah
00001453  2B2A              sub bp,[bp+si]
00001455  7B7C              jpo 0x14d3
00001457  2B2A              sub bp,[bp+si]
00001459  257F7B            and ax,0x7b7f
0000145C  7C7D              jl 0x14db
0000145E  2020              and [bx+si],ah
00001460  2020              and [bx+si],ah
00001462  2020              and [bx+si],ah
00001464  2020              and [bx+si],ah
00001466  2020              and [bx+si],ah
00001468  2020              and [bx+si],ah
0000146A  2020              and [bx+si],ah
0000146C  2B2A              sub bp,[bp+si]
0000146E  257F7B            and ax,0x7b7f
00001471  7C7D              jl 0x14f0
00001473  7D7D              jnl 0x14f2
00001475  7D7D              jnl 0x14f4
00001477  7D7D              jnl 0x14f6
00001479  7D2B              jnl 0x14a6
0000147B  2B2B              sub bp,[bp+di]
0000147D  2B2B              sub bp,[bp+di]
0000147F  2B2B              sub bp,[bp+di]
00001481  2B2A              sub bp,[bp+si]
00001483  257F7B            and ax,0x7b7f
00001486  7C7D              jl 0x1505
00001488  2020              and [bx+si],ah
0000148A  2020              and [bx+si],ah
0000148C  2020              and [bx+si],ah
0000148E  2020              and [bx+si],ah
00001490  2020              and [bx+si],ah
00001492  2020              and [bx+si],ah
00001494  2020              and [bx+si],ah
00001496  2B2A              sub bp,[bp+si]
00001498  257F00            and ax,0x7f
0000149B  0000              add [bx+si],al
0000149D  0000              add [bx+si],al
0000149F  0000              add [bx+si],al
000014A1  0038              add [bx+si],bh
000014A3  3838              cmp [bx+si],bh
000014A5  3818              cmp [bx+si],bl
000014A7  0018              add [bx+si],bl
000014A9  006666            add [bp+0x66],ah
000014AC  660000            o32 add [bx+si],al
000014AF  0000              add [bx+si],al
000014B1  00367F36          add [0x367f],dh
000014B5  367F36            ss jg 0x14ee
000014B8  0000              add [bx+si],al
000014BA  183E603C          sbb [0x3c60],bh
000014BE  06                push es
000014BF  7C18              jl 0x14d9
000014C1  007EAE            add [bp-0x52],bh
000014C4  5E                pop si
000014C5  B6DE              mov dh,0xde
000014C7  6ABE              push word 0xffffffffffffffbe
000014C9  56                push si
000014CA  1C36              sbb al,0x36
000014CC  1C38              sbb al,0x38
000014CE  6F                outsw
000014CF  663B00            cmp eax,[bx+si]
000014D2  1818              sbb [bx+si],bl
000014D4  1800              sbb [bx+si],al
000014D6  0000              add [bx+si],al
000014D8  0000              add [bx+si],al
000014DA  1C18              sbb al,0x18
000014DC  1838              sbb [bx+si],bh
000014DE  3838              cmp [bx+si],bh
000014E0  3C00              cmp al,0x0
000014E2  7030              jo 0x1514
000014E4  3038              xor [bx+si],bh
000014E6  3838              cmp [bx+si],bh
000014E8  7800              js 0x14ea
000014EA  026915            add ch,[bx+di+0x15]
000014ED  02578A            add dl,[bx-0x76]
000014F0  2114              and [si],dx
000014F2  0001              add [bx+di],al
000014F4  0800              or [bx+si],al
000014F6  40                inc ax
000014F7  0422              add al,0x22
000014F9  0000              add [bx+si],al
000014FB  0000              add [bx+si],al
000014FD  0000              add [bx+si],al
000014FF  1818              sbb [bx+si],bl
00001501  3000              xor [bx+si],al
00001503  0000              add [bx+si],al
00001505  7E00              jng 0x1507
00001507  0000              add [bx+si],al
00001509  0000              add [bx+si],al
0000150B  0000              add [bx+si],al
0000150D  0000              add [bx+si],al
0000150F  1818              sbb [bx+si],bl
00001511  0003              add [bp+di],al
00001513  06                push es
00001514  0C18              or al,0x18
00001516  306040            xor [bx+si+0x40],ah
00001519  007C82            add [si-0x7e],bh
0000151C  C60082            mov byte [bx+si],0x82
0000151F  C6827C0206        mov byte [bp+si+0x27c],0x6
00001524  06                push es
00001525  0002              add [bp+si],al
00001527  06                push es
00001528  06                push es
00001529  027C02            add bh,[si+0x2]
0000152C  06                push es
0000152D  38C0              cmp al,al
0000152F  C0807C7C02        rol byte [bx+si+0x7c7c],byte 0x2
00001534  06                push es
00001535  38060602          cmp [0x206],al
00001539  7C82              jl 0x14bd
0000153B  C6827C0206        mov byte [bp+si+0x27c],0x6
00001540  06                push es
00001541  027C80            add bh,[si-0x80]
00001544  C03806            sar byte [bx+si],byte 0x6
00001547  06                push es
00001548  027C7C            add bh,[si+0x7c]
0000154B  80C038            add al,0x38
0000154E  C6C682            mov dh,0x82
00001551  7C78              jl 0x15cb
00001553  06                push es
00001554  06                push es
00001555  0002              add [bp+si],al
00001557  06                push es
00001558  06                push es
00001559  027C82            add bh,[si-0x7e]
0000155C  C6                db 0xc6
0000155D  38C6              cmp dh,al
0000155F  C6827C7C82        mov byte [bp+si+0x7c7c],0x82
00001564  C6                db 0xc6
00001565  38060602          cmp [0x206],al
00001569  7C00              jl 0x156b
0000156B  1010              adc [bx+si],dl
0000156D  0000              add [bx+si],al
0000156F  1010              adc [bx+si],dl
00001571  0000              add [bx+si],al
00001573  1010              adc [bx+si],dl
00001575  0000              add [bx+si],al
00001577  1010              adc [bx+si],dl
00001579  2008              and [bx+si],cl
0000157B  1020              adc [bx+si],ah
0000157D  40                inc ax
0000157E  2010              and [bx+si],dl
00001580  0800              or [bx+si],al
00001582  0000              add [bx+si],al
00001584  007E00            add [bp+0x0],bh
00001587  7E00              jng 0x1589
00001589  0010              add [bx+si],dl
0000158B  0804              or [si],al
0000158D  0204              add al,[si]
0000158F  0810              or [bx+si],dl
00001591  003C              add [si],bh
00001593  42                inc dx
00001594  0204              add al,[si]
00001596  0800              or [bx+si],al
00001598  0800              or [bx+si],al
0000159A  7F63              jg 0x15ff
0000159C  6F                outsw
0000159D  6F                outsw
0000159E  6F                outsw
0000159F  60                pusha
000015A0  7F00              jg 0x15a2
000015A2  3F                aas
000015A3  3333              xor si,[bp+di]
000015A5  7F73              jg 0x161a
000015A7  7373              jnc 0x161c
000015A9  007E66            add [bp+0x66],bh
000015AC  667F67            jg 0x1616
000015AF  677F00            a32 jg 0x15b2
000015B2  7F67              jg 0x161b
000015B4  60                pusha
000015B5  60                pusha
000015B6  63637F            arpl [bp+di+0x7f],sp
000015B9  007E46            add [bp+0x46],bh
000015BC  46                inc si
000015BD  636363            arpl [bp+di+0x63],sp
000015C0  7F00              jg 0x15c2
000015C2  7F60              jg 0x1624
000015C4  60                pusha
000015C5  7F70              jg 0x1637
000015C7  707F              jo 0x1648
000015C9  007F60            add [bx+0x60],bh
000015CC  60                pusha
000015CD  7F70              jg 0x163f
000015CF  7070              jo 0x1641
000015D1  007F63            add [bx+0x63],bh
000015D4  60                pusha
000015D5  6F                outsw
000015D6  67677F00          a32 jg 0x15da
000015DA  7373              jnc 0x164f
000015DC  737F              jnc 0x165d
000015DE  7373              jnc 0x1653
000015E0  7300              jnc 0x15e2
000015E2  0C0C              or al,0xc
000015E4  0C0C              or al,0xc
000015E6  1C1C              sbb al,0x1c
000015E8  1C00              sbb al,0x0
000015EA  0C0C              or al,0xc
000015EC  0C0E              or al,0xe
000015EE  0E                push cs
000015EF  6E                outsb
000015F0  7E00              jng 0x15f2
000015F2  66666C            o32 insb
000015F5  7F67              jg 0x165e
000015F7  67670030          add [eax],dh
000015FB  3030              xor [bx+si],dh
000015FD  7070              jo 0x166f
000015FF  707E              jo 0x167f
00001601  00677F            add [bx+0x7f],ah
00001604  7B53              jpo 0x1659
00001606  43                inc bx
00001607  43                inc bx
00001608  43                inc bx
00001609  006373            add [bp+di+0x73],ah
0000160C  7B6F              jpo 0x167d
0000160E  676767007F63      add [edi+0x63],bh
00001614  636767            arpl [bx+0x67],sp
00001617  677F00            a32 jg 0x161a
0000161A  7F63              jg 0x167f
0000161C  637F70            arpl [bx+0x70],di
0000161F  7070              jo 0x1691
00001621  007F63            add [bx+0x63],bh
00001624  636367            arpl [bp+di+0x67],sp
00001627  677F07            a32 jg 0x1631
0000162A  7E46              jng 0x1672
0000162C  46                inc si
0000162D  7F67              jg 0x1696
0000162F  6767007F60        add [edi+0x60],bh
00001634  7F03              jg 0x1639
00001636  7373              jnc 0x16ab
00001638  7F00              jg 0x163a
0000163A  7F1C              jg 0x1658
0000163C  1C1C              sbb al,0x1c
0000163E  1C1C              sbb al,0x1c
00001640  1C00              sbb al,0x0
00001642  6767676767677F00  a32 jg 0x164a
0000164A  676767676F        a32 outsw
0000164F  3E1C00            ds sbb al,0x0
00001652  636363            arpl [bp+di+0x63],sp
00001655  6B7F7767          imul di,[bx+0x77],0x67
00001659  007373            add [bp+di+0x73],dh
0000165C  733E              jnc 0x169c
0000165E  676767006767      add [edi+0x67],ah
00001664  677F1C            a32 jg 0x1683
00001667  1C1C              sbb al,0x1c
00001669  007F66            add [bx+0x66],bh
0000166C  6C                insb
0000166D  1837              sbb [bx],dh
0000166F  677F00            a32 jg 0x1672
00001672  1E                push ds
00001673  1818              sbb [bx+si],bl
00001675  1818              sbb [bx+si],bl
00001677  181E0040          sbb [0x4000],bl
0000167B  60                pusha
0000167C  3018              xor [bx+si],bl
0000167E  0C06              or al,0x6
00001680  0300              add ax,[bx+si]
00001682  7818              js 0x169c
00001684  1818              sbb [bx+si],bl
00001686  1818              sbb [bx+si],bl
00001688  7800              js 0x168a
0000168A  0008              add [bx+si],cl
0000168C  1C36              sbb al,0x36
0000168E  6300              arpl [bx+si],ax
00001690  0000              add [bx+si],al
00001692  0000              add [bx+si],al
00001694  0000              add [bx+si],al
00001696  0000              add [bx+si],al
00001698  00FF              add bh,bh
0000169A  1830              sbb [bx+si],dh
0000169C  2000              and [bx+si],al
0000169E  0000              add [bx+si],al
000016A0  0000              add [bx+si],al
000016A2  0000              add [bx+si],al
000016A4  3F                aas
000016A5  037F67            add di,[bx+0x67]
000016A8  7F00              jg 0x16aa
000016AA  006060            add [bx+si+0x60],ah
000016AD  7F73              jg 0x1722
000016AF  737F              jnc 0x1730
000016B1  0000              add [bx+si],al
000016B3  007F60            add [bx+0x60],bh
000016B6  60                pusha
000016B7  707F              jo 0x1738
000016B9  0000              add [bx+si],al
000016BB  0303              add ax,[bp+di]
000016BD  7F67              jg 0x1726
000016BF  677F00            a32 jg 0x16c2
000016C2  0000              add [bx+si],al
000016C4  7F63              jg 0x1729
000016C6  7F70              jg 0x1738
000016C8  7F00              jg 0x16ca
000016CA  001E187E          add [0x7e18],bl
000016CE  1838              sbb [bx+si],bh
000016D0  3800              cmp [bx+si],al
000016D2  0000              add [bx+si],al
000016D4  7F63              jg 0x1739
000016D6  637F07            arpl [bx+0x7],di
000016D9  7F00              jg 0x16db
000016DB  60                pusha
000016DC  60                pusha
000016DD  7F73              jg 0x1752
000016DF  7373              jnc 0x1754
000016E1  0000              add [bx+si],al
000016E3  0C00              or al,0x0
000016E5  0C0C              or al,0xc
000016E7  1C1C              sbb al,0x1c
000016E9  0000              add [bx+si],al
000016EB  0C00              or al,0x0
000016ED  0C0C              or al,0xc
000016EF  0E                push cs
000016F0  0E                push cs
000016F1  7E00              jng 0x16f3
000016F3  3030              xor [bx+si],dh
000016F5  667C66            jl 0x175e
000016F8  6300              arpl [bx+si],ax
000016FA  0018              add [bx+si],bl
000016FC  1818              sbb [bx+si],bl
000016FE  3838              cmp [bx+si],bh
00001700  3800              cmp [bx+si],al
00001702  0000              add [bx+si],al
00001704  665B              pop ebx
00001706  6B6B6300          imul bp,[bp+di+0x63],0x0
0000170A  0000              add [bx+si],al
0000170C  3F                aas
0000170D  337373            xor si,[bp+di+0x73]
00001710  7300              jnc 0x1712
00001712  0000              add [bx+si],al
00001714  3F                aas
00001715  337373            xor si,[bp+di+0x73]
00001718  7F00              jg 0x171a
0000171A  0000              add [bx+si],al
0000171C  3F                aas
0000171D  33737F            xor si,[bp+di+0x7f]
00001720  7070              jo 0x1792
00001722  0000              add [bx+si],al
00001724  7F63              jg 0x1789
00001726  637F07            arpl [bx+0x7],di
00001729  07                pop es
0000172A  0000              add [bx+si],al
0000172C  3F                aas
0000172D  337070            xor si,[bx+si+0x70]
00001730  7000              jo 0x1732
00001732  0000              add [bx+si],al
00001734  7F60              jg 0x1796
00001736  7F07              jg 0x173f
00001738  7F00              jg 0x173a
0000173A  000C              add [si],cl
0000173C  7E0C              jng 0x174a
0000173E  1C1C              sbb al,0x1c
00001740  1C00              sbb al,0x0
00001742  0000              add [bx+si],al
00001744  3333              xor si,[bp+di]
00001746  7373              jnc 0x17bb
00001748  7F00              jg 0x174a
0000174A  0000              add [bx+si],al
0000174C  636363            arpl [bp+di+0x63],sp
0000174F  361C00            ss sbb al,0x0
00001752  0000              add [bx+si],al
00001754  636B7F            arpl [bp+di+0x7f],bp
00001757  3E360000          add [ss:bx+si],al
0000175B  00667E            add [bp+0x7e],ah
0000175E  187E76            sbb [bp+0x76],bh
00001761  0000              add [bx+si],al
00001763  0033              add [bp+di],dh
00001765  33737F            xor si,[bp+di+0x7f]
00001768  030F              add cx,[bx]
0000176A  0000              add [bx+si],al
0000176C  7E5C              jng 0x17ca
0000176E  18367E00          sbb [0x7e],dh
00001772  7E75              jng 0x17e9
00001774  7A6D              jpe 0x17e3
00001776  7B56              jpo 0x17ce
00001778  7D6A              jnl 0x17e4
0000177A  40                inc ax
0000177B  96                xchg ax,si
0000177C  A840              test al,0x40
0000177E  EA51842800        jmp word 0x28:word 0x8451
00001783  801000            adc byte [bx+si],0x0
00001786  0220              add ah,[bx+si]
00001788  44                inc sp
00001789  0000              add [bx+si],al
0000178B  324C00            xor cl,[si+0x0]
0000178E  0000              add [bx+si],al
00001790  0000              add [bx+si],al
00001792  CC                int3
00001793  33CC              xor cx,sp
00001795  33CC              xor cx,sp
00001797  33CC              xor cx,sp
00001799  3301              xor ax,[bx+di]
0000179B  0000              add [bx+si],al
0000179D  14E1              adc al,0xe1
0000179F  6591              gs xchg ax,cx
000017A1  0156BC            add [bp-0x44],dx
000017A4  2203              and al,[bp+di]
