; ###########################################################################
;  SONIC BOOM ENGINE v1.00
;  A Sonic 2 modification by Saxman
;  December 3, 2014
; ###########################################################################
; 
; Original Sonic the Hedgehog 2 disassembly:
; >> Nemesis,   2004: Created original disassembly for SNASM68K
; >> Aurochs,   2005: Translated to AS and annotated
; >> Xenowhirl, 2007: More annotation, overall cleanup, Z80 disassembly
; ---------------------------------------------------------------------------
; NOTES:
;
; Set your editor's tab width to 4 characters wide for viewing this file.
;
; It is highly suggested that you read the AS User's Manual before diving too
; far into this disassembly. At least read the section on nameless temporary
; symbols. Your brain may melt if you don't know how those work.
;
; See notes.txt for more comments about this disassembly and other useful info.



	padding off	; we don't want AS padding out dc.b instructions
	listing off	; we don't need to generate anything for a listing file
	supmode on	; we don't need warnings about privileged instructions


paddingSoFar set 0

; 128 = 80h = z80, 32988 = 80DCh = z80unDoC 
notZ80 function cpu,(cpu<>128)&&(cpu<>32988)

; make org safer (impossible to overwrite previously assembled bytes) and count padding
; and also make it work in Z80 code without creating a new segment
org macro address
	if notZ80(MOMCPU)
		if address < *
			if assembleZ80SoundDriver
				error "too much stuff before org $\{address} ($\{(*-address)} bytes)"
			else
				error "too much stuff before org $\{address} ($\{(*-address)} bytes) ... try setting assembleZ80SoundDriver=1 in the asm file"
			endif
		elseif address > *
paddingSoFar	set paddingSoFar + address - *
			!org address
		endif
	else
		if address < $
			error "too much stuff before org 0\{address}h (0\{($-address)}h bytes)"
		else
			while address > $
				db 0
			endm
		endif
	endif
    endm

; define the cnop pseudo-instruction
cnop macro offset,alignment
	if notZ80(MOMCPU)
		org (*-1+(alignment)-((*-1+(-(offset)))#(alignment)))
	else
		org ($-1+(alignment)-(($-1+(-(offset)))#(alignment)))
	endif
    endm

; redefine align in terms of cnop, for the padding counter
align macro alignment
		cnop 0,alignment
	endm

; define the even pseudo-instruction
even macro
	if notZ80(MOMCPU)
		if (*)&1
paddingSoFar		set paddingSoFar+1
			dc.b 0 ;ds.b 1 
		endif
	else
		if ($)&1
			db 0
		endif
	endif
    endm

; make ds work in Z80 code without creating a new segment
ds macro
	if notZ80(MOMCPU)
		!ds.ATTRIBUTE ALLARGS
	else
		rept ALLARGS
			db 0
		endm
	endif
   endm

  if TRUE
; define a trace macro
; lets you easily check what address a location in this disassembly assembles to
; if used in Z80 code, the displayed PC will be relative to the start of Z80 RAM
trace macro optionalMessageWithoutQuotes
    if MOMPASS=1
	if notZ80(MOMCPU)
		if ("ALLARGS"<>"")
			message "#\{tracenum/1.0}: line=\{MOMLINE/1.0} PC=$\{*} msg=ALLARGS"
		else
			message "#\{tracenum/1.0}: line=\{MOMLINE/1.0} PC=$\{*}"
		endif
	else
		if ("ALLARGS"<>"")
			message "#\{tracenum/1.0}: line=\{MOMLINE/1.0} PC=\{$}h msg=ALLARGS"
		else
			message "#\{tracenum/1.0}: line=\{MOMLINE/1.0} PC=\{$}h"
		endif
	endif
tracenum := (tracenum+1)
    endif
   endm
  else
trace macro
	endm
  endif
tracenum := 0

    if zeroOffsetOptimization=0
    ; disable a space optimization in AS so we can build a bit-perfect rom
    ; (the hard way, but it requires no modification of AS itself)

; 1-arg instruction that's self-patching to remove 0-offset optimization
insn1op	 macro oper,x
	  if substr("x",0,2)<>"0("
		!oper	x
	  else
		!oper	1+x
		!org	*-1
		!dc.b	0
	  endif
	 endm

; 2-arg instruction that's self-patching to remove 0-offset optimization
insn2op	 macro oper,x,y
	  if substr("x",0,2)<>"0("
		  if substr("y",0,2)<>"0("
			!oper	x,y
		  else
			!oper	x,1+y
			!org	*-1
			!dc.b	0
		  endif
	  else
		if substr("y",0,1)<>"D"
		  if substr("y",0,2)<>"0("
			!oper	1+x,y
			!org	*-3
			!dc.b	0
			!org	*+2
		  else
			!oper	1+x,1+y
			!org	*-3
			!dc.b	0
			!org	*+1
			!dc.b	0
		  endif
		else
			!oper	1+x,y
			!org	*-1
			!dc.b	0
		endif
	  endif
	 endm

	; instructions that were used with 0(a#) syntax
	; defined to assemble as they originally did
_move	macro
		insn2op move.ATTRIBUTE, ALLARGS
	endm
_add	macro
		insn2op add.ATTRIBUTE, ALLARGS
	endm
_addq	macro
		insn2op addq.ATTRIBUTE, ALLARGS
	endm
_cmp	macro
		insn2op cmp.ATTRIBUTE, ALLARGS
	endm
_cmpi	macro
		insn2op cmpi.ATTRIBUTE, ALLARGS
	endm
_clr	macro
		insn1op clr.ATTRIBUTE, ALLARGS
	endm
_tst	macro
		insn1op tst.ATTRIBUTE, ALLARGS
	endm

	else

	; regular meaning to the assembler; better but unlike original
_move	macro
		!move.ATTRIBUTE ALLARGS
	endm
_add	macro
		!add.ATTRIBUTE ALLARGS
	endm
_addq	macro
		!addq.ATTRIBUTE ALLARGS
	endm
_cmp	macro
		!cmp.ATTRIBUTE ALLARGS
	endm
_cmpi	macro
		!cmpi.ATTRIBUTE ALLARGS
	endm
_clr	macro
		!clr.ATTRIBUTE ALLARGS
	endm
_tst	macro
		!tst.ATTRIBUTE ALLARGS
	endm

    endif
; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; simplifying macros

; tells the VDP to copy a region of 68k memory to VRAM or CRAM or VSRAM
dma68kToVDP macro source,dest,length,type
	lea	(VDP_control_port).l,a5
	move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a5)
	move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a5)
	move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),(a5)
	move.w	#((dest)&$3FFF)|((type&1)<<15)|$4000,(a5)
	move.w	#$80|(((dest)&$C000)>>14)|((type&2)<<3),(DMA_data_thunk).w
	move.w	(DMA_data_thunk).w,(a5)
    endm
    ; values for the type argument
    enum VRAM=0,CRAM=1,VSRAM=2

; tells the VDP to fill a region of VRAM with a certain byte
dmaFillVRAM macro byte,addr,length
	lea	(VDP_control_port).l,a5
	move.w	#$8F01,(a5) ; VRAM pointer increment: $0001
	move.l	#(($9400|((((length)-1)&$FF00)>>8))<<16)|($9300|(((length)-1)&$FF)),(a5) ; DMA length ...
	move.w	#$9780,(a5) ; VRAM fill
	move.l	#$40000080|(((addr)&$3FFF)<<16)|(((addr)&$C000)>>14),(a5) ; Start at ...
	move.w	#(byte)<<8,(VDP_data_port).l ; Fill with byte
-	move.w	(a5),d1
	btst	#1,d1
	bne.s	- ; busy loop until the VDP is finished filling...
	move.w	#$8F02,(a5) ; VRAM pointer increment: $0002
    endm

; calculates initial loop counter value for a dbf loop
; that writes n bytes total at 4 bytes per iteration
bytesToLcnt function n,n>>2-1

; fills a region of 68k RAM with 0 (4 bytes at a time)
clearRAM macro addr,length
    if length&3
	fatal "clearRAM len must be divisible by 4, but was length"
    endif
	lea	(addr).w,a1
	moveq	#0,d0
	move.w	#bytesToLcnt(length),d1
-	move.l	d0,(a1)+
	dbf	d1,-
    endm

; tells the Z80 to stop, and waits for it to finish stopping (acquire bus)
stopZ80 macro
	move.w	#$100,(Z80_Bus_Request).l ; stop the Z80
-	btst	#0,(Z80_Bus_Request).l
	bne.s	- ; loop until it says it's stopped
    endm

; tells the Z80 to start again
startZ80 macro
	move.w	#0,(Z80_Bus_Request).l    ; start the Z80
    endm

; function to make a little-endian 16-bit pointer for the Z80 sound driver
z80_ptr function x,(x)<<8&$FF00|(x)>>8&$7F|$80

; macro to declare a little-endian 16-bit pointer for the Z80 sound driver
rom_ptr_z80 macro addr
		dc.w z80_ptr(addr)
	endm



; ---------------------------------------------------------------------------
; Set a VRAM address via the VDP control port.
; input: 16-bit VRAM address, control port (default is ($C00004).l)
; ---------------------------------------------------------------------------

locVRAM macro loc
		move.l	#($40000000+((loc&$3FFF)<<16)+((loc&$C000)>>14)),(vdp_control_port).l
		endm
		
;locVRAM macro loc,controlport
;		move.l	#($40000000+((loc&$3FFF)<<16)+((loc&$C000)>>14)),controlport
;		endm

; ---------------------------------------------------------------------------
; DMA copy data from 68K (ROM/RAM) to the VRAM
; input: source, length, destination
; ---------------------------------------------------------------------------

writeVRAM macro
		lea	(vdp_control_port).l,a5
		move.l	#$94000000+(((\2>>1)&$FF00)<<8)+$9300+((\2>>1)&$FF),(a5)
		move.l	#$96000000+(((\1>>1)&$FF00)<<8)+$9500+((\1>>1)&$FF),(a5)
		move.w	#$9700+((((\1>>1)&$FF0000)>>16)&$7F),(a5)
		move.w	#$4000+(\3&$3FFF),(a5)
		move.w	#$80+((\3&$C000)>>14),(v_vdp_buffer2).w
		move.w	(v_vdp_buffer2).w,(a5)
		endm

; ---------------------------------------------------------------------------
; DMA copy data from 68K (ROM/RAM) to the CRAM
; input: source, length, destination
; ---------------------------------------------------------------------------

writeCRAM macro
		lea	(vdp_control_port).l,a5
		move.l	#$94000000+(((\2>>1)&$FF00)<<8)+$9300+((\2>>1)&$FF),(a5)
		move.l	#$96000000+(((\1>>1)&$FF00)<<8)+$9500+((\1>>1)&$FF),(a5)
		move.w	#$9700+((((\1>>1)&$FF0000)>>16)&$7F),(a5)
		move.w	#$C000+(\3&$3FFF),(a5)
		move.w	#$80+((\3&$C000)>>14),(v_vdp_buffer2).w
		move.w	(v_vdp_buffer2).w,(a5)
		endm

; ---------------------------------------------------------------------------
; DMA fill VRAM with a value
; input: value, length, destination
; ---------------------------------------------------------------------------

fillVRAM macro value,length,loc
		lea	(vdp_control_port).l,a5
		move.w	#$8F01,(a5)
		move.l	#$94000000+((length&$FF00)<<8)+$9300+(length&$FF),(a5)
		move.w	#$9780,(a5)
		move.l	#$40000080+((loc&$3FFF)<<16)+((loc&$C000)>>14),(a5)
		move.w	#value,(vdp_data_port).l
		endm

; ---------------------------------------------------------------------------
; Copy a tilemap from 68K (ROM/RAM) to the VRAM without using DMA
; input: source, destination, width [cells], height [cells]
; ---------------------------------------------------------------------------

copyTilemap macro source,loc,width,height
		lea	(source).l,a1
		move.l	#$40000000+((loc&$3FFF)<<16)+((loc&$C000)>>14),d0
		moveq	#width,d1
		moveq	#height,d2
		bsr.w	TilemapToVRAM
		endm

; ---------------------------------------------------------------------------
; wait for Z80 to stop
; ---------------------------------------------------------------------------

waitZ80 macro
	@wait:	btst	#0,(z80_bus_request).l
		bne.s	@wait
		endm

; ---------------------------------------------------------------------------
; reset the Z80
; ---------------------------------------------------------------------------

resetZ80 macro
		move.w	#$100,(z80_reset).l
		endm

resetZ80a macro
		move.w	#0,(z80_reset).l
		endm

; ---------------------------------------------------------------------------
; disable interrupts
; ---------------------------------------------------------------------------

disable_ints macro
		move	#$2700,sr
		endm

; ---------------------------------------------------------------------------
; enable interrupts
; ---------------------------------------------------------------------------

enable_ints macro
		move	#$2300,sr
		endm

; ---------------------------------------------------------------------------
; long conditional jumps
; ---------------------------------------------------------------------------

jhi:		macro loc
		bls.s	@nojump
		jmp	loc
	@nojump:
		endm

jcc:		macro loc
		bcs.s	@nojump
		jmp	loc
	@nojump:
		endm

jhs:		macro loc
		jcc	loc
		endm

jls:		macro loc
		bhi.s	@nojump
		jmp	loc
	@nojump:
		endm

jcs:		macro loc
		bcc.s	@nojump
		jmp	loc
	@nojump:
		endm

jlo:		macro loc
		jcs	loc
		endm

jeq:		macro loc
		bne.s	@nojump
		jmp	loc
	@nojump:
		endm

jne:		macro loc
		beq.s	@nojump
		jmp	loc
	@nojump:
		endm

jgt:		macro loc
		ble.s	@nojump
		jmp	loc
	@nojump:
		endm

jge:		macro loc
		blt.s	@nojump
		jmp	loc
	@nojump:
		endm

jle:		macro loc
		bgt.s	@nojump
		jmp	loc
	@nojump:
		endm

jlt:		macro loc
		bge.s	@nojump
		jmp	loc
	@nojump:
		endm

jpl:		macro loc
		bmi.s	@nojump
		jmp	loc
	@nojump:
		endm

jmi:		macro loc
		bpl.s	@nojump
		jmp	loc
	@nojump:
		endm

; ---------------------------------------------------------------------------
; check if object moves out of range
; input: location to jump to if out of range, x-axis pos (obX(a0) by default)
; ---------------------------------------------------------------------------

out_of_range:	macro exit
		move.w	obX(a0),d0	; get object position
		andi.w	#$FF80,d0	; round down to nearest $80
		move.w	(v_screenposx).w,d1 ; get screen position
		subi.w	#128,d1
		andi.w	#$FF80,d1
		sub.w	d1,d0		; approx distance between object and screen
		cmpi.w	#128+320+192,d0
		bhi.\0	exit
		endm
		
;out_of_range:	macro exit,pos
;		move.w	pos,d0		; get object position (if specified as not obX)
;		andi.w	#$FF80,d0	; round down to nearest $80
;		move.w	(v_screenposx).w,d1 ; get screen position
;		subi.w	#128,d1
;		andi.w	#$FF80,d1
;		sub.w	d1,d0		; approx distance between object and screen
;		cmpi.w	#128+320+192,d0
;		bhi.\0	exit
;		endm

; ---------------------------------------------------------------------------
; play a sound effect or music
; input: track, terminate routine (leave blank to not terminate)
; ---------------------------------------------------------------------------

music:		macro track
		move.w	#track,d0
		jsr	(PlaySound).l
		endm
		
;music:		macro track,terminate
;		move.w	#track,d0
;		jmp	(PlaySound).l
;		endm

sfx:		macro track
		move.w	#track,d0
		jsr	(PlaySound_Special).l
		endm
		
;sfx:		macro track,terminate
;		move.w	#track,d0
;		jmp	(PlaySound_Special).l
;		endm

; ---------------------------------------------------------------------------
; bankswitch between SRAM and ROM
; (remember to enable SRAM in the header first!)
; ---------------------------------------------------------------------------

gotoSRAM:	macro
		move.b  #1,($A130F1).l
		endm

gotoROM:	macro
		move.b  #0,($A130F1).l
		endm

; ---------------------------------------------------------------------------
; compare the size of an index with ZoneCount constant
; (should be used immediately after the index)
; input: index address, element size
; ---------------------------------------------------------------------------

zonewarning:	macro loc,elementsize
	@end:
		if (@end-loc)-(ZoneCount*elementsize)<>0
		inform 1,"Size of \loc ($%h) does not match ZoneCount ($\#ZoneCount).",(@end-loc)/elementsize
		endc
		endm