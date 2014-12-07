	.text

InterruptHandler:
	
	! Clear vertical interrupt
	mov			#0,r0
	mov.l		VIntClr,r14
	mov.w		r0,@r14

IntLoop:
	!bra			IntLoop
	!nop

	add			#-4,r15
	mov.l		r14,@r15
	add			#-4,r15
	mov.l		r1,@r15
	add			#-4,r15
	mov.l		r0,@r15

	mov.l		DREQ,r14
	mov.w		@r14,r1
	mov			r1,r0
	shlr		r0
	shll		r0
	mov.w		r0,@r14
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
noploop:
	bra	noploop
	nop

0:
	mov.w		@r14,r0
	and			#1,r0
	cmp/pl		r0
	bf			0b
	nop

1:
	! --- STUCK AT THIS LOOP ---
	mov.w		@r14,r0
	and			#1,r0
	cmp/pl		r0
	bt			1b
	nop

	mov.w		r1,@r14

	mov.l		@r15+,r0
	mov.l		@r15+,r1
	mov.l		@r15+,r14

	rte
	nop

	.align 2
DREQ:		.long		0x20004006
VIntClr:	.long		0x20004016
CPR_0:		.long		0x20004020
CPR_2:		.long		0x20004022
CPR_4:		.long		0x20004024
CPR_6:		.long		0x20004026
CPR_8:		.long		0x20004028
CPR_A:		.long		0x2000402A
CPR_C:		.long		0x2000402C
CPR_E:		.long		0x2000402E
