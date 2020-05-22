epoch_time_1590014373:
	LEA DE,IY+$0		;$ed, $13, $0
	LD IY,$0		;$fd, $21, $0, $0, $0
	ADD IY,SP		;$fd, $39
	LD HL,(IY+$6)		;$fd, $27, $6
	LD BC,$0		;$1, $0, $0, $0
	OR A,A		;$b7
	SBC HL,BC		;$ed, $42
	JR NZ,._lbl_1		;$20, $2
	LD L,$1		;$2e, $1
._lbl_1:		;$=0x2401
	LD IY,(IY+$3)		;$fd, $37, $3
	LD IY,(IY+$3)		;$fd, $31, $3
	LD BC,(IY+$0)		;$fd, $7, $0
	LD IY,(IY+$6)		;$fd, $37, $6
	LD SP,IY		;$fd, $f9
	LD (IY+$0),BC		;$fd, $f, $0
	PUSH DE		;$d5
	POP IY		;$fd, $e1
	RET		;$c9
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	PUSH IY		;$fd, $e5
	LD BC,$2380		;$1, $80, $23, $0
	LD ($d00108),BC		;$ed, $43, $8, $1, $d0
	PEA IX+$c		;$ed, $65, $c
	LD BC,(IX+$9)		;$dd, $7, $9
	PUSH BC		;$c5
	LD BC,(IX+$6)		;$dd, $7, $6
	PUSH BC		;$c5
	CALL ._lbl_2		;$cd, $e3, $26, $0
	POP BC		;$c1
	POP BC		;$c1
	POP BC		;$c1
	POP IY		;$fd, $e1
	POP IX		;$dd, $e1
	RET		;$c9
	LD HL,$3		;$21, $3, $0, $0
	ADD HL,SP		;$39
	LD BC,(HL)		;$ed, $7
	PUSH BC		;$c5
	INC HL		;$23
	INC HL		;$23
	INC HL		;$23
	LD DE,(HL)		;$ed, $17
	LD A,(DE)		;$1a
	OR A,A		;$b7
	JR Z,._lbl_3		;$28, $12
	PUSH BC		;$c5
	POP HL		;$e1
	XOR A,A		;$af
._lbl_4:		;$=0x2455
	CPI		;$ed, $a1
	JR NZ,._lbl_4		;$20, $fc
	DEC HL		;$2b
	EX DE,HL		;$eb
	XOR A,A		;$af
._lbl_6:		;$=0x245c
	CP A,(HL)		;$be
	JR Z,._lbl_5		;$28, $4
	LDI		;$ed, $a0
	JR ._lbl_6		;$18, $f9
._lbl_5:		;$=0x2463
	LD (DE),A		;$12
._lbl_3:		;$=0x2464
	POP HL		;$e1
	RET		;$c9
	LD HL,$3		;$21, $3, $0, $0
	ADD HL,SP		;$39
	LD BC,(HL)		;$ed, $7
	INC HL		;$23
	INC HL		;$23
	INC HL		;$23
	LD E,(HL)		;$5e
	PUSH BC		;$c5
	CALL ._lbl_7		;$cd, $df, $24, $0
	PUSH HL		;$e5
	POP BC		;$c1
	INC BC		;$3
	POP HL		;$e1
	LD A,E		;$7b
	CPIR		;$ed, $b1
	DEC HL		;$2b
	RET Z		;$c8
	OR A,A		;$b7
	SBC HL,HL		;$ed, $62
	RET		;$c9
	LD HL,$3		;$21, $3, $0, $0
	ADD HL,SP		;$39
	LD DE,(HL)		;$ed, $17
	INC HL		;$23
	INC HL		;$23
	INC HL		;$23
	LD HL,(HL)		;$ed, $27
._lbl_9:		;$=0x248f
	LD A,(DE)		;$1a
	OR A,A		;$b7
	JR Z,._lbl_8		;$28, $6
	CPI		;$ed, $a1
	INC DE		;$13
	JR Z,._lbl_9		;$28, $f7
	DEC HL		;$2b
._lbl_8:		;$=0x2499
	SUB A,(HL)		;$96
	SBC HL,HL		;$ed, $62
	LD L,A		;$6f
	RET		;$c9
	LD HL,$6		;$21, $6, $0, $0
	ADD HL,SP		;$39
	LD BC,(HL)		;$ed, $7
	DEC HL		;$2b
	DEC HL		;$2b
	DEC HL		;$2b
	LD DE,(HL)		;$ed, $17
	PUSH DE		;$d5
	PUSH BC		;$c5
	CALL ._lbl_7		;$cd, $df, $24, $0
	PUSH HL		;$e5
	POP BC		;$c1
	INC BC		;$3
	POP HL		;$e1
	LDIR		;$ed, $b0
	POP HL		;$e1
	RET		;$c9
	LD HL,$6		;$21, $6, $0, $0
	ADD HL,SP		;$39
	LD DE,(HL)		;$ed, $17
	DEC HL		;$2b
	DEC HL		;$2b
	DEC HL		;$2b
	LD HL,(HL)		;$ed, $27
._lbl_13:		;$=0x24c4
	PUSH HL		;$e5
._lbl_11:		;$=0x24c5
	LD A,(DE)		;$1a
	OR A,A		;$b7
	JR Z,._lbl_10		;$28, $11
	CPI		;$ed, $a1
	JR Z,._lbl_10		;$28, $d
	XOR A,A		;$af
	CP A,(HL)		;$be
	JR NZ,._lbl_11		;$20, $f4
	INC DE		;$13
	LD A,(DE)		;$1a
	OR A,A		;$b7
	JR Z,._lbl_12		;$28, $3
	POP HL		;$e1
	JR ._lbl_13		;$18, $eb
._lbl_12:		;$=0x24d9
	INC HL		;$23
._lbl_10:		;$=0x24da
	POP DE		;$d1
	SCF		;$37
	SBC HL,DE		;$ed, $52
	RET		;$c9
._lbl_7:		;$=0x24df
	LD HL,$3		;$21, $3, $0, $0
	ADD HL,SP		;$39
	LD HL,(HL)		;$ed, $27
	XOR A,A		;$af
	LD BC,$0		;$1, $0, $0, $0
	CPIR		;$ed, $b1
	OR A,A		;$b7
	SBC HL,HL		;$ed, $62
	SCF		;$37
	SBC HL,BC		;$ed, $42
	RET		;$c9
	PUSH IY		;$fd, $e5
	LD IY,$3		;$fd, $21, $3, $0, $0
	ADD IY,SP		;$fd, $39
	LD HL,(IY+$3)		;$fd, $27, $3
	XOR A,A		;$af
._lbl_14:		;$=0x2501
	CPI		;$ed, $a1
	JR NZ,._lbl_14		;$20, $fc
	DEC HL		;$2b
	LD BC,(IY+$9)		;$fd, $7, $9
	LD A,(IY+$b)		;$fd, $7e, $b
	OR A,C		;$b1
	OR A,B		;$b0
	JR Z,._lbl_15		;$28, $f
	LD DE,(IY+$6)		;$fd, $17, $6
	EX DE,HL		;$eb
	XOR A,A		;$af
._lbl_17:		;$=0x2515
	CP A,(HL)		;$be
	JR Z,._lbl_16		;$28, $6
	LDI		;$ed, $a0
	JP PE,._lbl_17		;$ea, $15, $25, $0
._lbl_16:		;$=0x251e
	LD (DE),A		;$12
._lbl_15:		;$=0x251f
	LD HL,(IY+$3)		;$fd, $27, $3
	POP IY		;$fd, $e1
	RET		;$c9
	PUSH IY		;$fd, $e5
	LD IY,$3		;$fd, $21, $3, $0, $0
	ADD IY,SP		;$fd, $39
	LD BC,(IY+$9)		;$fd, $7, $9
	LD A,(IY+$b)		;$fd, $7e, $b
	OR A,C		;$b1
	OR A,B		;$b0
	JR Z,._lbl_18		;$28, $1c
	LD HL,(IY+$6)		;$fd, $27, $6
	LD DE,(IY+$3)		;$fd, $17, $3
._lbl_20:		;$=0x253e
	LD A,(DE)		;$1a
	CPI		;$ed, $a1
	JR NZ,._lbl_19		;$20, $a
	JP PO,._lbl_18		;$e2, $54, $25, $0
	OR A,A		;$b7
	JR Z,._lbl_18		;$28, $a
	INC DE		;$13
	JR ._lbl_20		;$18, $f1
._lbl_19:		;$=0x254d
	DEC HL		;$2b
	SUB A,(HL)		;$96
	SBC HL,HL		;$ed, $62
	LD L,A		;$6f
	JR ._lbl_21		;$18, $3
._lbl_18:		;$=0x2554
	OR A,A		;$b7
	SBC HL,HL		;$ed, $62
._lbl_21:		;$=0x2557
	POP IY		;$fd, $e1
	RET		;$c9
	PUSH IY		;$fd, $e5
	LD IY,$3		;$fd, $21, $3, $0, $0
	ADD IY,SP		;$fd, $39
	SBC HL,HL		;$ed, $62
	LD DE,(IY+$9)		;$fd, $17, $9
	ADC HL,DE		;$ed, $5a
	JR Z,._lbl_22		;$28, $2f
	LD BC,(IY+$6)		;$fd, $7, $6
	PUSH BC		;$c5
	CALL ._lbl_7		;$cd, $df, $24, $0
	OR A,A		;$b7
	SBC HL,DE		;$ed, $52
	JR NC,._lbl_23		;$30, $e
	ADC HL,DE		;$ed, $5a
	PUSH HL		;$e5
	POP BC		;$c1
	EX DE,HL		;$eb
	XOR A,A		;$af
	SBC HL,DE		;$ed, $52
	JR Z,._lbl_24		;$28, $7
	EX (SP),HL		;$e3
	SCF		;$37
	JR ._lbl_25		;$18, $4
._lbl_23:		;$=0x2587
	LD BC,(IY+$9)		;$fd, $7, $9
._lbl_24:		;$=0x258a
	POP HL		;$e1
._lbl_25:		;$=0x258b
	LD DE,(IY+$3)		;$fd, $17, $3
	LDIR		;$ed, $b0
	JR NC,._lbl_22		;$30, $9
	EX DE,HL		;$eb
	POP BC		;$c1
._lbl_26:		;$=0x2594
	LD (HL),A		;$77
	CPI		;$ed, $a1
	JP PE,._lbl_26		;$ea, $94, $25, $0
._lbl_22:		;$=0x259b
	LD HL,(IY+$3)		;$fd, $27, $3
	POP IY		;$fd, $e1
	RET		;$c9
._lbl_42:		;$=0x25a1
	PUSH IY		;$fd, $e5
	LD IY,$0		;$fd, $21, $0, $0, $0
	ADD IY,SP		;$fd, $39
	LD BC,(IY+$9)		;$fd, $7, $9
	PUSH BC		;$c5
	CALL ._lbl_7		;$cd, $df, $24, $0
	EX (SP),HL		;$e3
	LD DE,(IY+$6)		;$fd, $17, $6
._lbl_28:		;$=0x25b6
	LD A,(DE)		;$1a
	OR A,A		;$b7
	JR Z,._lbl_27		;$28, $f
	LD HL,(IY+$9)		;$fd, $27, $9
	LD BC,(IY-$3)		;$fd, $7, $fd
	CPIR		;$ed, $b1
	INC DE		;$13
	JR NZ,._lbl_28		;$20, $f1
	EX DE,HL		;$eb
	DEC HL		;$2b
	JR ._lbl_29		;$18, $4
._lbl_27:		;$=0x25c9
	LD HL,$0		;$21, $0, $0, $0
._lbl_29:		;$=0x25cd
	LD SP,IY		;$fd, $f9
	POP IY		;$fd, $e1
	RET		;$c9
	PUSH IY		;$fd, $e5
	LD IY,$3		;$fd, $21, $3, $0, $0
	ADD IY,SP		;$fd, $39
	LD BC,(IY+$3)		;$fd, $7, $3
	PUSH BC		;$c5
	CALL ._lbl_7		;$cd, $df, $24, $0
	EX (SP),HL		;$e3
	POP BC		;$c1
	ADD HL,BC		;$9
	LD A,(IY+$6)		;$fd, $7e, $6
	CPDR		;$ed, $b9
	INC HL		;$23
	JR Z,._lbl_30		;$28, $4
	LD HL,$0		;$21, $0, $0, $0
._lbl_30:		;$=0x25f2
	POP IY		;$fd, $e1
	RET		;$c9
._lbl_39:		;$=0x25f5
	PUSH IY		;$fd, $e5
	LD IY,$0		;$fd, $21, $0, $0, $0
	ADD IY,SP		;$fd, $39
	LD BC,(IY+$9)		;$fd, $7, $9
	PUSH BC		;$c5
	CALL ._lbl_7		;$cd, $df, $24, $0
	EX (SP),HL		;$e3
	LD DE,(IY+$6)		;$fd, $17, $6
._lbl_32:		;$=0x260a
	LD A,(DE)		;$1a
	OR A,A		;$b7
	JR Z,._lbl_31		;$28, $c
	LD HL,(IY+$9)		;$fd, $27, $9
	LD BC,(IY-$3)		;$fd, $7, $fd
	CPIR		;$ed, $b1
	INC DE		;$13
	JR Z,._lbl_32		;$28, $f1
	SCF		;$37
._lbl_31:		;$=0x261a
	LD HL,(IY+$6)		;$fd, $27, $6
	EX DE,HL		;$eb
	SBC HL,DE		;$ed, $52
	LD SP,IY		;$fd, $f9
	POP IY		;$fd, $e1
	RET		;$c9
	LD HL,$6		;$21, $6, $0, $0
	ADD HL,SP		;$39
	PUSH IY		;$fd, $e5
	TRAP		;$ed, $31
	DEC HL		;$2b
	DEC HL		;$2b
	DEC HL		;$2b
	LD DE,(HL)		;$ed, $17
._lbl_36:		;$=0x2633
	XOR A,A		;$af
	SBC HL,HL		;$ed, $62
	ADD HL,DE		;$19
	CP A,(HL)		;$be
	JR Z,._lbl_33		;$28, $13
	PUSH IY		;$fd, $e5
	POP BC		;$c1
	INC DE		;$13
._lbl_35:		;$=0x263e
	LD A,(BC)		;$a
	OR A,A		;$b7
	JR Z,._lbl_34		;$28, $7
	CP A,(HL)		;$be
	INC HL		;$23
	INC BC		;$3
	JR Z,._lbl_35		;$28, $f7
	JR ._lbl_36		;$18, $ea
._lbl_34:		;$=0x2649
	EX DE,HL		;$eb
	DEC HL		;$2b
	JR ._lbl_37		;$18, $2
._lbl_33:		;$=0x264d
	SBC HL,HL		;$ed, $62
._lbl_37:		;$=0x264f
	POP IY		;$fd, $e1
	RET		;$c9
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	PUSH BC		;$c5
	PUSH BC		;$c5
	LD HL,(IX+$6)		;$dd, $27, $6
	CALL $1cb8		;$cd, $b8, $1c, $0
	JR Z,._lbl_38		;$28, $4
	LD ($d000ff),HL		;$22, $ff, $0, $d0
._lbl_38:		;$=0x266a
	LD BC,(IX+$9)		;$dd, $7, $9
	PUSH BC		;$c5
	LD BC,($d000ff)		;$ed, $4b, $ff, $0, $d0
	PUSH BC		;$c5
	CALL ._lbl_39		;$cd, $f5, $25, $0
	POP BC		;$c1
	POP BC		;$c1
	LD (IX-$6),HL		;$dd, $2f, $fa
	CALL $1cb8		;$cd, $b8, $1c, $0
	JR NZ,._lbl_40		;$20, $c
	LD HL,($d000ff)		;$2a, $ff, $0, $d0
	LD A,(HL)		;$7e
	OR A,A		;$b7
	JR NZ,._lbl_40		;$20, $4
	SBC HL,HL		;$ed, $62
	JR ._lbl_41		;$18, $4f
._lbl_40:		;$=0x268f
	LD BC,(IX-$6)		;$dd, $7, $fa
	LD HL,($d000ff)		;$2a, $ff, $0, $d0
	ADD HL,BC		;$9
	LD ($d000ff),HL		;$22, $ff, $0, $d0
	LD (IX+$6),HL		;$dd, $2f, $6
	LD BC,(IX+$9)		;$dd, $7, $9
	PUSH BC		;$c5
	LD BC,($d000ff)		;$ed, $4b, $ff, $0, $d0
	PUSH BC		;$c5
	CALL ._lbl_42		;$cd, $a1, $25, $0
	POP BC		;$c1
	POP BC		;$c1
	LD (IX-$3),HL		;$dd, $2f, $fd
	CALL $1cb8		;$cd, $b8, $1c, $0
	JR NZ,._lbl_43		;$20, $1a
	LD BC,($d000ff)		;$ed, $4b, $ff, $0, $d0
	PUSH BC		;$c5
	CALL ._lbl_7		;$cd, $df, $24, $0
	POP BC		;$c1
	ADD HL,BC		;$9
	LD ($d000ff),HL		;$22, $ff, $0, $d0
	LD BC,(IX+$6)		;$dd, $7, $6
	OR A,A		;$b7
	SBC HL,BC		;$ed, $42
	JR Z,._lbl_41		;$28, $f
	JR ._lbl_44		;$18, $a
._lbl_43:		;$=0x26d1
	LD HL,(IX-$3)		;$dd, $27, $fd
	LD (HL),$0		;$36, $0
	INC HL		;$23
	LD ($d000ff),HL		;$22, $ff, $0, $d0
._lbl_44:		;$=0x26db
	LD HL,(IX+$6)		;$dd, $27, $6
._lbl_41:		;$=0x26de
	LD SP,IX		;$dd, $f9
	POP IX		;$dd, $e1
	RET		;$c9
._lbl_2:		;$=0x26e3
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	PUSH BC		;$c5
	LD HL,$0		;$21, $0, $0, $0
	LD ($d00102),HL		;$22, $2, $1, $d0
	LD HL,(IX+$6)		;$dd, $27, $6
	LD ($d00105),HL		;$22, $5, $1, $d0
	JP ._lbl_45		;$c3, $ed, $27, $0
._lbl_48:		;$=0x2700
	INC HL		;$23
	LD (IX+$9),HL		;$dd, $2f, $9
	LD C,A		;$4f
	PUSH BC		;$c5
	CALL ._lbl_46		;$cd, $b, $28, $0
	POP BC		;$c1
	LD HL,($d00102)		;$2a, $2, $1, $d0
	INC HL		;$23
	LD ($d00102),HL		;$22, $2, $1, $d0
	LD HL,(IX+$9)		;$dd, $27, $9
	LD A,(HL)		;$7e
	OR A,A		;$b7
	JP Z,._lbl_47		;$ca, $f6, $27, $0
._lbl_65:		;$=0x271d
	CP A,$25		;$fe, $25
	JR NZ,._lbl_48		;$20, $df
	PEA IX+$c		;$ed, $65, $c
	LD BC,$d0010b		;$1, $b, $1, $d0
	PUSH BC		;$c5
	LD BC,(IX+$9)		;$dd, $7, $9
	LD (IX-$3),BC		;$dd, $f, $fd
	PUSH BC		;$c5
	CALL ._lbl_49		;$cd, $3c, $2d, $0
	LD (IX+$9),HL		;$dd, $2f, $9
	POP BC		;$c1
	POP BC		;$c1
	POP BC		;$c1
	LD IY,$d0010b		;$fd, $21, $b, $1, $d0
	LD A,(IY+$0)		;$fd, $7e, $0
	CP A,$1		;$fe, $1
	JR NZ,._lbl_50		;$20, $2c
	JR ._lbl_51		;$18, $17
._lbl_52:		;$=0x2748
	LD HL,(IX-$3)		;$dd, $27, $fd
	LD C,(HL)		;$4e
	INC HL		;$23
	LD (IX-$3),HL		;$dd, $2f, $fd
	PUSH BC		;$c5
	CALL ._lbl_46		;$cd, $b, $28, $0
	POP BC		;$c1
	LD HL,($d00102)		;$2a, $2, $1, $d0
	INC HL		;$23
	LD ($d00102),HL		;$22, $2, $1, $d0
._lbl_51:		;$=0x275f
	LD HL,(IX-$3)		;$dd, $27, $fd
	LD DE,(IX+$9)		;$dd, $17, $9
	OR A,A		;$b7
	SBC HL,DE		;$ed, $52
	JR C,._lbl_52		;$38, $de
	LD HL,$ffffff		;$21, $ff, $ff, $ff
	JP ._lbl_53		;$c3, $6, $28, $0
._lbl_50:		;$=0x2772
	CP A,$2		;$fe, $2
	JR NZ,._lbl_54		;$20, $14
	LD C,(IY+$3)		;$fd, $4e, $3
	PUSH BC		;$c5
	CALL ._lbl_46		;$cd, $b, $28, $0
	POP BC		;$c1
	LD HL,($d00102)		;$2a, $2, $1, $d0
	INC HL		;$23
	LD ($d00102),HL		;$22, $2, $1, $d0
	JR ._lbl_45		;$18, $63
._lbl_54:		;$=0x278a
	LD HL,(IX+$c)		;$dd, $27, $c
	LD DE,(HL)		;$ed, $17
	INC HL		;$23
	INC HL		;$23
	INC HL		;$23
	LD (IX+$c),HL		;$dd, $2f, $c
	LD A,(IY+$4)		;$fd, $7e, $4
	CP A,$64		;$fe, $64
	JR Z,._lbl_55		;$28, $4
	CP A,$69		;$fe, $69
	JR NZ,._lbl_56		;$20, $8
._lbl_55:		;$=0x27a0
	PUSH DE		;$d5
	CALL ._lbl_57		;$cd, $8f, $2a, $0
	POP DE		;$d1
	JR ._lbl_45		;$18, $45
._lbl_56:		;$=0x27a8
	CP A,$78		;$fe, $78
	JR Z,._lbl_58		;$28, $10
	CP A,$58		;$fe, $58
	JR Z,._lbl_58		;$28, $c
	CP A,$75		;$fe, $75
	JR Z,._lbl_58		;$28, $8
	CP A,$6f		;$fe, $6f
	JR Z,._lbl_58		;$28, $4
	CP A,$70		;$fe, $70
	JR NZ,._lbl_59		;$20, $8
._lbl_58:		;$=0x27bc
	PUSH DE		;$d5
	CALL ._lbl_60		;$cd, $fe, $2b, $0
	POP DE		;$d1
	JR ._lbl_45		;$18, $29
._lbl_59:		;$=0x27c4
	CP A,$63		;$fe, $63
	JR NZ,._lbl_61		;$20, $e
	LD HL,$d00112		;$21, $12, $1, $d0
	LD (HL),E		;$73
	INC HL		;$23
	LD (HL),$0		;$36, $0
	CALL ._lbl_62		;$cd, $25, $28, $0
	JR ._lbl_45		;$18, $17
._lbl_61:		;$=0x27d6
	CP A,$73		;$fe, $73
	JR NZ,._lbl_63		;$20, $8
	PUSH DE		;$d5
	CALL ._lbl_64		;$cd, $6e, $29, $0
	POP DE		;$d1
	JR ._lbl_45		;$18, $b
._lbl_63:		;$=0x27e2
	CP A,$6e		;$fe, $6e
	JR NZ,._lbl_45		;$20, $7
	LD HL,($d00102)		;$2a, $2, $1, $d0
	EX DE,HL		;$eb
	LD (HL),DE		;$ed, $1f
._lbl_45:		;$=0x27ed
	LD HL,(IX+$9)		;$dd, $27, $9
	LD A,(HL)		;$7e
	OR A,A		;$b7
	JP NZ,._lbl_65		;$c2, $1d, $27, $0
._lbl_47:		;$=0x27f6
	LD HL,($d00105)		;$2a, $5, $1, $d0
	CALL $1cb8		;$cd, $b8, $1c, $0
	JR Z,._lbl_66		;$28, $2
	SUB A,A		;$97
	LD (HL),A		;$77
._lbl_66:		;$=0x2802
	LD HL,($d00102)		;$2a, $2, $1, $d0
._lbl_53:		;$=0x2806
	LD SP,IX		;$dd, $f9
	POP IX		;$dd, $e1
	RET		;$c9
._lbl_46:		;$=0x280b
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	LD C,(IX+$6)		;$dd, $4e, $6
	PUSH BC		;$c5
	LD IY,($d00108)		;$fd, $2a, $8, $1, $d0
._lbl_67:		;$=0x281d
	CALL $1d7e		;$cd, $7e, $1d, $0
	POP BC		;$c1
	POP IX		;$dd, $e1
	RET		;$c9
._lbl_62:		;$=0x2825
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	PUSH BC		;$c5
	PUSH BC		;$c5
	PUSH BC		;$c5
	PUSH BC		;$c5
	DEC SP		;$3b
	DEC SP		;$3b
	LD HL,$0		;$21, $0, $0, $0
	LD (IX-$6),HL		;$dd, $2f, $fa
	LD (IX@),$f9		;$dd, $36, $f9
	JR NZ,._lbl_67		;$20, $dd
	SET 6,L		;$cb, $f5
	ADD A,(HL)		;$86
	LD IY,$d0010b		;$fd, $21, $b, $1, $d0
	BIT 0,(IY+$1)		;$fd, $cb, $1, $46
	JR NZ,._lbl_68		;$20, $8
	LD A,(IY+$5)		;$fd, $7e, $5
	OR A,A		;$b7
	JP P,._lbl_69		;$f2, $5a, $28, $0
._lbl_68:		;$=0x2856
	SET 0,(IX+$f5)		;$dd, $cb, $f5, $c6
._lbl_69:		;$=0x285a
	LD A,($d00120)		;$3a, $20, $1, $d0
	OR A,A		;$b7
	JR Z,._lbl_70		;$28, $1c
	LD C,A		;$4f
	PUSH BC		;$c5
	CALL ._lbl_46		;$cd, $b, $28, $0
	POP BC		;$c1
	LD HL,($d00102)		;$2a, $2, $1, $d0
	INC HL		;$23
	LD ($d00102),HL		;$22, $2, $1, $d0
	SUB A,A		;$97
	LD ($d00120),A		;$32, $20, $1, $d0
	LD HL,$1		;$21, $1, $0, $0
	LD (IX-$6),HL		;$dd, $2f, $fa
._lbl_70:		;$=0x287d
	LD IY,$d0010b		;$fd, $21, $b, $1, $d0
	LD A,(IY+$5)		;$fd, $7e, $5
	OR A,A		;$b7
	JR Z,._lbl_71		;$28, $5d
	BIT 0,(IX+$f5)		;$dd, $cb, $f5, $46
	JR NZ,._lbl_71		;$20, $57
	BIT 6,(IY+$1)		;$fd, $cb, $1, $76
	JR Z,._lbl_72		;$28, $4
	LD (IX@),$f9		;$dd, $36, $f9
	JR NC,._lbl_73		;$30, $fd
	LD A,(HL)		;$7e
	DEC B		;$5
	OR A,A		;$b7
	JP P,._lbl_74		;$f2, $a2, $28, $0
	NEG		;$ed, $44
._lbl_74:		;$=0x28a2
	LD HL,$0		;$21, $0, $0, $0
	LD L,A		;$6f
	LD (IX-$e),HL		;$dd, $2f, $f2
	PUSH HL		;$e5
	LD BC,$d00112		;$1, $12, $1, $d0
	PUSH BC		;$c5
	CALL ._lbl_7		;$cd, $df, $24, $0
	POP BC		;$c1
	EX DE,HL		;$eb
	POP HL		;$e1
	OR A,A		;$b7
	SBC HL,DE		;$ed, $52
	LD DE,(IX-$6)		;$dd, $17, $fa
	OR A,A		;$b7
	SBC HL,DE		;$ed, $52
	JR ._lbl_75		;$18, $16
._lbl_76:		;$=0x28c2
	LD HL,($d00102)		;$2a, $2, $1, $d0
	INC HL		;$23
	LD ($d00102),HL		;$22, $2, $1, $d0
	LD C,(IX-$7)		;$dd, $4e, $f9
	PUSH BC		;$c5
	CALL ._lbl_46		;$cd, $b, $28, $0
	POP BC		;$c1
	LD HL,(IX-$3)		;$dd, $27, $fd
	DEC HL		;$2b
._lbl_75:		;$=0x28d8
	LD (IX-$3),HL		;$dd, $2f, $fd
	CALL $1cb8		;$cd, $b8, $1c, $0
	JR Z,._lbl_71		;$28, $4
	JP P,._lbl_76		;$f2, $c2, $28, $0
._lbl_71:		;$=0x28e5
	LD HL,$d00112		;$21, $12, $1, $d0
	JR ._lbl_77		;$18, $b
._lbl_78:		;$=0x28eb
	LD C,A		;$4f
	PUSH BC		;$c5
	CALL ._lbl_46		;$cd, $b, $28, $0
	POP BC		;$c1
	LD HL,(IX-$a)		;$dd, $27, $f6
	INC HL		;$23
._lbl_77:		;$=0x28f6
	LD (IX-$a),HL		;$dd, $2f, $f6
	LD A,(HL)		;$7e
	OR A,A		;$b7
	JR NZ,._lbl_78		;$20, $ee
	LD DE,$d00112		;$11, $12, $1, $d0
	OR A,A		;$b7
	SBC HL,DE		;$ed, $52
	LD DE,($d00102)		;$ed, $5b, $2, $1, $d0
	ADD HL,DE		;$19
	LD ($d00102),HL		;$22, $2, $1, $d0
	BIT 0,(IX+$f5)		;$dd, $cb, $f5, $46
	JR Z,._lbl_79		;$28, $44
	LD HL,(IX-$e)		;$dd, $27, $f2
	LD DE,(IX-$a)		;$dd, $17, $f6
	OR A,A		;$b7
	SBC HL,DE		;$ed, $52
	LD DE,$d00112		;$11, $12, $1, $d0
	ADD HL,DE		;$19
	LD (IX-$3),HL		;$dd, $2f, $fd
	CALL $1cb8		;$cd, $b8, $1c, $0
	JP M,._lbl_79		;$fa, $58, $29, $0
	JR Z,._lbl_79		;$28, $29
	LD DE,($d00102)		;$ed, $5b, $2, $1, $d0
	ADD HL,DE		;$19
	LD ($d00102),HL		;$22, $2, $1, $d0
	LD HL,(IX-$3)		;$dd, $27, $fd
	JR ._lbl_80		;$18, $10
._lbl_81:		;$=0x293e
	LD C,(IX-$7)		;$dd, $4e, $f9
	PUSH BC		;$c5
	CALL ._lbl_46		;$cd, $b, $28, $0
	POP BC		;$c1
	LD HL,(IX-$3)		;$dd, $27, $fd
	DEC HL		;$2b
	LD (IX-$3),HL		;$dd, $2f, $fd
._lbl_80:		;$=0x294e
	CALL $1cb8		;$cd, $b8, $1c, $0
	JR Z,._lbl_79		;$28, $4
	JP P,._lbl_81		;$f2, $3e, $29, $0
._lbl_79:		;$=0x2958
	SUB A,A		;$97
	LD ($d0010f),A		;$32, $f, $1, $d0
	LD ($d00110),A		;$32, $10, $1, $d0
	LD ($d00111),A		;$32, $11, $1, $d0
	LD ($d0010c),A		;$32, $c, $1, $d0
	LD SP,IX		;$dd, $f9
	POP IX		;$dd, $e1
	RET		;$c9
._lbl_64:		;$=0x296e
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	PUSH BC		;$c5
	PUSH BC		;$c5
	DEC SP		;$3b
	DEC SP		;$3b
	LD (IX@),$ff		;$dd, $36, $ff
	NOP		;$0
	LD HL,(IX+$6)		;$dd, $27, $6
	LD (IX-$6),HL		;$dd, $2f, $fa
	RES 0,(IX+$f9)		;$dd, $cb, $f9, $86
	LD IY,$d0010b		;$fd, $21, $b, $1, $d0
	LD A,(IY+$5)		;$fd, $7e, $5
	OR A,A		;$b7
	JR Z,._lbl_82		;$28, $66
	RES 0,(IX+$f9)		;$dd, $cb, $f9, $86
	JP M,._lbl_83		;$fa, $a2, $29, $0
	BIT 0,(IY+$1)		;$fd, $cb, $1, $46
	JR Z,._lbl_84		;$28, $4
._lbl_83:		;$=0x29a2
	SET 0,(IX+$f9)		;$dd, $cb, $f9, $c6
._lbl_84:		;$=0x29a6
	BIT 0,(IX+$f9)		;$dd, $cb, $f9, $46
	JR NZ,._lbl_82		;$20, $4e
	LD BC,(IX-$6)		;$dd, $7, $fa
	PUSH BC		;$c5
	CALL ._lbl_7		;$cd, $df, $24, $0
	POP BC		;$c1
	LD (IX-$8),L		;$dd, $75, $f8
	LD IY,$d0010b		;$fd, $21, $b, $1, $d0
	BIT 4,(IY+$1)		;$fd, $cb, $1, $66
	JR Z,._lbl_85		;$28, $10
	LD A,L		;$7d
	CP A,(IY+$6)		;$fd, $be, $6
	JP M,._lbl_85		;$fa, $d3, $29, $0
	JR Z,._lbl_85		;$28, $6
	LD A,(IY+$6)		;$fd, $7e, $6
	LD (IX-$8),A		;$dd, $77, $f8
._lbl_85:		;$=0x29d3
	LD A,(IY+$5)		;$fd, $7e, $5
	SUB A,(IX-$8)		;$dd, $96, $f8
	LD (IX-$8),A		;$dd, $77, $f8
	JR ._lbl_86		;$18, $15
._lbl_87:		;$=0x29de
	LD C,$20		;$e, $20
	PUSH BC		;$c5
	CALL ._lbl_46		;$cd, $b, $28, $0
	POP BC		;$c1
	LD HL,(IX-$1)		;$dd, $27, $ff
	INC HL		;$23
	LD (IX-$1),HL		;$dd, $2f, $ff
	DEC (IX-$8)		;$dd, $35, $f8
	LD A,(IX-$8)		;$dd, $7e, $f8
._lbl_86:		;$=0x29f3
	OR A,A		;$b7
	JR Z,._lbl_82		;$28, $4
	JP P,._lbl_87		;$f2, $de, $29, $0
._lbl_82:		;$=0x29fa
	LD IY,$d0010b		;$fd, $21, $b, $1, $d0
	BIT 4,(IY+$1)		;$fd, $cb, $1, $66
	JR NZ,._lbl_88		;$20, $4
	LD A,$ff		;$3e, $ff
	JR ._lbl_89		;$18, $3
._lbl_88:		;$=0x2a09
	LD A,(IY+$6)		;$fd, $7e, $6
._lbl_89:		;$=0x2a0c
	LD (IX-$3),A		;$dd, $77, $fd
	LD (IX@),$fe		;$dd, $36, $fe
	NOP		;$0
	JR ._lbl_90		;$18, $11
._lbl_92:		;$=0x2a15
	LD C,A		;$4f
	PUSH BC		;$c5
	CALL ._lbl_46		;$cd, $b, $28, $0
	POP BC		;$c1
	LD HL,(IX-$6)		;$dd, $27, $fa
	INC HL		;$23
	LD (IX-$6),HL		;$dd, $2f, $fa
	INC (IX-$2)		;$dd, $34, $fe
._lbl_90:		;$=0x2a26
	LD A,(IX-$2)		;$dd, $7e, $fe
	CP A,(IX-$3)		;$dd, $be, $fd
	JR NC,._lbl_91		;$30, $7
	LD HL,(IX-$6)		;$dd, $27, $fa
	LD A,(HL)		;$7e
	OR A,A		;$b7
	JR NZ,._lbl_92		;$20, $e0
._lbl_91:		;$=0x2a35
	LD A,(IX-$1)		;$dd, $7e, $ff
	ADD A,(IX-$2)		;$dd, $86, $fe
	LD (IX-$1),A		;$dd, $77, $ff
	BIT 0,(IX+$f9)		;$dd, $cb, $f9, $46
	JR Z,._lbl_93		;$28, $29
	LD A,($d00110)		;$3a, $10, $1, $d0
	OR A,A		;$b7
	JP P,._lbl_94		;$f2, $53, $2a, $0
	NEG		;$ed, $44
	LD ($d00110),A		;$32, $10, $1, $d0
._lbl_94:		;$=0x2a53
	JR ._lbl_95		;$18, $b
._lbl_96:		;$=0x2a55
	LD C,$20		;$e, $20
	PUSH BC		;$c5
	CALL ._lbl_46		;$cd, $b, $28, $0
	POP BC		;$c1
	INC (IX-$1)		;$dd, $34, $ff
._lbl_95:		;$=0x2a60
	LD A,($d00110)		;$3a, $10, $1, $d0
	LD B,A		;$47
	LD A,(IX-$1)		;$dd, $7e, $ff
	CP A,B		;$b8
	JP M,._lbl_96		;$fa, $55, $2a, $0
._lbl_93:		;$=0x2a6d
	LD DE,$0		;$11, $0, $0, $0
	LD E,(IX-$1)		;$dd, $5e, $ff
	LD HL,($d00102)		;$2a, $2, $1, $d0
	ADD HL,DE		;$19
	LD ($d00102),HL		;$22, $2, $1, $d0
	SUB A,A		;$97
	LD ($d00110),A		;$32, $10, $1, $d0
	LD ($d00111),A		;$32, $11, $1, $d0
	LD ($d0010c),A		;$32, $c, $1, $d0
	LD SP,IX		;$dd, $f9
	POP IX		;$dd, $e1
	RET		;$c9
._lbl_57:		;$=0x2a8f
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	PUSH BC		;$c5
	PUSH BC		;$c5
	PUSH BC		;$c5
	LD HL,$d00112		;$21, $12, $1, $d0
	LD (IX-$5),HL		;$dd, $2f, $fb
	RES 0,(IX+$fe)		;$dd, $cb, $fe, $86
	LD HL,(IX+$6)		;$dd, $27, $6
	CALL $1cb8		;$cd, $b8, $1c, $0
	JP P,._lbl_97		;$f2, $bb, $2a, $0
	SET 0,(IX+$fe)		;$dd, $cb, $fe, $c6
	EX DE,HL		;$eb
	OR A,A		;$b7
	SBC HL,HL		;$ed, $62
	SBC HL,DE		;$ed, $52
._lbl_97:		;$=0x2abb
	LD (IX-$8),HL		;$dd, $2f, $f8
	SET 1,(IX+$fe)		;$dd, $cb, $fe, $ce
	CALL $1cb8		;$cd, $b8, $1c, $0
	JR NZ,._lbl_98		;$20, $4
	RES 1,(IX+$fe)		;$dd, $cb, $fe, $8e
._lbl_98:		;$=0x2acc
	LD IY,$d0010b		;$fd, $21, $b, $1, $d0
	LD A,(IY+$6)		;$fd, $7e, $6
	OR A,A		;$b7
	JP P,._lbl_99		;$f2, $dd, $2a, $0
	LD (IY@),$6		;$fd, $36, $6
	LD BC,$57efd		;$1, $fd, $7e, $5
	OR A,A		;$b7
	JP P,._lbl_100		;$f2, $ee, $2a, $0
	SET 0,(IY+$1)		;$fd, $cb, $1, $c6
	NEG		;$ed, $44
	LD (IY+$5),A		;$fd, $77, $5
._lbl_100:		;$=0x2aee
	LD (IX@),$ff		;$dd, $36, $ff
	LD B,C		;$41
	LD A,(IY+$4)		;$fd, $7e, $4
	CP A,$64		;$fe, $64
	JR Z,._lbl_101		;$28, $2e
	CP A,$69		;$fe, $69
	JR Z,._lbl_101		;$28, $2a
	CP A,$75		;$fe, $75
	JR Z,._lbl_101		;$28, $26
	CP A,$6f		;$fe, $6f
	JR NZ,._lbl_102		;$20, $6
	LD (IX@),$f7		;$dd, $36, $f7
	EX AF,AF'		;$8
	JR ._lbl_103		;$18, $20
._lbl_102:		;$=0x2b0b
	CP A,$78		;$fe, $78
	JR Z,._lbl_104		;$28, $4
	CP A,$70		;$fe, $70
	JR NZ,._lbl_105		;$20, $a
._lbl_104:		;$=0x2b13
	BIT 5,(IY+$1)		;$fd, $cb, $1, $6e
	JR Z,._lbl_105		;$28, $4
	LD (IX@),$ff		;$dd, $36, $ff
	LD H,C		;$61
._lbl_105:		;$=0x2b1d
	CP A,$58		;$fe, $58
	JR NZ,._lbl_101		;$20, $6
	LD (IX@),$f7		;$dd, $36, $f7
	DJNZ ._lbl_106		;$10, $18
	INC B		;$4
._lbl_101:		;$=0x2b27
	LD (IX@),$f7		;$dd, $36, $f7
	LD A,(BC)		;$a
._lbl_103:		;$=0x2b2b
	LD HL,(IX-$8)		;$dd, $27, $f8
	LD BC,$0		;$1, $0, $0, $0
	LD C,(IX-$9)		;$dd, $4e, $f7
	CALL $1d07		;$cd, $7, $1d, $0
	LD (IX-$8),DE		;$dd, $1f, $f8
	LD A,L		;$7d
	CP A,$a		;$fe, $a
	JR C,._lbl_107		;$38, $7
	SUB A,$a		;$d6, $a
	ADD A,(IX-$1)		;$dd, $86, $ff
	JR ._lbl_108		;$18, $2
._lbl_107:		;$=0x2b48
	ADD A,$30		;$c6, $30
._lbl_108:		;$=0x2b4a
	LD HL,(IX-$5)		;$dd, $27, $fb
	LD (HL),A		;$77
	INC HL		;$23
	LD (IX-$5),HL		;$dd, $2f, $fb
	LD HL,(IX-$8)		;$dd, $27, $f8
	CALL $1cb8		;$cd, $b8, $1c, $0
	JR NZ,._lbl_103		;$20, $d0
	LD IY,$d0010b		;$fd, $21, $b, $1, $d0
	LD HL,(IX-$5)		;$dd, $27, $fb
	LD DE,$d00112		;$11, $12, $1, $d0
	OR A,A		;$b7
	SBC HL,DE		;$ed, $52
	LD A,L		;$7d
	SUB A,(IY+$6)		;$fd, $96, $6
	LD HL,(IX-$5)		;$dd, $27, $fb
	JP P,._lbl_109		;$f2, $81, $2b, $0
	NEG		;$ed, $44
	LD B,A		;$47
	LD A,$30		;$3e, $30
._lbl_110:		;$=0x2b7a
	LD (HL),A		;$77
	INC HL		;$23
	DJNZ ._lbl_110		;$10, $fc
	LD (IX-$5),HL		;$dd, $2f, $fb
._lbl_109:		;$=0x2b81
	BIT 3,(IY+$1)		;$fd, $cb, $1, $5e
	JR Z,._lbl_111		;$28, $1d
	BIT 1,(IX+$fe)		;$dd, $cb, $fe, $4e
	JR Z,._lbl_111		;$28, $17
	LD A,(IX-$9)		;$dd, $7e, $f7
	CP A,$10		;$fe, $10
	JR NZ,._lbl_112		;$20, $9
	LD A,$17		;$3e, $17
	ADD A,(IX-$1)		;$dd, $86, $ff
	LD (HL),A		;$77
	INC HL		;$23
	JR ._lbl_113		;$18, $4
._lbl_112:		;$=0x2b9d
	CP A,$8		;$fe, $8
	JR NZ,._lbl_114		;$20, $2
._lbl_113:		;$=0x2ba1
	LD (HL),$30		;$36, $30
._lbl_114:		;$=0x2ba3
	INC HL		;$23
._lbl_111:		;$=0x2ba4
	BIT 0,(IX+$fe)		;$dd, $cb, $fe, $46
	JR Z,._lbl_115		;$28, $6
	LD (IX@),$ff		;$dd, $36, $ff
	DEC L		;$2d
	JR ._lbl_116		;$18, $1c
._lbl_115:		;$=0x2bb0
	BIT 1,(IY+$1)		;$fd, $cb, $1, $4e
	JR Z,._lbl_117		;$28, $6
	LD (IX@),$ff		;$dd, $36, $ff
	DEC HL		;$2b
	JR ._lbl_116		;$18, $10
._lbl_117:		;$=0x2bbc
	BIT 2,(IY+$1)		;$fd, $cb, $1, $56
	JR Z,._lbl_118		;$28, $6
	LD (IX@),$ff		;$dd, $36, $ff
	JR NZ,._lbl_119		;$20, $18
	INC B		;$4
._lbl_118:		;$=0x2bc8
	LD (IX@),$ff		;$dd, $36, $ff
	NOP		;$0
._lbl_116:		;$=0x2bcc
	LD A,(IY+$6)		;$fd, $7e, $6
	OR A,A		;$b7
	JR Z,._lbl_120		;$28, $4
	RES 6,(IY+$1)		;$fd, $cb, $1, $b6
._lbl_120:		;$=0x2bd6
	LD A,(IX-$1)		;$dd, $7e, $ff
	BIT 6,(IY+$1)		;$fd, $cb, $1, $76
	JR NZ,._lbl_121		;$20, $6
._lbl_119:		;$=0x2bdf
	OR A,A		;$b7
	JR Z,._lbl_121		;$28, $3
	LD (HL),A		;$77
	INC HL		;$23
	SUB A,A		;$97
._lbl_121:		;$=0x2be5
	LD ($d00120),A		;$32, $20, $1, $d0
	LD (HL),$0		;$36, $0
	LD BC,$d00112		;$1, $12, $1, $d0
	PUSH BC		;$c5
	CALL ._lbl_122		;$cd, $fd, $2c, $0
	POP BC		;$c1
	CALL ._lbl_62		;$cd, $25, $28, $0
	LD SP,IX		;$dd, $f9
	POP IX		;$dd, $e1
	RET		;$c9
._lbl_60:		;$=0x2bfe
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	PUSH BC		;$c5
	PUSH BC		;$c5
	LD HL,$d00112		;$21, $12, $1, $d0
	LD (IX-$4),HL		;$dd, $2f, $fc
	SET 0,(IX+$fb)		;$dd, $cb, $fb, $c6
	LD HL,(IX+$6)		;$dd, $27, $6
	CALL $1cb8		;$cd, $b8, $1c, $0
	JR NZ,._lbl_123		;$20, $4
	RES 0,(IX+$fb)		;$dd, $cb, $fb, $86
._lbl_123:		;$=0x2c21
	LD (IX@),$ff		;$dd, $36, $ff
	LD B,C		;$41
	LD IY,$d0010b		;$fd, $21, $b, $1, $d0
	LD A,(IY+$4)		;$fd, $7e, $4
	CP A,$64		;$fe, $64
	JR Z,._lbl_124		;$28, $30
	CP A,$69		;$fe, $69
	JR Z,._lbl_124		;$28, $2c
	CP A,$75		;$fe, $75
	JR Z,._lbl_124		;$28, $28
	CP A,$6f		;$fe, $6f
	JR NZ,._lbl_125		;$20, $6
	LD (IX@),$fa		;$dd, $36, $fa
	EX AF,AF'		;$8
	JR ._lbl_126		;$18, $22
._lbl_125:		;$=0x2c43
	CP A,$78		;$fe, $78
	JR Z,._lbl_127		;$28, $4
	CP A,$70		;$fe, $70
	JR NZ,._lbl_128		;$20, $c
._lbl_127:		;$=0x2c4b
	BIT 5,(IY+$1)		;$fd, $cb, $1, $6e
	JR NZ,._lbl_129		;$20, $a
	LD (IX@),$ff		;$dd, $36, $ff
	LD H,C		;$61
	JR ._lbl_129		;$18, $4
._lbl_128:		;$=0x2c57
	CP A,$58		;$fe, $58
	JR NZ,._lbl_124		;$20, $6
._lbl_129:		;$=0x2c5b
	LD (IX@),$fa		;$dd, $36, $fa
	DJNZ ._lbl_130		;$10, $18
	INC B		;$4
._lbl_124:		;$=0x2c61
	LD (IX@),$fa		;$dd, $36, $fa
	LD A,(BC)		;$a
._lbl_126:		;$=0x2c65
	LD HL,(IX+$6)		;$dd, $27, $6
	LD BC,$0		;$1, $0, $0, $0
	LD C,(IX-$6)		;$dd, $4e, $fa
	CALL $1d07		;$cd, $7, $1d, $0
	LD (IX+$6),DE		;$dd, $1f, $6
	LD A,L		;$7d
	CP A,$a		;$fe, $a
	JR C,._lbl_131		;$38, $7
	SUB A,$a		;$d6, $a
	ADD A,(IX-$1)		;$dd, $86, $ff
	JR ._lbl_132		;$18, $2
._lbl_131:		;$=0x2c82
	ADD A,$30		;$c6, $30
._lbl_132:		;$=0x2c84
	LD HL,(IX-$4)		;$dd, $27, $fc
	LD (HL),A		;$77
	INC HL		;$23
	LD (IX-$4),HL		;$dd, $2f, $fc
	LD HL,(IX+$6)		;$dd, $27, $6
	CALL $1cb8		;$cd, $b8, $1c, $0
	JR NZ,._lbl_126		;$20, $d0
	LD IY,$d0010b		;$fd, $21, $b, $1, $d0
	LD HL,(IX-$4)		;$dd, $27, $fc
	LD DE,$d00112		;$11, $12, $1, $d0
	OR A,A		;$b7
	SBC HL,DE		;$ed, $52
	LD A,L		;$7d
	SUB A,(IY+$6)		;$fd, $96, $6
	LD HL,(IX-$4)		;$dd, $27, $fc
	JP P,._lbl_133		;$f2, $bb, $2c, $0
	NEG		;$ed, $44
	LD B,A		;$47
	LD A,$30		;$3e, $30
._lbl_134:		;$=0x2cb4
	LD (HL),A		;$77
	INC HL		;$23
	DJNZ ._lbl_134		;$10, $fc
	LD (IX-$4),HL		;$dd, $2f, $fc
._lbl_133:		;$=0x2cbb
	BIT 3,(IY+$1)		;$fd, $cb, $1, $5e
	JR Z,._lbl_135		;$28, $1d
	BIT 0,(IX+$fb)		;$dd, $cb, $fb, $46
	JR Z,._lbl_135		;$28, $17
	LD A,(IX-$6)		;$dd, $7e, $fa
	CP A,$10		;$fe, $10
	JR NZ,._lbl_136		;$20, $9
	LD A,$17		;$3e, $17
	ADD A,(IX-$1)		;$dd, $86, $ff
	LD (HL),A		;$77
	INC HL		;$23
	JR ._lbl_137		;$18, $4
._lbl_136:		;$=0x2cd7
	CP A,$8		;$fe, $8
	JR NZ,._lbl_138		;$20, $2
._lbl_137:		;$=0x2cdb
	LD (HL),$30		;$36, $30
._lbl_138:		;$=0x2cdd
	INC HL		;$23
._lbl_135:		;$=0x2cde
	LD A,(IY+$6)		;$fd, $7e, $6
	OR A,A		;$b7
	JR Z,._lbl_139		;$28, $4
	RES 6,(IY+$1)		;$fd, $cb, $1, $b6
._lbl_139:		;$=0x2ce8
	LD (HL),$0		;$36, $0
	LD BC,$d00112		;$1, $12, $1, $d0
	PUSH BC		;$c5
	CALL ._lbl_122		;$cd, $fd, $2c, $0
	POP BC		;$c1
	CALL ._lbl_62		;$cd, $25, $28, $0
	LD SP,IX		;$dd, $f9
	POP IX		;$dd, $e1
	RET		;$c9
._lbl_122:		;$=0x2cfd
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	DEC SP		;$3b
	LD HL,(IX+$6)		;$dd, $27, $6
	PUSH HL		;$e5
	CALL ._lbl_7		;$cd, $df, $24, $0
	POP BC		;$c1
	PUSH HL		;$e5
	POP BC		;$c1
	LD HL,(IX+$6)		;$dd, $27, $6
	ADD HL,BC		;$9
	DEC HL		;$2b
	EX DE,HL		;$eb
	JR ._lbl_140		;$18, $14
._lbl_141:		;$=0x2d1a
	LD A,(DE)		;$1a
	LD (IX-$1),A		;$dd, $77, $ff
	LD HL,(IX+$6)		;$dd, $27, $6
	LD A,(HL)		;$7e
	LD (DE),A		;$12
	DEC DE		;$1b
	LD A,(IX-$1)		;$dd, $7e, $ff
	LD (HL),A		;$77
	INC HL		;$23
	LD (IX+$6),HL		;$dd, $2f, $6
	DEC BC		;$b
	DEC BC		;$b
._lbl_140:		;$=0x2d2e
	LD HL,$1		;$21, $1, $0, $0
	OR A,A		;$b7
	SBC HL,BC		;$ed, $42
	JR C,._lbl_141		;$38, $e3
	LD SP,IX		;$dd, $f9
	POP IX		;$dd, $e1
	RET		;$c9
._lbl_49:		;$=0x2d3c
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	PUSH BC		;$c5
	PUSH BC		;$c5
	PUSH BC		;$c5
	DEC SP		;$3b
	DEC SP		;$3b
	LD HL,$0		;$21, $0, $0, $0
	LD (IX-$6),HL		;$dd, $2f, $fa
	LD (IX-$9),HL		;$dd, $2f, $f7
	RES 0,(IX+$f5)		;$dd, $cb, $f5, $86
	LD IY,(IX+$9)		;$dd, $31, $9
	LD (IY+$1),L		;$fd, $75, $1
	LD (IY+$5),L		;$fd, $75, $5
	LD (IY+$6),L		;$fd, $75, $6
	LD (IY+$2),L		;$fd, $75, $2
	LD (IY+$4),L		;$fd, $75, $4
._lbl_157:		;$=0x2d6a
	LD HL,(IX+$6)		;$dd, $27, $6
	LD A,(HL)		;$7e
	LD (IX-$a),A		;$dd, $77, $f6
	INC HL		;$23
	LD (IX+$6),HL		;$dd, $2f, $6
	CP A,$2d		;$fe, $2d
	JR Z,._lbl_142		;$28, $c
	CP A,$2b		;$fe, $2b
	JR Z,._lbl_142		;$28, $8
	CP A,$20		;$fe, $20
	JR Z,._lbl_142		;$28, $4
	CP A,$23		;$fe, $23
	JR NZ,._lbl_143		;$20, $6
._lbl_142:		;$=0x2d85
	LD (IX@),$f7		;$dd, $36, $f7
	NOP		;$0
	JR ._lbl_144		;$18, $5e
._lbl_143:		;$=0x2d8b
	CP A,$30		;$fe, $30
	JR C,._lbl_145		;$38, $a
	CP A,$3a		;$fe, $3a
	JR NC,._lbl_145		;$30, $6
	LD (IX@),$f7		;$dd, $36, $f7
	LD BC,$fe5018		;$1, $18, $50, $fe
	LD L,$20		;$2e, $20
	LD B,$dd		;$6, $dd
	LD (HL),$f7		;$36, $f7
	INC BC		;$3
	JR ._lbl_144		;$18, $46
	CP A,$2a		;$fe, $2a
	JR NZ,._lbl_146		;$20, $6
	LD (IX@),$f7		;$dd, $36, $f7
	LD B,$18		;$6, $18
	INC A		;$3c
._lbl_146:		;$=0x2dad
	CP A,$64		;$fe, $64
	JR Z,._lbl_147		;$28, $24
	CP A,$69		;$fe, $69
	JR Z,._lbl_147		;$28, $20
	CP A,$6f		;$fe, $6f
	JR Z,._lbl_147		;$28, $1c
	CP A,$75		;$fe, $75
	JR Z,._lbl_147		;$28, $18
	CP A,$78		;$fe, $78
	JR Z,._lbl_147		;$28, $14
	CP A,$58		;$fe, $58
	JR Z,._lbl_147		;$28, $10
	CP A,$63		;$fe, $63
	JR Z,._lbl_147		;$28, $c
	CP A,$73		;$fe, $73
	JR Z,._lbl_147		;$28, $8
	CP A,$70		;$fe, $70
	JR Z,._lbl_147		;$28, $4
	CP A,$6e		;$fe, $6e
	JR NZ,._lbl_148		;$20, $6
._lbl_147:		;$=0x2dd5
	LD (IX@),$f7		;$dd, $36, $f7
	INC B		;$4
	JR ._lbl_144		;$18, $e
._lbl_148:		;$=0x2ddb
	CP A,$25		;$fe, $25
	JR NZ,._lbl_149		;$20, $6
	LD (IX@),$f7		;$dd, $36, $f7
	DEC B		;$5
	JR ._lbl_144		;$18, $4
._lbl_149:		;$=0x2de5
	LD (IX@),$f7		;$dd, $36, $f7
	RLCA		;$7
._lbl_144:		;$=0x2de9
	LD HL,(IX-$6)		;$dd, $27, $fa
	LD (IX-$3),HL		;$dd, $2f, $fd
	ADD HL,HL		;$29
	ADD HL,HL		;$29
	ADD HL,HL		;$29
	LD BC,._lbl_150		;$1, $55, $2f, $0
	ADD HL,BC		;$9
	LD BC,(IX-$9)		;$dd, $7, $f7
	ADD HL,BC		;$9
	LD A,(HL)		;$7e
	LD (IX-$6),A		;$dd, $77, $fa
	CP A,$ff		;$fe, $ff
	JR NZ,._lbl_151		;$20, $6
	LD (IY@),$0		;$fd, $36, $0
	NOP		;$0
	JR ._lbl_152		;$18, $8
._lbl_151:		;$=0x2e09
	CP A,$fe		;$fe, $fe
	JR NZ,._lbl_153		;$20, $c
	LD (IY@),$0		;$fd, $36, $0
	LD BC,$627dd		;$1, $dd, $27, $6
	DEC HL		;$2b
	JP ._lbl_154		;$c3, $50, $2f, $0
._lbl_153:		;$=0x2e19
	CP A,$2		;$fe, $2
	JR NZ,._lbl_155		;$20, $35
	LD A,(IX-$a)		;$dd, $7e, $f6
	CP A,$2d		;$fe, $2d
	JR NZ,._lbl_156		;$20, $8
	SET 0,(IY+$1)		;$fd, $cb, $1, $c6
	JP ._lbl_157		;$c3, $6a, $2d, $0
._lbl_156:		;$=0x2e2c
	CP A,$2b		;$fe, $2b
	JR NZ,._lbl_158		;$20, $8
	SET 1,(IY+$1)		;$fd, $cb, $1, $ce
	JP ._lbl_157		;$c3, $6a, $2d, $0
._lbl_158:		;$=0x2e38
	CP A,$20		;$fe, $20
	JR NZ,._lbl_159		;$20, $8
	SET 2,(IY+$1)		;$fd, $cb, $1, $d6
	JP ._lbl_157		;$c3, $6a, $2d, $0
._lbl_159:		;$=0x2e44
	CP A,$23		;$fe, $23
	JP NZ,._lbl_157		;$c2, $6a, $2d, $0
	SET 3,(IY+$1)		;$fd, $cb, $1, $de
	JP ._lbl_157		;$c3, $6a, $2d, $0
._lbl_155:		;$=0x2e52
	CP A,$3		;$fe, $3
	JR NZ,._lbl_160		;$20, $43
	LD A,(IX-$a)		;$dd, $7e, $f6
	CP A,$2a		;$fe, $2a
	JR NZ,._lbl_161		;$20, $17
	LD HL,(IX+$c)		;$dd, $27, $c
	TRAP		;$ed, $31
	LD A,(IY+$0)		;$fd, $7e, $0
	LEA BC,IY+$3		;$ed, $3, $3
	LD (HL),BC		;$ed, $f
	LD IY,(IX+$9)		;$dd, $31, $9
	LD (IY+$5),A		;$fd, $77, $5
	JP ._lbl_157		;$c3, $6a, $2d, $0
._lbl_161:		;$=0x2e74
	LD A,(IX-$a)		;$dd, $7e, $f6
	SUB A,$30		;$d6, $30
	JR NZ,._lbl_162		;$20, $f
	LD BC,(IX-$3)		;$dd, $7, $fd
	LD HL,(IX-$6)		;$dd, $27, $fa
	OR A,A		;$b7
	SBC HL,BC		;$ed, $42
	JR Z,._lbl_162		;$28, $4
	SET 6,(IY+$1)		;$fd, $cb, $1, $f6
._lbl_162:		;$=0x2e8a
	LD B,(IY+$5)		;$fd, $46, $5
	LD C,$a		;$e, $a
	MLT BC		;$ed, $4c
	ADD A,C		;$81
	LD (IY+$5),A		;$fd, $77, $5
	JP ._lbl_157		;$c3, $6a, $2d, $0
._lbl_160:		;$=0x2e99
	CP A,$4		;$fe, $4
	JR NZ,._lbl_163		;$20, $8
	SET 0,(IX+$f5)		;$dd, $cb, $f5, $c6
	JP ._lbl_157		;$c3, $6a, $2d, $0
._lbl_163:		;$=0x2ea5
	CP A,$5		;$fe, $5
	JR NZ,._lbl_164		;$20, $32
	LD A,(IX-$a)		;$dd, $7e, $f6
	CP A,$2a		;$fe, $2a
	JR NZ,._lbl_165		;$20, $17
	LD HL,(IX+$c)		;$dd, $27, $c
	TRAP		;$ed, $31
	LD A,(IY+$0)		;$fd, $7e, $0
	LEA BC,IY+$3		;$ed, $3, $3
	LD (HL),BC		;$ed, $f
	LD IY,(IX+$9)		;$dd, $31, $9
	LD (IY+$6),A		;$fd, $77, $6
	JP ._lbl_157		;$c3, $6a, $2d, $0
._lbl_165:		;$=0x2ec7
	LD B,(IY+$6)		;$fd, $46, $6
	LD C,$a		;$e, $a
	MLT BC		;$ed, $4c
	LD A,(IX-$a)		;$dd, $7e, $f6
	SUB A,$30		;$d6, $30
	ADD A,C		;$81
	LD (IY+$6),A		;$fd, $77, $6
	JP ._lbl_157		;$c3, $6a, $2d, $0
._lbl_164:		;$=0x2edb
	CP A,$6		;$fe, $6
	JR NZ,._lbl_166		;$20, $a
	LD A,(IX-$a)		;$dd, $7e, $f6
	LD (IY+$2),A		;$fd, $77, $2
	JP ._lbl_157		;$c3, $6a, $2d, $0
._lbl_166:		;$=0x2ee9
	CP A,$7		;$fe, $7
	JR NZ,._lbl_167		;$20, $50
	LD A,(IX-$a)		;$dd, $7e, $f6
	CP A,$41		;$fe, $41
	JR C,._lbl_168		;$38, $a
	CP A,$5b		;$fe, $5b
	JR NC,._lbl_168		;$30, $6
	ADD A,$20		;$c6, $20
	SET 5,(IY+$1)		;$fd, $cb, $1, $ee
._lbl_168:		;$=0x2efe
	LD (IY+$4),A		;$fd, $77, $4
	LD A,(IY+$5)		;$fd, $7e, $5
	OR A,A		;$b7
	JP P,._lbl_169		;$f2, $12, $2f, $0
	SET 0,(IY+$1)		;$fd, $cb, $1, $c6
	NEG		;$ed, $44
	LD (IY+$5),A		;$fd, $77, $5
._lbl_169:		;$=0x2f12
	BIT 0,(IX+$f5)		;$dd, $cb, $f5, $46
	JR Z,._lbl_170		;$28, $8
	LD A,(IY+$6)		;$fd, $7e, $6
	OR A,A		;$b7
	JP P,._lbl_171		;$f2, $24, $2f, $0
._lbl_170:		;$=0x2f20
	LD (IY@),$6		;$fd, $36, $6
	NOP		;$0
._lbl_171:		;$=0x2f24
	LD A,(IX-$a)		;$dd, $7e, $f6
	CP A,$73		;$fe, $73
	JP NZ,._lbl_157		;$c2, $6a, $2d, $0
	BIT 0,(IX+$f5)		;$dd, $cb, $f5, $46
	JP Z,._lbl_157		;$ca, $6a, $2d, $0
	SET 4,(IY+$1)		;$fd, $cb, $1, $e6
	JP ._lbl_157		;$c3, $6a, $2d, $0
._lbl_167:		;$=0x2f3d
	CP A,$8		;$fe, $8
	JP NZ,._lbl_157		;$c2, $6a, $2d, $0
	LD (IY@),$0		;$fd, $36, $0
	LD (BC),A		;$2
	LD A,(IX-$a)		;$dd, $7e, $f6
	LD (IY+$3),A		;$fd, $77, $3
	LD HL,(IX+$6)		;$dd, $27, $6
._lbl_154:		;$=0x2f50
	LD SP,IX		;$dd, $f9
	POP IX		;$dd, $e1
	RET		;$c9
._lbl_150:		;$=0x2f55
	CP A,$fe		;$fe, $fe
	CP A,$fe		;$fe, $fe
	CP A,$1		;$fe, $1
	CP A,$fe		;$fe, $fe
	LD (BC),A		;$2
	INC BC		;$3
	LD B,$4		;$6, $4
	RLCA		;$7
	EX AF,AF'		;$8
	INC BC		;$3
	CP A,$2		;$fe, $2
	INC BC		;$3
	LD B,$4		;$6, $4
	RLCA		;$7
	CP A,$3		;$fe, $3
	CP A,$fe		;$fe, $fe
	INC BC		;$3
	LD B,$4		;$6, $4
	RLCA		;$7
	CP A,$3		;$fe, $3
	CP A,$fe		;$fe, $fe
	DEC B		;$5
	CP A,$fe		;$fe, $fe
	RLCA		;$7
	CP A,$5		;$fe, $5
	CP A,$fe		;$fe, $fe
	DEC B		;$5
	LD B,$fe		;$6, $fe
	RLCA		;$7
	CP A,$5		;$fe, $5
	CP A,$fe		;$fe, $fe
	CP A,$fe		;$fe, $fe
	CP A,$7		;$fe, $7
	CP A,$fe		;$fe, $fe
	CP A,$ff		;$fe, $ff
	RST 38		;$ff
	RST 38		;$ff
	RST 38		;$ff
	RST 38		;$ff
	RST 38		;$ff
	RST 38		;$ff
	RST 38		;$ff
	RST 38		;$ff
	RST 38		;$ff
	RST 38		;$ff
	RST 38		;$ff
	RST 38		;$ff
	RST 38		;$ff
	RST 38		;$ff
	RST 38		;$ff
._lbl_182:		;$=0x2f9d
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	PUSH BC		;$c5
	RLC (IX+$ff)		;$dd, $cb, $ff, $6
	SCF		;$37
	RR (IX+$ff)		;$dd, $cb, $ff, $1e
	POP BC		;$c1
	RL A		;$cb, $17
	LD D,$0		;$16, $0
	JR NZ,._lbl_172		;$20, $5
	LD BC,$0		;$1, $0, $0, $0
	OR A,A		;$b7
._lbl_172:		;$=0x2fbc
	RL D		;$cb, $12
	OR A,A		;$b7
	POP IX		;$dd, $e1
	RET		;$c9
._lbl_183:		;$=0x2fc2
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	PUSH HL		;$e5
	ADD HL,HL		;$29
	SET 7,(IX+$ff)		;$dd, $cb, $ff, $fe
	POP HL		;$e1
	RL E		;$cb, $13
	LD D,$0		;$16, $0
	PUSH AF		;$f5
	JR NZ,._lbl_173		;$20, $5
	LD HL,$0		;$21, $0, $0, $0
	OR A,A		;$b7
._lbl_173:		;$=0x2fde
	RL D		;$cb, $12
	POP AF		;$f1
	POP IX		;$dd, $e1
	RET		;$c9
._lbl_190:		;$=0x2fe4
	PUSH HL		;$e5
	PUSH DE		;$d5
	RR D		;$cb, $1a
	PUSH AF		;$f5
	LD D,$0		;$16, $0
	OR A,A		;$b7
	LD HL,$0		;$21, $0, $0, $0
	ADC HL,BC		;$ed, $4a
	JR NZ,._lbl_174		;$20, $d
	CP A,$1		;$fe, $1
	JR NC,._lbl_174		;$30, $9
._lbl_179:		;$=0x2ff8
	CCF		;$3f
	SBC A,A		;$9f
	SBC HL,HL		;$ed, $62
	LD E,$0		;$1e, $0
	POP AF		;$f1
	JR ._lbl_175		;$18, $54
._lbl_174:		;$=0x3001
	OR A,A		;$b7
	JP P,._lbl_176		;$f2, $14, $30, $0
	POP AF		;$f1
	CCF		;$3f
	PUSH AF		;$f5
	OR A,A		;$b7
	LD HL,$0		;$21, $0, $0, $0
	SBC HL,BC		;$ed, $42
	LD C,A		;$4f
	LD A,$0		;$3e, $0
	SBC A,C		;$99
._lbl_176:		;$=0x3014
	JR Z,._lbl_177		;$28, $d
	PUSH AF		;$f5
	INC SP		;$33
	PUSH HL		;$e5
	LD A,L		;$7d
	LD HL,$8		;$21, $8, $0, $0
	ADD HL,DE		;$19
	EX DE,HL		;$eb
	INC SP		;$33
	POP HL		;$e1
	INC SP		;$33
._lbl_177:		;$=0x3023
	OR A,A		;$b7
	LD BC,$0		;$1, $0, $0, $0
	ADC HL,BC		;$ed, $4a
	JP M,._lbl_178		;$fa, $3d, $30, $0
	INC BC		;$3
._lbl_180:		;$=0x302f
	EX DE,HL		;$eb
	SBC.SIL HL,BC		;$ed, $42
	EX DE,HL		;$eb
	JR C,._lbl_179		;$38, $c2
	ADD A,A		;$87
	ADC HL,HL		;$ed, $6a
	JP P,._lbl_180		;$f2, $2f, $30, $0
._lbl_178:		;$=0x303d
	ADD A,A		;$87
	LD BC,$800000		;$1, $0, $0, $80
	ADC HL,BC		;$ed, $4a
	JP P,._lbl_181		;$f2, $4a, $30, $0
	INC DE		;$13
	ADD HL,BC		;$9
._lbl_181:		;$=0x304a
	LD A,D		;$7a
	CP A,$1		;$fe, $1
	JR NC,._lbl_179		;$30, $a9
	POP AF		;$f1
	RR E		;$cb, $1b
	JR NC,._lbl_175		;$30, $1
	ADD HL,BC		;$9
._lbl_175:		;$=0x3055
	LD A,E		;$7b
	PUSH HL		;$e5
	POP BC		;$c1
	POP DE		;$d1
	POP HL		;$e1
	RET		;$c9
	RST 38		;$ff
	RST 38		;$ff
	LD A,A		;$7f
	LD A,A		;$7f
._lbl_217:		;$=0x305f
	PUSH HL		;$e5
	PUSH DE		;$d5
	CALL ._lbl_182		;$cd, $9d, $2f, $0
	RR D		;$cb, $1a
	PUSH AF		;$f5
	CALL ._lbl_183		;$cd, $c2, $2f, $0
	POP AF		;$f1
	RL D		;$cb, $12
	RRC D		;$cb, $a
	CP A,E		;$bb
	JR C,._lbl_184		;$38, $9
	RLC D		;$cb, $2
	PUSH HL		;$e5
	PUSH BC		;$c5
	LD B,A		;$47
	LD A,E		;$7b
	LD E,B		;$58
	POP HL		;$e1
	POP BC		;$c1
._lbl_184:		;$=0x307d
	SUB A,E		;$93
	JR Z,._lbl_185		;$28, $26
	CP A,$e8		;$fe, $e8
	CCF		;$3f
	JR NC,._lbl_186		;$30, $2d
	PUSH IX		;$dd, $e5
	PUSH DE		;$d5
	PUSH BC		;$c5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	LD D,(IX+$2)		;$dd, $56, $2
._lbl_187:		;$=0x3093
	SRL D		;$cb, $3a
	RR B		;$cb, $18
	RR C		;$cb, $19
	INC A		;$3c
	JR NZ,._lbl_187		;$20, $f7
	LD (IX+$0),BC		;$dd, $f, $0
	LD (IX+$2),D		;$dd, $72, $2
	POP BC		;$c1
	POP DE		;$d1
	POP IX		;$dd, $e1
._lbl_185:		;$=0x30a6
	LD A,D		;$7a
	AND A,A		;$a7
	JP PE,._lbl_188		;$ea, $b1, $30, $0
	SBC HL,BC		;$ed, $42
	SBC A,A		;$9f
	JR ._lbl_189		;$18, $4
._lbl_188:		;$=0x30b1
	ADD HL,BC		;$9
._lbl_186:		;$=0x30b2
	LD A,$0		;$3e, $0
	ADC A,A		;$8f
._lbl_189:		;$=0x30b5
	PUSH HL		;$e5
	POP BC		;$c1
	CALL ._lbl_190		;$cd, $e4, $2f, $0
	POP DE		;$d1
	POP HL		;$e1
	RET		;$c9
	CALL $1ea3		;$cd, $a3, $1e, $0
	JR Z,._lbl_191		;$28, $16
	PUSH BC		;$c5
	PUSH AF		;$f5
	POP BC		;$c1
	LD A,B		;$78
	AND A,E		;$a3
	LD A,C		;$79
	JP P,._lbl_192		;$f2, $d0, $30, $0
	XOR A,$80		;$ee, $80
._lbl_192:		;$=0x30d0
	BIT 2,A		;$cb, $57
	JR Z,._lbl_193		;$28, $2
	XOR A,$80		;$ee, $80
._lbl_193:		;$=0x30d6
	LD C,A		;$4f
	PUSH BC		;$c5
	POP AF		;$f1
	POP BC		;$c1
._lbl_191:		;$=0x30da
	RET		;$c9
	PUSH IX		;$dd, $e5
	PUSH IY		;$fd, $e5
	PUSH HL		;$e5
	PUSH DE		;$d5
	CALL ._lbl_182		;$cd, $9d, $2f, $0
	JR Z,._lbl_194		;$28, $67
	PUSH BC		;$c5
	LD C,A		;$4f
	LD A,D		;$7a
	CALL ._lbl_183		;$cd, $c2, $2f, $0
	PUSH HL		;$e5
	PUSH AF		;$f5
	XOR A,D		;$aa
	LD B,$0		;$6, $0
	LD D,$0		;$16, $0
	LD HL,$96		;$21, $96, $0, $0
	ADD HL,BC		;$9
	SBC HL,DE		;$ed, $52
	PUSH HL		;$e5
	POP IX		;$dd, $e1
	LD D,A		;$57
	POP AF		;$f1
	POP BC		;$c1
	POP HL		;$e1
	JR Z,._lbl_195		;$28, $3a
	LD IY,$0		;$fd, $21, $0, $0, $0
	OR A,A		;$b7
._lbl_199:		;$=0x310b
	RLA		;$17
	ADD IY,IY		;$fd, $29
	JR C,._lbl_196		;$38, $12
	SBC HL,BC		;$ed, $42
	JR NC,._lbl_197		;$30, $7
	SRA A		;$cb, $2f
	JR C,._lbl_197		;$38, $3
	ADD HL,BC		;$9
	JR ._lbl_198		;$18, $2
._lbl_197:		;$=0x311b
	INC IY		;$fd, $23
._lbl_198:		;$=0x311d
	DEC IX		;$dd, $2b
	ADD HL,HL		;$29
	JR ._lbl_199		;$18, $e9
._lbl_196:		;$=0x3122
	LD E,$0		;$1e, $0
	SRA A		;$cb, $2f
	JR C,._lbl_200		;$38, $5
	OR A,A		;$b7
	SBC HL,BC		;$ed, $42
	JR C,._lbl_201		;$38, $8
._lbl_200:		;$=0x312d
	LD BC,$1		;$1, $1, $0, $0
	ADD IY,BC		;$fd, $9
	RL E		;$cb, $13
._lbl_201:		;$=0x3135
	INC E		;$1c
	LD A,IXH		;$dd, $7c
	OR A,A		;$b7
	JR Z,._lbl_202		;$28, $d
	JP M,._lbl_203		;$fa, $40, $31, $0
._lbl_195:		;$=0x313f
	SCF		;$37
._lbl_203:		;$=0x3140
	SBC HL,HL		;$ed, $62
	LD E,H		;$5c
	LD A,$0		;$3e, $0
	PUSH HL		;$e5
	JR ._lbl_204		;$18, $5
._lbl_202:		;$=0x3148
	LD A,E		;$7b
	LD E,IXL		;$dd, $5d
	PUSH IY		;$fd, $e5
._lbl_204:		;$=0x314d
	POP BC		;$c1
._lbl_194:		;$=0x314e
	CALL ._lbl_190		;$cd, $e4, $2f, $0
	POP DE		;$d1
	POP HL		;$e1
	POP IY		;$fd, $e1
	POP IX		;$dd, $e1
	RET		;$c9
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	PUSH IY		;$fd, $e5
	LEA IY,IX-$a		;$ed, $55, $f6
	LD SP,IY		;$fd, $f9
	PUSH DE		;$d5
	PUSH HL		;$e5
	LD DE,$0		;$11, $0, $0, $0
	LD (IY+$1),D		;$fd, $72, $1
	LD (IY+$5),D		;$fd, $72, $5
	LD (IY+$2),DE		;$fd, $1f, $2
	CALL ._lbl_182		;$cd, $9d, $2f, $0
	JR Z,._lbl_205		;$28, $72
	CP A,$7f		;$fe, $7f
	JP M,._lbl_206		;$fa, $ca, $31, $0
	SUB A,$7e		;$d6, $7e
	LD (IY+$0),A		;$fd, $77, $0
	CP A,$20		;$fe, $20
	JP P,._lbl_207		;$f2, $e4, $31, $0
	XOR A,A		;$af
	BIT 0,D		;$cb, $42
	JR Z,._lbl_208		;$28, $4
	LD (IY@),$5		;$fd, $36, $5
	LD BC,$10ffd		;$1, $fd, $f, $1
	LD (IY+$4),A		;$fd, $77, $4
	LD A,(IY+$0)		;$fd, $7e, $0
	CP A,$18		;$fe, $18
	LD A,(IY+$4)		;$fd, $7e, $4
	JR Z,._lbl_205		;$28, $48
	JP P,._lbl_209		;$f2, $bb, $31, $0
	LD A,$18		;$3e, $18
	SUB A,(IY+$0)		;$fd, $96, $0
	LD L,A		;$6f
	LD A,(IY+$4)		;$fd, $7e, $4
	CALL $2027		;$cd, $27, $20, $0
	JR ._lbl_210		;$18, $16
._lbl_209:		;$=0x31bb
	LD A,(IY+$0)		;$fd, $7e, $0
	SUB A,$18		;$d6, $18
	LD L,A		;$6f
	LD A,(IY+$4)		;$fd, $7e, $4
	CALL $2018		;$cd, $18, $20, $0
	JR ._lbl_210		;$18, $7
._lbl_206:		;$=0x31ca
	XOR A,A		;$af
	LD BC,$0		;$1, $0, $0, $0
	JR ._lbl_205		;$18, $1f
._lbl_210:		;$=0x31d1
	BIT 0,(IY+$5)		;$fd, $cb, $5, $46
	JR Z,._lbl_205		;$28, $19
	LD HL,$0		;$21, $0, $0, $0
	LD E,A		;$5f
	XOR A,A		;$af
	SBC HL,BC		;$ed, $42
	SBC A,E		;$9b
	PUSH HL		;$e5
	POP BC		;$c1
	JR ._lbl_205		;$18, $c
._lbl_207:		;$=0x31e4
	LD BC,$ffffff		;$1, $ff, $ff, $ff
	LD A,$ff		;$3e, $ff
	BIT 0,D		;$cb, $42
	JR NZ,._lbl_205		;$20, $2
	LD A,$7f		;$3e, $7f
._lbl_205:		;$=0x31f0
	POP HL		;$e1
	POP DE		;$d1
	LD IY,(IX-$3)		;$dd, $31, $fd
	LD SP,IX		;$dd, $f9
	POP IX		;$dd, $e1
	RET		;$c9
	PUSH DE		;$d5
	LD DE,$96		;$11, $96, $0, $0
	OR A,A		;$b7
	JP P,._lbl_211		;$f2, $1b, $32, $0
	PUSH HL		;$e5
	LD HL,$0		;$21, $0, $0, $0
	SBC HL,BC		;$ed, $42
	PUSH HL		;$e5
	POP BC		;$c1
	POP HL		;$e1
	LD D,A		;$57
	LD A,$0		;$3e, $0
	SBC A,D		;$9a
	JP P,._lbl_212		;$f2, $19, $32, $0
	SRL A		;$cb, $3f
	INC E		;$1c
._lbl_212:		;$=0x3219
	LD D,$1		;$16, $1
._lbl_211:		;$=0x321b
	CALL ._lbl_190		;$cd, $e4, $2f, $0
	POP DE		;$d1
	RET		;$c9
	PUSH IX		;$dd, $e5
	PUSH HL		;$e5
	PUSH DE		;$d5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	CALL ._lbl_182		;$cd, $9d, $2f, $0
	PUSH BC		;$c5
	LD C,A		;$4f
	LD A,D		;$7a
	CALL ._lbl_183		;$cd, $c2, $2f, $0
	PUSH HL		;$e5
	XOR A,D		;$aa
	LD B,$0		;$6, $0
	LD D,$0		;$16, $0
	LD HL,$ffff80		;$21, $80, $ff, $ff
	ADD HL,BC		;$9
	ADD HL,DE		;$19
	LD D,A		;$57
	LD E,L		;$5d
	LD A,H		;$7c
	OR A,A		;$b7
	JR Z,._lbl_213		;$28, $b
	CP A,$80		;$fe, $80
	SBC HL,HL		;$ed, $62
	LD E,H		;$5c
	LD A,$0		;$3e, $0
	JP ._lbl_214		;$c3, $d4, $32, $0
._lbl_213:		;$=0x3254
	LD HL,$0		;$21, $0, $0, $0
	PUSH HL		;$e5
	LD BC,$0		;$1, $0, $0, $0
	LD H,(IX-$3)		;$dd, $66, $fd
	LD L,(IX-$6)		;$dd, $6e, $fa
	MLT HL		;$ed, $6c
	LD L,H		;$6c
	LD H,$0		;$26, $0
	LD B,(IX-$2)		;$dd, $46, $fe
	LD C,(IX-$6)		;$dd, $4e, $fa
	MLT BC		;$ed, $4c
	ADD HL,BC		;$9
	LD B,(IX-$3)		;$dd, $46, $fd
	LD C,(IX-$5)		;$dd, $4e, $fb
	MLT BC		;$ed, $4c
	ADD HL,BC		;$9
	PUSH HL		;$e5
	LD HL,(IX-$b)		;$dd, $27, $f5
	LD B,(IX-$1)		;$dd, $46, $ff
	LD C,(IX-$6)		;$dd, $4e, $fa
	MLT BC		;$ed, $4c
	ADD HL,BC		;$9
	LD B,(IX-$2)		;$dd, $46, $fe
	LD C,(IX-$5)		;$dd, $4e, $fb
	MLT BC		;$ed, $4c
	ADD HL,BC		;$9
	LD B,(IX-$3)		;$dd, $46, $fd
	LD C,(IX-$4)		;$dd, $4e, $fc
	MLT BC		;$ed, $4c
	ADD HL,BC		;$9
	LD A,L		;$7d
	LD (IX-$b),HL		;$dd, $2f, $f5
	LD HL,(IX-$a)		;$dd, $27, $f6
	LD B,(IX-$1)		;$dd, $46, $ff
	LD C,(IX-$5)		;$dd, $4e, $fb
	MLT BC		;$ed, $4c
	ADD HL,BC		;$9
	LD B,(IX-$2)		;$dd, $46, $fe
	LD C,(IX-$4)		;$dd, $4e, $fc
	MLT BC		;$ed, $4c
	ADD HL,BC		;$9
	LD (IX-$a),HL		;$dd, $2f, $f6
	LD HL,(IX-$9)		;$dd, $27, $f7
	LD B,(IX-$1)		;$dd, $46, $ff
	LD C,(IX-$4)		;$dd, $4e, $fc
	MLT BC		;$ed, $4c
	ADD HL,BC		;$9
	LD (IX-$9),HL		;$dd, $2f, $f7
	INC SP		;$33
	INC SP		;$33
	POP HL		;$e1
	LD C,A		;$4f
	LD A,$0		;$3e, $0
	SLA C		;$cb, $21
	ADC HL,HL		;$ed, $6a
	ADC A,A		;$8f
	SLA C		;$cb, $21
	ADC HL,HL		;$ed, $6a
	ADC A,A		;$8f
._lbl_214:		;$=0x32d4
	PUSH HL		;$e5
	POP BC		;$c1
	LD SP,IX		;$dd, $f9
	CALL ._lbl_190		;$cd, $e4, $2f, $0
	POP DE		;$d1
	POP HL		;$e1
	POP IX		;$dd, $e1
	RET		;$c9
	OR A,A		;$b7
	JR NZ,._lbl_215		;$20, $b
	PUSH HL		;$e5
	LD HL,$0		;$21, $0, $0, $0
	XOR A,A		;$af
	SBC HL,BC		;$ed, $42
	POP HL		;$e1
	JR Z,._lbl_216		;$28, $2
._lbl_215:		;$=0x32ef
	XOR A,$80		;$ee, $80
._lbl_216:		;$=0x32f1
	RET		;$c9
	PUSH AF		;$f5
	LD A,E		;$7b
	XOR A,$80		;$ee, $80
	LD E,A		;$5f
	POP AF		;$f1
	CALL ._lbl_217		;$cd, $5f, $30, $0
	PUSH AF		;$f5
	LD A,E		;$7b
	XOR A,$80		;$ee, $80
	LD E,A		;$5f
	POP AF		;$f1
	RET		;$c9
	PUSH DE		;$d5
	LD D,$0		;$16, $0
	LD E,$96		;$1e, $96
	CALL ._lbl_190		;$cd, $e4, $2f, $0
	POP DE		;$d1
	RET		;$c9
	PUSH IX		;$dd, $e5
	LD IX,$0		;$dd, $21, $0, $0, $0
	ADD IX,SP		;$dd, $39
	LD BC,(IX+$6)		;$dd, $7, $6
	LD A,(IX+$9)		;$dd, $7e, $9
	CALL ._lbl_182		;$cd, $9d, $2f, $0
	JR Z,._lbl_218		;$28, $54
	PUSH BC		;$c5
	POP IX		;$dd, $e1
	LD HL,$0		;$21, $0, $0, $0
	SRL A		;$cb, $3f
	JR C,._lbl_219		;$38, $4
	ADD IX,IX		;$dd, $29
	ADC HL,HL		;$ed, $6a
._lbl_219:		;$=0x3332
	ADC A,$3f		;$ce, $3f
	LD C,A		;$4f
	ADD IX,IX		;$dd, $29
	ADC HL,HL		;$ed, $6a
	DEC HL		;$2b
	LD A,$0		;$3e, $0
	LD DE,$1		;$11, $1, $0, $0
	LD B,$17		;$6, $17
._lbl_222:		;$=0x3342
	EX DE,HL		;$eb
	ADD HL,HL		;$29
	EX DE,HL		;$eb
	ADD IX,IX		;$dd, $29
	ADC HL,HL		;$ed, $6a
	RLA		;$17
	ADD IX,IX		;$dd, $29
	ADC HL,HL		;$ed, $6a
	RLA		;$17
	SBC HL,DE		;$ed, $52
	SBC A,$0		;$de, $0
	JR C,._lbl_220		;$38, $b
	INC DE		;$13
	SBC HL,DE		;$ed, $52
	SBC A,$0		;$de, $0
	JR NC,._lbl_221		;$30, $7
	ADD HL,DE		;$19
	ADC A,$0		;$ce, $0
	DEC DE		;$1b
._lbl_220:		;$=0x3360
	ADD HL,DE		;$19
	ADC A,$0		;$ce, $0
._lbl_221:		;$=0x3363
	DJNZ ._lbl_222		;$10, $dd
	OR A,A		;$b7
	SBC HL,DE		;$ed, $52
	SBC A,$0		;$de, $0
	SBC HL,HL		;$ed, $62
	INC HL		;$23
	LD A,$0		;$3e, $0
	ADD HL,DE		;$19
	ADC A,$0		;$ce, $0
	LD E,C		;$59
	LD D,$0		;$16, $0
	PUSH HL		;$e5
	POP BC		;$c1
._lbl_218:		;$=0x3377
	CALL ._lbl_190		;$cd, $e4, $2f, $0
	PUSH BC		;$c5
	POP HL		;$e1
	LD E,A		;$5f
	POP IX		;$dd, $e1
	RET		;$c9
	OR A,A		;$b7
	RLA		;$17
	JR NC,._lbl_223		;$30, $c
	JR NZ,._lbl_224		;$20, $8
	RRA		;$1f
	LD HL,$800000		;$21, $0, $0, $80
	LD E,$bf		;$1e, $bf
	RET		;$c9
._lbl_224:		;$=0x338f
	NEG		;$ed, $44
._lbl_223:		;$=0x3391
	PUSH AF		;$f5
	CALL ._lbl_225		;$cd, $bd, $34, $0
	POP AF		;$f1
	RET NC		;$d0
	RRA		;$1f
	RL E		;$cb, $13
	SCF		;$37
	RR E		;$cb, $1b
	RET		;$c9
	CALL ._lbl_226		;$cd, $e3, $33, $0
	OR A,A		;$b7
	RRA		;$1f
	OR A,A		;$b7
	RET Z		;$c8
	RL E		;$cb, $13
	JR NC,._lbl_227		;$30, $2
	NEG		;$ed, $44
._lbl_227:		;$=0x33ad
	RR E		;$cb, $1b
	RET		;$c9
	CALL ._lbl_228		;$cd, $27, $34, $0
	PUSH HL		;$e5
	LD HL,$2		;$21, $2, $0, $0
	ADD HL,SP		;$39
	SRL (HL)		;$cb, $3e
	POP HL		;$e1
	RR H		;$cb, $1c
	RR L		;$cb, $1d
	PUSH DE		;$d5
	RL E		;$cb, $13
	JR NC,._lbl_229		;$30, $6
	EX DE,HL		;$eb
	OR A,A		;$b7
	SBC HL,HL		;$ed, $62
	SBC HL,DE		;$ed, $52
._lbl_229:		;$=0x33cc
	POP DE		;$d1
	RET		;$c9
	CALL ._lbl_230		;$cd, $63, $34, $0
	SRL H		;$cb, $3c
	RR L		;$cb, $1d
	PUSH DE		;$d5
	RL E		;$cb, $13
	JR NC,._lbl_231		;$30, $6
	EX DE,HL		;$eb
	OR A,A		;$b7
	SBC HL,HL		;$ed, $62
	SBC HL,DE		;$ed, $52
._lbl_231:		;$=0x33e1
	POP DE		;$d1
	RET		;$c9
._lbl_226:		;$=0x33e3
	PUSH HL		;$e5
	LD A,E		;$7b
	ADD HL,HL		;$29
	RLA		;$17
	CP A,$77		;$fe, $77
	JR C,._lbl_232		;$38, $4
	CP A,$96		;$fe, $96
	JR C,._lbl_233		;$38, $3
._lbl_232:		;$=0x33ef
	XOR A,A		;$af
	POP HL		;$e1
	RET		;$c9
._lbl_233:		;$=0x33f2
	SUB A,$7f		;$d6, $7f
	JR NZ,._lbl_234		;$20, $10
._lbl_237:		;$=0x33f6
	PUSH HL		;$e5
	LD HL,$1		;$21, $1, $0, $0
	ADD HL,SP		;$39
	RL (HL)		;$cb, $16
	INC HL		;$23
	LD A,(HL)		;$7e
	ADC A,$0		;$ce, $0
	INC HL		;$23
	LD SP,HL		;$f9
	POP HL		;$e1
	RET		;$c9
._lbl_234:		;$=0x3406
	PUSH BC		;$c5
	JR C,._lbl_235		;$38, $7
	LD B,A		;$47
._lbl_236:		;$=0x340a
	ADD HL,HL		;$29
	DJNZ ._lbl_236		;$10, $fd
	POP BC		;$c1
	JR ._lbl_237		;$18, $e6
._lbl_235:		;$=0x3410
	LD HL,$5		;$21, $5, $0, $0
	ADD HL,SP		;$39
	NEG		;$ed, $44
	LD B,A		;$47
	LD A,(HL)		;$7e
	OR A,A		;$b7
	RLA		;$17
	SCF		;$37
	JR ._lbl_238		;$18, $42
._lbl_239:		;$=0x341e
	OR A,A		;$b7
._lbl_251:		;$=0x341f
	RRA		;$1f
	DJNZ ._lbl_239		;$10, $fc
	ADC A,$0		;$ce, $0
	POP BC		;$c1
	POP HL		;$e1
	RET		;$c9
._lbl_228:		;$=0x3427
	PUSH AF		;$f5
	LD A,E		;$7b
	ADD HL,HL		;$29
	RLA		;$17
	CP A,$67		;$fe, $67
	JR C,._lbl_240		;$38, $4
	CP A,$96		;$fe, $96
	JR C,._lbl_241		;$38, $5
._lbl_240:		;$=0x3433
	OR A,A		;$b7
	SBC HL,HL		;$ed, $62
._lbl_242:		;$=0x3436
	POP AF		;$f1
	RET		;$c9
._lbl_241:		;$=0x3438
	SUB A,$7f		;$d6, $7f
	JR Z,._lbl_242		;$28, $fa
	PUSH BC		;$c5
	JR C,._lbl_243		;$38, $6
	LD B,A		;$47
._lbl_244:		;$=0x3440
	ADD HL,HL		;$29
	DJNZ ._lbl_244		;$10, $fd
	JR ._lbl_238		;$18, $1b
._lbl_243:		;$=0x3445
	PUSH HL		;$e5
	LD HL,$2		;$21, $2, $0, $0
	ADD HL,SP		;$39
	NEG		;$ed, $44
	LD B,A		;$47
	LD A,(HL)		;$7e
	POP HL		;$e1
._lbl_245:		;$=0x3450
	RRA		;$1f
	RR H		;$cb, $1c
	RR L		;$cb, $1d
	OR A,A		;$b7
	DJNZ ._lbl_245		;$10, $f8
	PUSH HL		;$e5
	LD HL,$2		;$21, $2, $0, $0
	ADD HL,SP		;$39
	LD (HL),A		;$77
	POP HL		;$e1
._lbl_238:		;$=0x3460
	POP BC		;$c1
	POP AF		;$f1
	RET		;$c9
._lbl_230:		;$=0x3463
	PUSH AF		;$f5
	LD A,E		;$7b
	ADD HL,HL		;$29
	RLA		;$17
	DEC SP		;$3b
	PUSH HL		;$e5
	INC SP		;$33
	POP HL		;$e1
	CP A,$6f		;$fe, $6f
	JR C,._lbl_246		;$38, $4
	CP A,$96		;$fe, $96
	JR C,._lbl_247		;$38, $5
._lbl_246:		;$=0x3473
	OR A,A		;$b7
	SBC HL,HL		;$ed, $62
._lbl_248:		;$=0x3476
	POP AF		;$f1
	RET		;$c9
._lbl_247:		;$=0x3478
	SUB A,$7f		;$d6, $7f
	JR Z,._lbl_248		;$28, $fa
	PUSH BC		;$c5
	JR C,._lbl_249		;$38, $6
	LD B,A		;$47
._lbl_250:		;$=0x3480
	ADD HL,HL		;$29
	DJNZ ._lbl_250		;$10, $fd
	JR ._lbl_251		;$18, $9a
._lbl_249:		;$=0x3485
	NEG		;$ed, $44
	LD B,A		;$47
._lbl_252:		;$=0x3488
	RR H		;$cb, $1c
	RR L		;$cb, $1d
	OR A,A		;$b7
	DJNZ ._lbl_252		;$10, $f9
	POP BC		;$c1
	POP AF		;$f1
	RET		;$c9
._lbl_256:		;$=0x3492
	PUSH DE		;$d5
	EX DE,HL		;$eb
	LD HL,$800000		;$21, $0, $0, $80
	OR A,A		;$b7
	SBC HL,DE		;$ed, $52
	JR C,._lbl_253		;$38, $1
	EX DE,HL		;$eb
._lbl_253:		;$=0x349e
	JR NZ,._lbl_254		;$20, $4
	POP DE		;$d1
	LD E,$bf		;$1e, $bf
	RET		;$c9
._lbl_254:		;$=0x34a4
	ADD HL,HL		;$29
	CALL ._lbl_255		;$cd, $d7, $34, $0
	EX DE,HL		;$eb
	ADD HL,HL		;$29
	EX DE,HL		;$eb
	RR E		;$cb, $1b
	EX (SP),HL		;$e3
	EX DE,HL		;$eb
	LD E,L		;$5d
	POP HL		;$e1
	RET		;$c9
	PUSH HL		;$e5
	DEC SP		;$3b
	POP HL		;$e1
	INC SP		;$33
	LD L,$0		;$2e, $0
	JP ._lbl_256		;$c3, $92, $34, $0
._lbl_225:		;$=0x34bd
	OR A,A		;$b7
	JR NZ,._lbl_257		;$20, $4
	SBC HL,HL		;$ed, $62
	LD E,A		;$5f
	RET		;$c9
._lbl_257:		;$=0x34c4
	LD L,A		;$6f
	LD E,$7f		;$1e, $7f
._lbl_258:		;$=0x34c7
	DEC E		;$1d
	ADD A,A		;$87
	JR NC,._lbl_258		;$30, $fc
	SRA E		;$cb, $2b
	RRA		;$1f
	PUSH AF		;$f5
	DEC SP		;$3b
	LD A,L		;$7d
	POP HL		;$e1
	INC SP		;$33
	SBC.SIL HL,HL		;$ed, $62
	RET		;$c9
._lbl_255:		;$=0x34d7
	PUSH DE		;$d5
	LD DE,$0		;$11, $0, $0, $0
	OR A,A		;$b7
	SBC HL,DE		;$ed, $52
	POP DE		;$d1
	JR NZ,._lbl_259		;$20, $3
	LD E,$0		;$1e, $0
	RET		;$c9
._lbl_259:		;$=0x34e5
	LD E,$7f		;$1e, $7f
._lbl_260:		;$=0x34e7
	DEC E		;$1d
	ADD HL,HL		;$29
	JR NC,._lbl_260		;$30, $fc
	PUSH HL		;$e5
	LD HL,$2		;$21, $2, $0, $0
	ADD HL,SP		;$39
	SRA E		;$cb, $2b
	RR (HL)		;$cb, $1e
	POP HL		;$e1
	RR H		;$cb, $1c
	RR L		;$cb, $1d
	RET		;$c9
	PUSH HL		;$e5
	DEC SP		;$3b
	POP HL		;$e1
	INC SP		;$33
	LD L,$0		;$2e, $0
	JP $0		;$c3
	RST 10		;$d7
	INC (HL)		;$34
	NOP		;$0
._lbl_72:=$2898
._lbl_73:=$2896
._lbl_99:=$2add
._lbl_106:=$2b3e
._lbl_130:=$2c78
._lbl_145:=$2d99
._lbl_152:=$2e11
._lbl_208:=$3198
