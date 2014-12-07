	.text

Init:
	mov.l		CPR_4,r14
0:
	mov.l		@r14,r0
	mov.l		S_OK,r1
	cmp/eq		r0,r1
	bt			0b
	nop
	
	mov			#0,r0
	mov.l		r0,@r14

Main:
	mov.l		CPR_0,r14
MainLoop:
	mov.b		@r14,r1
	mov			#0,r0
	cmp/eq		r0,r1
	bt			MainLoop
	nop

	add			#-1,r1
	shll2		r1
	mova		BranchTable,r0
	add			r1,r0
	mov.l		@r0,r2
	add			r2,r0
	sub			r1,r0
	jmp			@r0
	nop

	.align 2
BranchTable:
	.long		KosDec_Init - BranchTable
	.long		TransferArt - BranchTable



TransferArt:
	bra			Main
	nop



KosDec_Init:
	bra			Main
	nop



	.align 2
S_OK:		.ascii		"KO_S"
Stack:		.long		0x06040000
CPR_0:		.long		0x20004020
CPR_2:		.long		0x20004022
CPR_4:		.long		0x20004024
CPR_6:		.long		0x20004026
CPR_8:		.long		0x20004028
CPR_A:		.long		0x2000402A
CPR_C:		.long		0x2000402C
CPR_E:		.long		0x2000402E
