File 1)	DSK:F33KLN.SLO	created: 1605 28-MAY-82
File 2)	DSK:F33KLN.SLO[3,222635]	created: 1842 27-MAY-82

1)1	;327-exotic: SDD make AOBJx not carry across halves (CFINST)
1)	;326-exotic: SDD change opcodes to use carry for +/- stuff (CFDEF)
1)	;Initialize switch settings
1)	MICROCODE.VERSION = 327	; 9 bits
1)	PROCESSOR.SERIAL = 0	;12 bits
****
2)1	;version 326 (e): Sdaniels AOBJN / AOBJP fix (here + CFINST)
2)	;Initialize switch settings
2)	MICROCODE.VERSION = 326	; 9 bits
2)	PROCESSOR.SERIAL = 0	;12 bits
**************
1)1	; SET F2SW = 1 FOR F2,  F2SW = 0 FOR F3 {{this is a lie}}
1)	F2SW = 1
****
2)1	; SET F2SW = 1 FOR F2,  F2SW = 0 FOR F3
2)	F2SW = 1
**************
1)1	.INSERT TESTIO
1)	LIST-LABELS
1)	LIST-CORMAP
****
2)1	.INSERT CFIO
2)	LIST-LABELS
2)	LIST-CORMAP
**************
 