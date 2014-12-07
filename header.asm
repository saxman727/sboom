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



StartOfRom:
    if * <> 0
	fatal "StartOfRom was $\{*} but it should be 0"
    endif
;Vectors:
	
	if BUILD_32X_ROM == 1
		dc.l	System_Stack, MARSInit, MARSInit, MARSInit; 4
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 8
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 12
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 16
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 20
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 24
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 28
		dc.l	H_Int+$880000, MARSInit, V_Int+$880000, MARSInit; 32
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 36
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 40
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 44
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 48
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 52
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 56
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 60
		dc.l	MARSInit, MARSInit, MARSInit, MARSInit; 64
		
	else
		if DEVELOPMENT_MODE == 1
			dc.l	System_Stack, EntryPoint, BusError, AddressError; 4
			dc.l	IllegalInstr, ZeroDivide, ChkInstr, TrapvInstr; 8
			dc.l	PrivilegeViol, Trace, Line1010Emu,	Line1111Emu; 12
			dc.l	ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept; 16
			dc.l	ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept; 20
			dc.l	ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept; 24
			dc.l	ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept; 28
		else
			dc.l	System_Stack, EntryPoint, ErrorTrap, ErrorTrap; 4
			dc.l	ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap; 8
			dc.l	ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap; 12
			dc.l	ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap; 16
			dc.l	ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap; 20
			dc.l	ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap; 24
			dc.l	ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap; 28
		endif
		dc.l	H_Int, ErrorTrap, V_Int, ErrorTrap; 32
		dc.l	ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap; 36
		dc.l	ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap; 40
		dc.l	ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap; 44
		dc.l	ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap; 48
		dc.l	ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap; 52
		dc.l	ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap; 56
		dc.l	ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap; 60
		dc.l	ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap; 64
		
	endif
; byte_200:
Header:
	if BUILD_32X_ROM == 1
		dc.b "SEGA 32X        " ; Console name
	else
		dc.b "SEGA GENESIS    " ; Console name
	endif

	dc.b "(C)SEGA 1992.SEP" ; Copyright/Date

	dc.b "SONIC THE       " ; Domestic name
	dc.b "      HEDGEHOG 2"
	dc.b "                "

	dc.b "SONIC THE       " ; International name
	dc.b "      HEDGEHOG 2"
	dc.b "                "

	dc.b "GM 00001051-03"   ; Version
; word_18E
Checksum:
	dc.w $D951		; Checksum (patched later if incorrect)

	if SUPPORT_ARCADE_PAD == 1
		dc.b "J6              " ; I/O Support
	else
		dc.b "J               " ; I/O Support
	endif

	dc.l StartOfRom		; ROM Start
; dword_1A4
ROMEndLoc:
	dc.l EndOfRom-1		; ROM End
	dc.l $FF0000		; RAM Start
	dc.l $FFFFFF		; RAM End
	dc.b "    "		; Backup RAM ID
	dc.l $20202020		; Backup RAM start address
	dc.l $20202020		; Backup RAM end address
	dc.b "            "	; Modem support
	dc.b "                                        "	; Notes
	dc.b "JUE             " ; Country
EndOfHeader:

	if BUILD_32X_ROM == 1
		jmp		EntryPoint+$880000		;  /* reset = hot start */
		
		if DEVELOPMENT_MODE == 1
			jsr		BusError+$880000		;  /* EX_BusError */
			jsr		AddressError+$880000	;  /* EX_AddrError */
			jsr		IllegalInstr+$880000	;  /* EX_IllInstr */
			jsr		ZeroDivide+$880000		;  /* EX_DivByZero */
			jsr		ChkInstr+$880000		;  /* EX_CHK */
			jsr		TrapvInstr+$880000		;  /* EX_TrapV */
			jsr		PrivilegeViol+$880000	;  /* EX_Priviledge */
			jsr		Trace+$880000			;  /* EX_Trace */
			jsr		Line1010Emu+$880000		;  /* EX_LineA */
			jsr		Line1111Emu+$880000		;  /* EX_LineF */
		else
			jsr		ErrorTrap+$880000		;  /* EX_BusError */
			jsr		ErrorTrap+$880000		;  /* EX_AddrError */
			jsr		ErrorTrap+$880000		;  /* EX_IllInstr */
			jsr		ErrorTrap+$880000		;  /* EX_DivByZero */
			jsr		ErrorTrap+$880000		;  /* EX_CHK */
			jsr		ErrorTrap+$880000		;  /* EX_TrapV */
			jsr		ErrorTrap+$880000		;  /* EX_Priviledge */
			jsr		ErrorTrap+$880000		;  /* EX_Trace */
			jsr		ErrorTrap+$880000		;  /* EX_LineA */
			jsr		ErrorTrap+$880000		;  /* EX_LineF */
		endif
		
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		jsr		ErrorTrap+$880000		;  /* EX_Spurious */
		jsr		ErrorTrap+$880000		;  /* EX_Level1 */
		jsr		ErrorTrap+$880000		;  /* EX_Level2 */
		jsr		ErrorTrap+$880000		;  /* EX_Level3 */
		jmp		H_Int+$880000			;  /* EX_Level4 */
		jsr		ErrorTrap+$880000		;  /* EX_Level5 */
		jmp		V_Int+$880000			;  /* EX_Level6 */
		jsr		ErrorTrap+$880000		;  /* EX_Level7 */
		jsr		ErrorTrap+$880000		;  /* EX_Trap0 */
		jsr		ErrorTrap+$880000		;  /* EX_Trap1 */
		jsr		ErrorTrap+$880000		;  /* EX_Trap2 */
		jsr		ErrorTrap+$880000		;  /* EX_Trap3 */
		jsr		ErrorTrap+$880000		;  /* EX_Trap4 */
		jsr		ErrorTrap+$880000		;  /* EX_Trap5 */
		jsr		ErrorTrap+$880000		;  /* EX_Trap6 */
		jsr		ErrorTrap+$880000		;  /* EX_Trap7 */
		jsr		ErrorTrap+$880000		;  /* EX_Trap8 */
		jsr		ErrorTrap+$880000		;  /* EX_Trap9 */
		jsr		ErrorTrap+$880000		;  /* EX_TrapA */
		jsr		ErrorTrap+$880000		;  /* EX_TrapB */
		jsr		ErrorTrap+$880000		;  /* EX_TrapC */
		jsr		ErrorTrap+$880000		;  /* EX_TrapD */
		jsr		ErrorTrap+$880000		;  /* EX_TrapE */
		jsr		ErrorTrap+$880000		;  /* EX_TrapF */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0,0,0			;  /* reserved */
		dc.b	0,0,0,0,0,0				;  /* reserved */

MARSInitHeader:
		dc.b	"MARS CHECK MODE "				; module name
		dc.l	$00000000						; version

		dc.l	MasterVBR						; source address (ROM)
		dc.l	$00000000						; destination address (SDRAM)
		dc.l	(EndOf32XCode-MasterVBR)		; size

		dc.l	(Master-MasterVBR)+$06000000	; SH2 (Master) start address
		dc.l	(Slave-MasterVBR)+$06000000		; SH2 (Slave) start address

		dc.l	(MasterVBR-MasterVBR)+$06000000	; SH2 (Master) vector base address
		dc.l	(SlaveVBR-MasterVBR)+$06000000	; SH2 (Slave) vector base address

MARSInit:
		BINCLUDE "32x/marsboot.bin"

EntryPoint32X:
		bra.w		EntryPoint

	endif



	align 4		; This is so the VBR tables line up correctly

SonicBoomHeader:
	dc.b "SONIC BOOM v1.00"
	dc.b "sonicsphere.net "
			
	if DEVELOPMENT_MODE == 0

		if USE_STARTUP_SCREEN == 1

SonicBoomJumpTable:
			; The location of these branches is hardcoded and cannot be changed!
			
			if BUILD_32X_ROM == 1
			
				; Vector table ($100)
				; + Game description ($100)
				; + 32X tables ($200)
				; + Mars security ($404)
				; + Sonic Boom header ($20)
				org $000824
				
			else
			
				; Vector table ($100)
				; + Game description ($100)
				; + Sonic Boom header ($20)
				org $000220
				
			endif
			
			bra.w	VDPSetupGame	;0
			bra.w	PlayMusic		;4
			bra.w	Pal_FadeFrom	;8
			bra.w	DelayProgram	;12
			bra.w	NemDec			;16
			bra.w	ReadJoypads		;20
			
			;;; all DC.Ls are done
			;;; all JMPs are done
			;;; all JSRs are done
			;;; all LEAs are done
			;;; all MOVE.L #s are done
			;;; all ADDI.L #s are done
			;;; all SUBI.L #s are done
			
			;;; Exceptions:
			
			;dc.l $FF<<24|(ROM_Bank_1+ArtUnc_MenuBack)
			;dc.l $FF<<24|ArtUnc_MenuBack
			
			;dc.l (unk1&$FF)<<24|(ROM_Bank_1+mapaddr)
			;dc.l (unk1&$FF)<<24|mapaddr

		endif
		
	endif



	if BUILD_32X_ROM == 1
	align 4
MasterVBR:
		dc.l	(Master-MasterVBR)+$06000000
		dc.l	$0603FF00
		dc.l	(Master-MasterVBR)+$06000000
		dc.l	$0603FF00
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	$00000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	$20100400
		dc.l	$20100420
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000
		dc.l	(Interrupt-MasterVBR)+$06000000
		dc.l	(Interrupt-MasterVBR)+$06000000
		dc.l	(DummyExceptionMaster-MasterVBR)+$06000000

SlaveVBR:
		dc.l	(Slave-MasterVBR)+$06000000
		dc.l	$06040000
		dc.l	(Slave-MasterVBR)+$06000000
		dc.l	$06040000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	$00000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	$20100400
		dc.l	$20100420
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0,0,0,0,0
		dc.b	0,0,0,0
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000
		dc.l	(DummyExceptionSlave-MasterVBR)+$06000000

StartOf32XCode:

Master:
		BINCLUDE	"sh2master.bin"
		align 4

Slave:
		BINCLUDE	"sh2slave.bin"
		align 4

Interrupt:
DummyExceptionMaster:
DummyExceptionSlave:
		dc.w	$002B		; rte
		dc.w	$0009		; nop
		align 4

EndOf32XCode:

	endif
