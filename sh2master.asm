! ###########################################################################
!  SAXMAN'S SONIC BOOM ENGINE v1.00
!  A modification of Sonic 2
!  December 3, 2014
! ###########################################################################
!
! SH2MASTER.ASM
!
! This file contains code written specifically for the Sega 32X. When the
! system boots, "Init" is executed. The program then continues to "Main"
! where the SH-2 will wait for a command (a non-zero number inserted into
! the first byte of the 32X communication register). The program determines
! where to go next using the "BranchTable".
!
! During execution of SH-2 code, the RV flag will be turned off so the SH-2
! can access the ROM. During this, any 68000 code should be executed from RAM
! to avoid addressing errors that may result when the Genesis memory map is
! changed. After the SH-2 code is finished, the RV flag will be turned on
! again and 68000 execution may continue from the ROM.

	.text

	/*
		Savestate locations:

		0x64A78 - 0xA4A77		SDRAM
		0xA4A85 - 0xA4A94		32X CPR
	*/

Init:
	mov.l		CPR_0,r14
0:
	mov.l		@r14,r0
	mov.l		M_OK,r1
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
	mov.l		CPR_8,r14
	mov.l		@r14+,r10	/* source */
	mov.l		@r14,r11	/* size */
	add			#-12,r11
TransferLoop:
	/* read 12 bytes from SDRAM */
	mov.l		@r10+,r0
	mov.l		@r10+,r1
	mov.l		@r10+,r2

	/* wait until 68000 is finished copying */
	mov.l		CPR_2,r14
TransferWait:
	mov.b		@r14,r9
	cmp/pl		r9
	bt			TransferWait	/* If SH-2 in wait state, branch */
	nop

	/* write 12 bytes to 32X communication register */
	mov.l		CPR_4,r14
	mov.l		r0,@r14
	add			#4,r14
	mov.l		r1,@r14
	add			#4,r14
	mov.l		r2,@r14

	/* indicate to 68000 that bytes are ready for copying */
	mov.l		CPR_2,r14
	mov			#1,r9			/* Put SH-2 in wait state */
	mov.b		r9,@r14

	/* adjust read count and loop */
	add			#-12,r11
	cmp/pl		r11
	bt			TransferLoop
	nop
	


	/* read last 12 bytes from SDRAM */
	mov.l		@r10+,r0
	mov.l		@r10+,r1
	mov.l		@r10+,r2

	/* wait until 68000 is finished copying */
	mov.l		CPR_2,r14
TransferWait2:
	mov.b		@r14,r9
	cmp/pl		r9
	bt			TransferWait2	/* If SH-2 in wait state, branch */
	nop

	/* write 12 bytes to 32X communication register */
	mov.l		CPR_4,r14
	mov.l		r0,@r14
	add			#4,r14
	mov.l		r1,@r14
	add			#4,r14
	mov.l		r2,@r14



	/* finished */
	mov.l		CPR_0,r14
	add			#1,r14
	add			#11,r11		/* add 12-1 to byte count */
	mov.b		r11,@r14	/* store remaining byte count */
	add			#-1,r14
	mov			#0,r0
	mov.b		r0,@r14
	bra			Main
	nop


KosDec_Init:
	mov.l		CPR_4,r14
	mov.l		@r14+,r10	/* source */
	mov.l		@r14+,r11	/* destination */
	mov			r11,r12		/* used later to determine size */

	/* run decompressor */
	sts.l		pr,@-r15
	bsr			Kos_Decomp
	nop
	lds.l		@r15+,pr
	
	/* finished */
	mov.l		CPR_0,r14
	mov			#0,r0
	mov.b		r0,@r14
	mov.l		CPR_C,r14
	sub			r12,r11
	mov.l		r11,@r14
	bra			Main
	nop


	.align 2
M_OK:		.ascii		"KO_M"
Stack:		.long		0x0603FF00
IntMask:	.long		0x20004000
VIntClr:	.long		0x20004016
CPR_0:		.long		0x20004020
CPR_2:		.long		0x20004022
CPR_4:		.long		0x20004024
CPR_6:		.long		0x20004026
CPR_8:		.long		0x20004028
CPR_A:		.long		0x2000402A
CPR_C:		.long		0x2000402C
CPR_E:		.long		0x2000402E

/*
; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||
; ------------------------------------------------------------------------
; KOSINSKI DECOMPRESSION PROCEDURE
; Hitachi SH2

; This is the only procedure in the game that stores variables on the stack.

; ARGUMENTS:
; r0 = source address				1223A
; r1 = destination address
; ------------------------------------------------------------------------
; KozDec_193A:
*/

/* http://segaretro.org/Kosinski_compression */

	.text                                                                            

Kos_Decomp:
	mov.b	@r10+,r7
	mov.b	@r10+,r5
	shll8	r5
	mov.l	and_8,r14
	and		r14,r7
	add		r7,r5
	mov		#0xF,r4
	

Kos_Decomp_Loop:
	mov		r5,r6
	shlr	r5
	add		#-1,r4
	cmp/pz	r4
	bt		Kos_Decomp_ChkBit
	nop

	mov.b	@r10+,r7
	mov.b	@r10+,r5
	shll8	r5
	mov.l	and_8,r14
	and		r14,r7
	add		r7,r5
	mov		#0xF,r4

Kos_Decomp_ChkBit:
	mov		#1,r14
	and		r14,r6
	cmp/eq	r14,r6
	bf		Kos_Decomp_RLE
	nop
	mov.b	@r10+,r14
	mov.b	r14,@r11
	add		#1,r11
	bra		Kos_Decomp_Loop
	nop

/****************************************************************************/

Kos_Decomp_RLE:
	mov		#0,r3
	mov		r5,r6
	shlr	r5
	add		#-1,r4
	cmp/pz	r4
	bt		Kos_Decomp_ChkBit2
	nop

	mov.b	@r10+,r7
	mov.b	@r10+,r5
	shll8	r5
	mov.l	and_8,r14
	and		r14,r7
	add		r7,r5
	mov		#0xF,r4

Kos_Decomp_ChkBit2:
	mov		#1,r14
	and		r14,r6
	cmp/eq	r14,r6
	bt		Kos_Decomp_SeparateRLE
	nop

	mov		r5,r3
	mov		#1,r14
	and		r14,r3
	shll	r3

	shlr	r5
	add		#-1,r4
	cmp/pz	r4
	bt		branch1
	nop

	mov.b	@r10+,r7
	mov.b	@r10+,r5
	shll8	r5
	mov.l	and_8,r14
	and		r14,r7
	add		r7,r5
	mov		#0xF,r4
branch1:
	mov		r5,r9
	mov		#1,r14
	and		r14,r9

	shlr	r5
	add		#-1,r4
	cmp/pz	r4
	bt		branch2
	nop

	mov.b	@r10+,r7
	mov.b	@r10+,r5
	shll8	r5
	mov.l	and_8,r14
	and		r14,r7
	add		r7,r5
	mov		#0xF,r4
branch2:
	or		r9,r3
	add		#1,r3
	mov.b	@r10+,r2
	mov.l	sign_extend_8,r14
	or		r14,r2
	bra		Kos_Decomp_RLELoop
	nop

/****************************************************************************/

Kos_Decomp_SeparateRLE:
	mov.b	@r10+,r0
	mov.b	@r10+,r1
	mov		r1,r2
	mov.l	sign_extend_8,r14
	or		r14,r2
	shll2	r2
	shll2	r2
	shll	r2
	mov.l	sign_extend_8,r14
	and		r14,r2
	mov.l	and_8,r14
	and		r14,r0
	or		r0,r2
	mov		#0x7,r14
	and		r14,r1
	mov		#0,r14
	cmp/eq	r14,r1
	bt		Kos_Decomp_SeparateRLE2
	nop
	mov		r1,r3
	add		#1,r3

Kos_Decomp_RLELoop:
	mov		r11,r14
	add		r2,r14
	mov.b	@r14,r0
	mov.b	r0,@r11
	add		#1,r11
	add		#-1,r3
	cmp/pz	r3
	bt		Kos_Decomp_RLELoop
	nop
	bra		Kos_Decomp_Loop
	nop

Kos_Decomp_SeparateRLE2:
	mov.b	@r10+,r1
	mov.l	and_8,r14
	and		r14,r1
	mov		#0,r14
	cmp/eq	r14,r1
	bt		Kos_Decomp_Done
	nop
	mov		#1,r14
	cmp/eq	r14,r1
	bt		Kos_Decomp_Loop
	nop
	mov		r1,r3
	bra		Kos_Decomp_RLELoop
	nop

Kos_Decomp_Done:
	rts
	nop

	.align 2
sign_extend_8:	.long	0xFFFFFF00
and_8:			.long	0x000000FF

	