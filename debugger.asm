; ---------------------------------------------------------------------------
; Debugger variables
v_regbuffer =			ramaddr( $FFFFFC00 ) ; stores registers d0-a7 during an error event ($40 bytes)
v_spbuffer =			ramaddr( $FFFFFC40 ) ; stores most recent sp address (4 bytes)
v_errortype =			ramaddr( $FFFFFC44 ) ; error type

; ---------------------------------------------------------------------------
; Debugger constants
vram_fg = $C000	; foreground namespace

; ---------------------------------------------------------------------------


BusError:
		move.b	#2,(v_errortype).w
		bra.s	loc_43A

AddressError:
		move.b	#4,(v_errortype).w
		bra.s	loc_43A

IllegalInstr:
		move.b	#6,(v_errortype).w
		addq.l	#2,2(sp)
		bra.s	loc_462

ZeroDivide:
		move.b	#8,(v_errortype).w
		bra.s	loc_462

ChkInstr:
		move.b	#$A,(v_errortype).w
		bra.s	loc_462

TrapvInstr:
		move.b	#$C,(v_errortype).w
		bra.s	loc_462

PrivilegeViol:
		move.b	#$E,(v_errortype).w
		bra.s	loc_462

Trace:
		move.b	#$10,(v_errortype).w
		bra.s	loc_462

Line1010Emu:
		move.b	#$12,(v_errortype).w
		addq.l	#2,2(sp)
		bra.s	loc_462

Line1111Emu:
		move.b	#$14,(v_errortype).w
		addq.l	#2,2(sp)
		bra.s	loc_462

ErrorExcept:
		move.b	#0,(v_errortype).w
		bra.s	loc_462
; ===========================================================================

loc_43A:
		disable_ints
		addq.w	#2,sp
		move.l	(sp)+,(v_spbuffer).w
		addq.w	#2,sp
		movem.l	d0-a7,(v_regbuffer).w
		bsr.w	ShowErrorMessage
		move.l	2(sp),d0
		bsr.w	ShowErrorValue
		move.l	(v_spbuffer).w,d0
		bsr.w	ShowErrorValue
		bra.s	loc_478
; ===========================================================================

loc_462:
		disable_ints
		movem.l	d0-a7,(v_regbuffer).w
		bsr.w	ShowErrorMessage
		move.l	2(sp),d0
		bsr.w	ShowErrorValue

loc_478:
		bsr.w	ErrorWaitForC
		movem.l	(v_regbuffer).w,d0-a7
		enable_ints
		rte	

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ShowErrorMessage:
		lea	(vdp_data_port).l,a6
		locVRAM	$F800
		lea	(ROM_Start+Art_Debug_Text).l,a0
		move.w	#$27F,d1
-
		move.w	(a0)+,(a6)
		dbf	d1,-

		moveq	#0,d0		; clear	d0
		move.b	(v_errortype).w,d0 ; load error code
		move.w	ErrorText(pc,d0.w),d0
		lea	ErrorText(pc,d0.w),a0
		locVRAM	(vram_fg+$604)
		moveq	#$12,d1		; number of characters (minus 1)

-
		moveq	#0,d0
		move.b	(a0)+,d0
		addi.w	#$790,d0
		move.w	d0,(a6)
		dbf	d1,-	; repeat for number of characters
		rts	
; End of function ShowErrorMessage

; ===========================================================================
ErrorText:
	dc.w Txt_Exception-ErrorText
	dc.w Txt_Bus-ErrorText
	dc.w Txt_Address-ErrorText
	dc.w Txt_IllegalInstruction-ErrorText
	dc.w Txt_DivideByZero-ErrorText
	dc.w Txt_ChkInstruction-ErrorText
	dc.w Txt_TrapvInstruction-ErrorText
	dc.w Txt_PrivilegeViolation-ErrorText
	dc.w Txt_Trace-ErrorText
	dc.w Txt_Line1010-ErrorText
	dc.w Txt_Line1111-ErrorText
	
	Txt_Exception:				dc.b "ERROR EXCEPTION    "
	Txt_Bus:					dc.b "BUS ERROR          "
	Txt_Address:				dc.b "ADDRESS ERROR      "
	Txt_IllegalInstruction:		dc.b "ILLEGAL INSTRUCTION"
	Txt_DivideByZero:			dc.b "@ERO DIVIDE        "
	Txt_ChkInstruction:			dc.b "CHK INSTRUCTION    "
	Txt_TrapvInstruction:		dc.b "TRAPV INSTRUCTION  "
	Txt_PrivilegeViolation:		dc.b "PRIVILEGE VIOLATION"
	Txt_Trace:					dc.b "TRACE              "
	Txt_Line1010:				dc.b "LINE 1010 EMULATOR "
	Txt_Line1111:				dc.b "LINE 1111 EMULATOR "
	
	even

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ShowErrorValue:
	move.w	#$7CA,(a6)	; display "$" symbol
	moveq	#7,d2

-
	rol.l	#4,d0
	bsr.s	+	; display 8 numbers
	dbf	d2,-
	rts	
; End of function ShowErrorValue


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


+
	move.w	d0,d1
	andi.w	#$F,d1
	cmpi.w	#$A,d1
	blo.s	+
	addq.w	#7,d1		; add 7 for characters A-F

+
	addi.w	#$7C0,d1
	move.w	d1,(a6)
	rts	
; End of function sub_5CA


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ErrorWaitForC:				; XREF: loc_478
	bsr.w	ReadJoypads
	cmpi.b	#$20,(Ctrl_1_Press).w ; is button C pressed?
	bne.w	ErrorWaitForC	; if not, branch
	rts	
; End of function ErrorWaitForC

; ===========================================================================

Art_Debug_Text:	BINCLUDE "art/uncompressed/Debug text.bin"
	even
