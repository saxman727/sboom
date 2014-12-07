; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Equates section - Names for variables.
; ---------------------------------------------------------------------------
; size variables - you'll get an informational error if you need to change these...
; they are all in units of bytes
Size_of_DAC_samples =		$2F00
Size_of_SEGA_sound =		$6174
Size_of_Snd_driver_guess =	$F64 ; approximate post-compressed size of the Z80 sound driver

; ---------------------------------------------------------------------------
; Sonic Boom constants -- added by Saxman
; ---------------------------------------------------------------------------

; Build options

DEVELOPMENT_MODE = 1			; For aiding testers. Enable to go straight to the level select and enable all major cheats at startup.
MINOR_OBJECT_OPTIMIZATIONS = 1	; Enable to improve CPU performance in certain stages.
BUILD_32X_ROM = 0				; Enable to build a 32X ROM instead of a Genesis ROM.


; General engine options

USE_NEW_LEVEL_FORMAT = 1				; Disable to use original Sonic 2 level format
USE_SK_OBJECT_LAYOUT = 1				; Disable to use original Sonic 2 object layout instead of S&K layout
RESTORE_RINGS_AFTER_SPECIAL_STAGE = 1	; Disable to use original Sonic 2 starpost behavior where the ring count is cleared
INCLUDE_SAXMAN_CHEAT = 1				; Disable to exclude the Saxman cheat (01,09,08,04,00,07,02,07,...,00)
USE_STARTUP_SCREEN = 1					; Disable to exclude the Sonic Boom startup screen (excluded when DEVELOPMENT_MODE is 1)
SUPPORT_ARCADE_PAD = 1					; Disable to drop support for extra buttons on 6-button controller


; Compatability options

COMPATABILITY_DEMO_START = 1		; Enable to have Tails start behind Sonic in 2P demos
COMPATABILITY_DEMO_SPEED_CAP = 1	; Enable to impose in-air speed cap in demos
COMPATABILITY_DEMO_OBJECTS = 1		; Enable to load original game's ARZ1 object layout during demos (not necessary if USE_SK_OBJECT_LAYOUT is 0)


; Zone ID values to make code a bit more readable, and to allow zones to be
; swapped more easily.

ZONE_ID_EHZ = 0
ZONE_ID_CPZ = 1
ZONE_ID_ARZ = 2
ZONE_ID_CNZ = 3
ZONE_ID_HTZ = 4
ZONE_ID_MCZ = 5
ZONE_ID_OOZ = 6
ZONE_ID_MTZ = 7
ZONE_ID_MTZ3 = 8
ZONE_ID_SCZ = 9
ZONE_ID_WFZ = 10
ZONE_ID_DEZ = 11

ZONE_ID_EHZ_1 = $0
ZONE_ID_EHZ_2 = $1
ZONE_ID_CPZ_1 = $100
ZONE_ID_CPZ_2 = $101
ZONE_ID_ARZ_1 = $200
ZONE_ID_ARZ_2 = $201
ZONE_ID_CNZ_1 = $300
ZONE_ID_CNZ_2 = $301
ZONE_ID_HTZ_1 = $400
ZONE_ID_HTZ_2 = $401
ZONE_ID_MCZ_1 = $500
ZONE_ID_MCZ_2 = $501
ZONE_ID_OOZ_1 = $600
ZONE_ID_OOZ_2 = $601
ZONE_ID_MTZ_1 = $700
ZONE_ID_MTZ_2 = $701
ZONE_ID_MTZ3_1 = $800
ZONE_ID_MTZ3_2 = $801
ZONE_ID_SCZ_1 = $900
ZONE_ID_SCZ_2 = $901
ZONE_ID_WFZ_1 = $A00
ZONE_ID_WFZ_2 = $A01
ZONE_ID_DEZ_1 = $B00
ZONE_ID_DEZ_2 = $B01

STARTING_LEVEL = ZONE_ID_EHZ_1


; PLC (pattern load cue) ID values to allow entries in the PLC list to be
; moved around more easily. If you shift the list in any way, be sure you
; update these constants to keep everything in the game working as it should.

PLC_COMMON_A = 0
PLC_COMMON_B = 1
PLC_COMMON_WATER = 2
PLC_COMMON_WATER_SURFACE_A = 3
PLC_COMMON_WATER_SURFACE_B = 4
PLC_GAME_AND_TIME_OVER = 5
PLC_MILES_LIVES_2P = 6
PLC_MILES_LIVES = 7
PLC_TAILS_LIVES_2P = 8
PLC_TAILS_LIVES = 9
PLC_SONIC_RESULTS = 10
PLC_SIGNPOST = 11
PLC_CPZ_BOSS = 12
PLC_EHZ_BOSS = 13
PLC_HTZ_BOSS = 14
PLC_ARZ_BOSS = 15
PLC_MCZ_BOSS = 16
PLC_CNZ_BOSS = 17
PLC_MTZ_BOSS = 18
PLC_OOZ_BOSS = 19
PLC_FIERY_EXPLOSION = 20
PLC_DEZ_BOSS = 21
PLC_SPECIAL_STAGE = 22
PLC_SPECIAL_STAGE_BOMB = 23
PLC_WFZ_BOSS = 24
PLC_TORNADO = 25
PLC_EGG_PRISON = 26
PLC_EXPLOSION = 27
PLC_TAILS_RESULTS = 28

PLC_KNUCKLES_COMMON = 29
PLC_KNUCKLES_RESULTS = 30
PLC_KNUCKLES_SIGNPOST = 31


; Player constants

SONIC_SPINDASH_BASE_RATE = $800
SONIC_JUMP_RATE = $680
SONIC_MAX_SPEED = $600
SONIC_ACCELERATION_RATE = $C
SONIC_DECELERATION_RATE = $80
SONIC_SNEAKERS_MAX_SPEED = $C00
SONIC_SNEAKERS_ACCELERATION_RATE = $18
SONIC_SNEAKERS_DECELERATION_RATE = $80
SONIC_UNDERWATER_JUMP_RATE = $380
SONIC_UNDERWATER_MAX_SPEED = $300
SONIC_UNDERWATER_ACCELERATION_RATE = $6
SONIC_UNDERWATER_DECELERATION_RATE = $40
SONIC_UNDERWATER_SNEAKERS_MAX_SPEED = $600
SONIC_UNDERWATER_SNEAKERS_ACCELERATION_RATE = $C
SONIC_UNDERWATER_SNEAKERS_DECELERATION_RATE = $40
SONIC_RUNNING_SPEED = $600
SONIC_ROLLING_FAST_SPEED = $600

SUPER_SONIC_SPINDASH_BASE_RATE = $B00
SUPER_SONIC_JUMP_RATE = $800
SUPER_SONIC_MAX_SPEED = $A00
SUPER_SONIC_ACCELERATION_RATE = $30
SUPER_SONIC_DECELERATION_RATE = $100
SUPER_SONIC_UNDERWATER_JUMP_RATE = $450		; Original Sonic 2 uses $380
SUPER_SONIC_UNDERWATER_MAX_SPEED = $500
SUPER_SONIC_UNDERWATER_ACCELERATION_RATE = $18
SUPER_SONIC_UNDERWATER_DECELERATION_RATE = $80
SUPER_SONIC_RUNNING_SPEED = $800

TAILS_SPINDASH_BASE_RATE = $800
TAILS_JUMP_RATE = $680
TAILS_MAX_SPEED = $600
TAILS_ACCELERATION_RATE = $C
TAILS_DECELERATION_RATE = $80
TAILS_SNEAKERS_MAX_SPEED = $C00
TAILS_SNEAKERS_ACCELERATION_RATE = $18
TAILS_SNEAKERS_DECELERATION_RATE = $80
TAILS_UNDERWATER_JUMP_RATE = $380
TAILS_UNDERWATER_MAX_SPEED = $300
TAILS_UNDERWATER_ACCELERATION_RATE = $6
TAILS_UNDERWATER_DECELERATION_RATE = $40
TAILS_UNDERWATER_SNEAKERS_MAX_SPEED = $600
TAILS_UNDERWATER_SNEAKERS_ACCELERATION_RATE = $C
TAILS_UNDERWATER_SNEAKERS_DECELERATION_RATE = $40
TAILS_RUNNING_SPEED = $600
TAILS_RUNNING_FAST_SPEED = $700
TAILS_ROLLING_FAST_SPEED = $600

KNUCKLES_SPINDASH_BASE_RATE = $800
KNUCKLES_JUMP_RATE = $600
KNUCKLES_MAX_SPEED = $600
KNUCKLES_ACCELERATION_RATE = $C
KNUCKLES_DECELERATION_RATE = $80
KNUCKLES_SNEAKERS_MAX_SPEED = $C00
KNUCKLES_SNEAKERS_ACCELERATION_RATE = $18
KNUCKLES_SNEAKERS_DECELERATION_RATE = $80
KNUCKLES_UNDERWATER_JUMP_RATE = $300
KNUCKLES_UNDERWATER_MAX_SPEED = $300
KNUCKLES_UNDERWATER_ACCELERATION_RATE = $6
KNUCKLES_UNDERWATER_DECELERATION_RATE = $40
KNUCKLES_UNDERWATER_SNEAKERS_MAX_SPEED = $600
KNUCKLES_UNDERWATER_SNEAKERS_ACCELERATION_RATE = $C
KNUCKLES_UNDERWATER_SNEAKERS_DECELERATION_RATE = $40
KNUCKLES_RUNNING_SPEED = $600
KNUCKLES_ROLLING_FAST_SPEED = $600

SUPER_KNUCKLES_SPINDASH_BASE_RATE = $B00
SUPER_KNUCKLES_JUMP_RATE = $600
SUPER_KNUCKLES_MAX_SPEED = $800
SUPER_KNUCKLES_ACCELERATION_RATE = $18
SUPER_KNUCKLES_DECELERATION_RATE = $C0
SUPER_KNUCKLES_UNDERWATER_JUMP_RATE = $300
SUPER_KNUCKLES_UNDERWATER_MAX_SPEED = $400
SUPER_KNUCKLES_UNDERWATER_ACCELERATION_RATE = $C
SUPER_KNUCKLES_UNDERWATER_DECELERATION_RATE = $60
SUPER_KNUCKLES_RUNNING_SPEED = $800


; Misc constants

GRAVITY = $38
OBJECT_X_SCOPE = $280	; Must be a multiple of $80!
						; $200 will reduce slow-downs, but certain objects won't load when they ideally should
OBJECT_Y_SCOPE = $180	; Must be a multiple of $80!

; ---------------------------------------------------------------------------
; Object Status Table offsets (for everything between Object_RAM and Primary_Collision)
; ---------------------------------------------------------------------------
; universally followed object conventions:
render_flags =	  1 ; bitfield ; bit 7 = onscreen flag, bit 0 = x mirror, bit 1 = y mirror, bit 2 = coordinate system
art_tile =		  2 ; and 3 ; start of sprite's art
mappings =		  4 ; and 5 and 6 and 7
x_pos =			  8 ; and 9 ... some objects use $A and $B as well when extra precision is required (see ObjectMove) ... for screen-space objects this is called x_pixel instead
y_pos =			 $C ; and $D ... some objects use $E and $F as well when extra precision is required ... screen-space objects use y_pixel instead
priority =		$18 ; 0 = front
width_pixels =	$19
mapping_frame =	$1A
; ---------------------------------------------------------------------------
; conventions followed by most objects:
x_vel =			$10 ; and $11 ; horizontal velocity
y_vel =			$12 ; and $13 ; vertical velocity
y_radius =		$16 ; collision width / 2
x_radius =		$17 ; collision height / 2
anim_frame =	$1B
anim =			$1C
next_anim =		$1D
anim_frame_duration =	$1E
status =		$22 ; note: exact meaning depends on the object... for sonic/tails: bit 0: leftfacing. bit 1: inair. bit 2: spinning. bit 3: onobject. bit 4: rolljumping. bit 5: pushing. bit 6: underwater.
routine =		$24
routine_secondary =	$25
angle =			$26 ; angle about the z=0 axis (360 degrees = 256)
; ---------------------------------------------------------------------------
; conventions followed by many objects but NOT sonic/tails:
collision_flags =	$20
collision_property =	$21
respawn_index =	$23
subtype =		$28
; ---------------------------------------------------------------------------
; conventions specific to sonic/tails (Obj01, Obj02, and ObjDB):
; note: $1F, $20, and $21 are unused and available
inertia =		$14 ; and $15 ; directionless representation of speed... not updated in the air
flip_angle =	$27 ; angle about the x=0 axis (360 degrees = 256) (twist/tumble)
air_left =		$28
flip_turned =	$29 ; 0 for normal, 1 to invert flipping (it's a 180 degree rotation about the axis of Sonic's spine, so he stays in the same position but looks turned around)
obj_control =	$2A ; 0 for normal, 1 for hanging or for resting on a flipper, $81 for going through CNZ/OOZ/MTZ tubes or stopped in CNZ cages or stoppers or flying if Tails
status_secondary =	$2B
flips_remaining =	$2C ; number of flip revolutions remaining
flip_speed =	$2D ; number of flip revolutions per frame / 256
move_lock =		$2E ; and $2F ; horizontal control lock, counts down to 0
invulnerable_time =	$30 ; and $31 ; time remaining until you stop blinking
invincibility_time =	$32 ; and $33 ; remaining
speedshoes_time =	$34 ; and $35 ; remaining
next_tilt =		$36 ; angle on ground in front of sprite
tilt =			$37 ; angle on ground
stick_to_convex =	$38 ; 0 for normal, 1 to make Sonic stick to convex surfaces like the rotating discs in Sonic 1 and 3 (unused in Sonic 2 but fully functional)
spindash_flag =	$39 ; 0 for normal, 1 for charging a spindash or forced rolling
spindash_counter =	$3A ; and $3B
jumping =		$3C
interact =		$3D ; RAM address of the last object Sonic stood on, minus $FFFFB000 and divided by $40
layer =			$3E ; collision plane, track switching...
layer_plus =	$3F ; always same as layer+1 ?? used for collision somehow
; ---------------------------------------------------------------------------
; conventions followed by several objects but NOT sonic/tails:
y_pixel =		2+x_pos ; and 3+x_pos ; y coordinate for objects using screen-space coordinate system
x_pixel =		x_pos ; and 1+x_pos ; x coordinate for objects using screen-space coordinate system
parent =		$3E ; and $3F ; address of object that owns or spawned this one, if applicable
; ---------------------------------------------------------------------------
; unknown or inconsistently used offsets that are not applicable to sonic/tails:
; (provided because rearrangement of the above values sometimes requires making space in here too)
objoff_A =		2+x_pos ; note: x_pos can be 4 bytes, but sometimes the last 2 bytes of x_pos are used for other unrelated things
objoff_B =		3+x_pos
objoff_E =		2+y_pos
objoff_F =		3+y_pos
objoff_14 =		$14
objoff_15 =		$15
objoff_1F =		$1F
objoff_27 =		$27
objoff_28 =		$28 ; overlaps subtype, but a few objects use it for other things anyway
 enum               objoff_29=$29,objoff_2A=$2A,objoff_2B=$2B,objoff_2C=$2C,objoff_2D=$2D,objoff_2E=$2E,objoff_2F=$2F
 enum objoff_30=$30,objoff_31=$31,objoff_32=$32,objoff_33=$33,objoff_34=$34,objoff_35=$35,objoff_36=$36,objoff_37=$37
 enum objoff_38=$38,objoff_39=$39,objoff_3A=$3A,objoff_3B=$3B,objoff_3C=$3C,objoff_3D=$3D,objoff_3E=$3E,objoff_3F=$3F
; ---------------------------------------------------------------------------
; property of all objects:
next_object =		$40 ; the size of an object

; ---------------------------------------------------------------------------
; I run the main 68k RAM addresses through this function
; to let them work in both 16-bit and 32-bit addressing modes.
ramaddr function x,-(-x)&$FFFFFFFF

; ---------------------------------------------------------------------------
; Sonic Boom Startup Screen
; These addresses are hardcoded and cannot be changed!

	if BUILD_32X_ROM == 1

SBSC_VDPSetupGame =		$000824
SBSC_PlayMusic =		$000824+4
SBSC_Pal_FadeFrom =		$000824+8
SBSC_DelayProgram =		$000824+12
SBSC_NemDec =			$000824+16
SBSC_ReadJoypads =		$000824+20

	else

SBSC_VDPSetupGame =		$000220
SBSC_PlayMusic =		$000220+4
SBSC_Pal_FadeFrom =		$000220+8
SBSC_DelayProgram =		$000220+12
SBSC_NemDec =			$000220+16
SBSC_ReadJoypads =		$000220+20

	endif

; ---------------------------------------------------------------------------
; RAM variables
RAM_Start =				ramaddr( $FFFF0000 )
Metablock_Table =		ramaddr( $FFFF0000 )
Level_Layout =			ramaddr( $FFFF8000 )
Block_Table =			ramaddr( $FFFF9000 )
Decomp_Buffer =			ramaddr( $FFFFAA00 )
Sprite_Table_Input = 	ramaddr( $FFFFAC00 ) ; in custom format before being converted and stored in Sprite_Table/Sprite_Table_2
Object_RAM =			ramaddr( $FFFFB000 ) ; through $FFFFD5FF
MainCharacter =			ramaddr( $FFFFB000 ) ; first object (usually Sonic except in a Tails Alone game)
Sidekick =				ramaddr( $FFFFB040 ) ; second object (Tails in a Sonic and Tails game)
Tails_Tails =			ramaddr( $FFFFD000 ) ; address of the Tail's Tails object
Sonic_Dust =			ramaddr( $FFFFD100 )
Knuckles_Dust =			ramaddr( $FFFFD100 )
Tails_Dust =			ramaddr( $FFFFD140 )

PNT_Buffer =			ramaddr( $FFFFD000 ) ; in special stage
Primary_Collision =		ramaddr( $FFFFD600 )
Horiz_Scroll_Buf_2 =	ramaddr( $FFFFD700 ) ; in special stage
Secondary_Collision =	ramaddr( $FFFFD900 )
VDP_Command_Buffer =	ramaddr( $FFFFDC00 ) ; stores VDP commands to issue the next time ProcessDMAQueue is called
VDP_Command_Buffer_Slot =	ramaddr( $FFFFDCFC ) ; stores the address of the next open slot for a queued VDP command
Sprite_Table_2 =		ramaddr( $FFFFDD00 ) ; Sprite attribute table buffer for the bottom split screen in 2-player mode
Horiz_Scroll_Buf =		ramaddr( $FFFFE000 )
Sonic_Stat_Record_Buf =		ramaddr( $FFFFE400 )
Knuckles_Stat_Record_Buf =	ramaddr( $FFFFE400 )
Sonic_Pos_Record_Buf =	ramaddr( $FFFFE500 )
Knuckles_Pos_Record_Buf =	ramaddr( $FFFFE500 )
Tails_Pos_Record_Buf =	ramaddr( $FFFFE600 )
Ring_Positions =		ramaddr( $FFFFE800 )
Camera_RAM =			ramaddr( $FFFFEE00 )
Camera_X_pos =			ramaddr( $FFFFEE00 )
Camera_Y_pos =			ramaddr( $FFFFEE04 )
Camera_Max_Y_pos =		ramaddr( $FFFFEEC6 )
Camera_Min_X_pos =		ramaddr( $FFFFEEC8 )
Camera_Max_X_pos =		ramaddr( $FFFFEECA )
Camera_Min_Y_pos =		ramaddr( $FFFFEECC )
Camera_Max_Y_pos_now =	ramaddr( $FFFFEECE ) ; was "Camera_max_scroll_spd"...
Sonic_Pos_Record_Index =	ramaddr( $FFFFEED2 ) ; into Sonic_Pos_Record_Buf and Sonic_Stat_Record_Buf
Knuckles_Pos_Record_Index =	ramaddr( $FFFFEED2 ) ; into Sonic_Pos_Record_Buf and Sonic_Stat_Record_Buf
Tails_Pos_Record_Index =	ramaddr( $FFFFEED6 ) ; into Tails_Pos_Record_Buf
Camera_Y_pos_bias =		ramaddr( $FFFFEED8 ) ; added to y position for lookup/lookdown, $60 is center
Camera_Y_pos_bias_2P =	ramaddr( $FFFFEEDA ) ; for Tails
Dynamic_Resize_Routine =	ramaddr( $FFFFEEDF )
Tails_Min_X_pos =		ramaddr( $FFFFEEF8 )
Tails_Max_X_pos =		ramaddr( $FFFFEEFA )
Tails_Max_Y_pos =		ramaddr( $FFFFEEFE )

Underwater_palette_2 = 	ramaddr( $FFFFF000 ) ; not sure what it's used for but it's only used when there's water
Underwater_palette = 	ramaddr( $FFFFF080 ) ; main palette for underwater parts of the screen
Underwater_palette_line4 = 	ramaddr( $FFFFF0E0 )

Demo_record_header =		ramaddr( $FFFFF100 ) ; $20 bytes (added by Saxman)
Demo_record_P1 =			ramaddr( $FFFFF120 ) ; $C0 bytes (added by Saxman)
Demo_record_P1_ext =		ramaddr( $FFFFF1E0 ) ; $30 bytes (added by Saxman)
Demo_record_P2 =			ramaddr( $FFFFF210 ) ; $C0 bytes (added by Saxman)
Demo_record_P2_ext =		ramaddr( $FFFFF2D0 ) ; $30 bytes (added by Saxman)

Demo_button_index =			ramaddr( $FFFFF300 ) ; button press index for demo data - player 1 (SACBRLDU)
Demo_press_counter =		ramaddr( $FFFFF302 ) ; frames remaining until next button press - player 1 (SACBRLDU)
Demo_button_ext_index =		ramaddr( $FFFFF304 ) ; button press index for demo data - player 1 (MXYZ)
Demo_press_ext_counter =	ramaddr( $FFFFF306 ) ; frames remaining until next button press - player 1 (MXYZ)

Demo_button_index_2P =		ramaddr( $FFFFF308 ) ; button press index for demo data - player 2 (SACBRLDU)
Demo_press_counter_2P =		ramaddr( $FFFFF30A ) ; frames remaining until next button press - player 2 (SACBRLDU)
Demo_button_ext_index_2P =	ramaddr( $FFFFF30C ) ; button press index for demo data - player 2 (MXYZ)
Demo_press_ext_counter_2P =	ramaddr( $FFFFF30E ) ; frames remaining until next button press - player 2 (MXYZ)

Ctrl_1_Logical =			ramaddr( $FFFFF600 ) ; 2 bytes
Ctrl_1_Held_Logical =		ramaddr( $FFFFF600 ) ; 1 byte
Ctrl_1_Press_Logical =		ramaddr( $FFFFF601 ) ; 1 byte
Ctrl_1 =					ramaddr( $FFFFF602 ) ; 2 bytes	; SACBRLDU
Ctrl_1_Held =				ramaddr( $FFFFF602 ) ; 1 byte
Ctrl_1_Press =				ramaddr( $FFFFF603 ) ; 1 byte

Ctrl_2_Logical =			ramaddr( $FFFFF604 ) ; 2 bytes
Ctrl_2_Held_Logical =		ramaddr( $FFFFF604 ) ; 1 byte
Ctrl_2_Press_Logical =		ramaddr( $FFFFF605 ) ; 1 byte
Ctrl_2 =					ramaddr( $FFFFF606 ) ; 2 bytes	; SACBRLDU
Ctrl_2_Held =				ramaddr( $FFFFF606 ) ; 1 byte
Ctrl_2_Press =				ramaddr( $FFFFF607 ) ; 1 byte

Ctrl_1_Ext_Logical =		ramaddr( $FFFFF608 ) ; 2 bytes
Ctrl_1_Ext_Held_Logical =	ramaddr( $FFFFF608 ) ; 1 byte
Ctrl_1_Ext_Press_Logical =	ramaddr( $FFFFF609 ) ; 1 byte
Ctrl_1_Ext =				ramaddr( $FFFFF60A ) ; 2 bytes	; ----MXYZ
Ctrl_1_Ext_Held =			ramaddr( $FFFFF60A ) ; 1 byte
Ctrl_1_Ext_Press =			ramaddr( $FFFFF60B ) ; 1 byte

Ctrl_2_Ext_Logical =		ramaddr( $FFFFF60C ) ; 2 bytes
Ctrl_2_Ext_Held_Logical =	ramaddr( $FFFFF60C ) ; 1 byte
Ctrl_2_Ext_Press_Logical =	ramaddr( $FFFFF60D ) ; 1 byte
Ctrl_2_Ext =				ramaddr( $FFFFF60E ) ; 2 bytes	; ----MXYZ
Ctrl_2_Ext_Held =			ramaddr( $FFFFF60E ) ; 1 byte
Ctrl_2_Ext_Press =			ramaddr( $FFFFF60F ) ; 1 byte

Game_Mode =				ramaddr( $FFFFF610 ) ; 1 byte ; see GameModesArray (master level trigger, Mstr_Lvl_Trigger)

VDP_reg_value =			ramaddr( $FFFFF612 ) ; 2 bytes

Demo_Time_left =		ramaddr( $FFFFF614 ) ; 2 bytes

Vscroll_Factor =		ramaddr( $FFFFF616 )
Hint_counter_reserve =	ramaddr( $FFFFF624 ) ; Must contain a VDP command word, preferably a write to register $0A. Executed every V-INT.
Delay_Time =			ramaddr( $FFFFF62A ) ; number of frames to delay the game
RNG_seed =				ramaddr( $FFFFF636 ) ; used for random number generation
Game_paused =			ramaddr( $FFFFF63A )
DMA_data_thunk =		ramaddr( $FFFFF640 ) ; Used as a RAM holder for the final DMA command word. Data will NOT be preserved across V-INTs, so consider this space reserved.

Water_Level_1 =			ramaddr( $FFFFF646 )	; Current height with oscillation adjustment
Water_Level_2 =			ramaddr( $FFFFF648 )	; Current height
Water_Level_3 =			ramaddr( $FFFFF64A )	; Target height
Water_routine =			ramaddr( $FFFFF64D )
Water_move =			ramaddr( $FFFFF64E )
Water_on =				ramaddr( $FFFFF64C ) ; is set based on Water_flag
New_Water_Level =		ramaddr( $FFFFF650 )
Water_change_speed =	ramaddr( $FFFFF652 )
Palette_frame_count =	ramaddr( $FFFFF65E )
Super_Sonic_palette =	ramaddr( $FFFFF65F )
Super_Knuckles_palette =	ramaddr( $FFFFF65F )
Sonic_Look_delay_counter = 	ramaddr( $FFFFF66A ) ; 2 bytes
Knuckles_Look_delay_counter = 	ramaddr( $FFFFF66A ) ; 2 bytes
Tails_Look_delay_counter = 	ramaddr( $FFFFF66C ) ; 2 bytes
Super_Sonic_frame_count =	ramaddr( $FFFFF66E )
Super_Knuckles_frame_count =	ramaddr( $FFFFF66E )
						;//ramaddr( $FFFFF670 )
Plc_Buffer =				ramaddr( $FFFFF680 ) ; Pattern load queue ($60 bytes)
Plc_Buffer_VRAM_offset =	ramaddr( $FFFFF6FC ) ; Current decompression VRAM offset (added by Saxman)
Plc_Buffer_ROM_offset =		ramaddr( $FFFFF6FE ) ; Current decompression ROM offset (added by Saxman)

Misc_Variables =		ramaddr( $FFFFF700 )

; extra variables for the second player (CPU) in 1-player mode
Tails_control_counter =	ramaddr( $FFFFF702 ) ; how long until the CPU takes control
Tails_respawn_counter =	ramaddr( $FFFFF704 )
Tails_CPU_routine =		ramaddr( $FFFFF708 )
Tails_CPU_target_x =	ramaddr( $FFFFF70A )
Tails_CPU_target_y =	ramaddr( $FFFFF70C )
Tails_interact_ID =		ramaddr( $FFFFF70E ) ; object ID of last object stood on

Level_started_flag =	ramaddr( $FFFFF711 )
CNZ_Bumper_routine =	ramaddr( $FFFFF71A )
Dirty_flag =			ramaddr( $FFFFF72C ) ; if whole screen needs to redraw
Water_flag =			ramaddr( $FFFFF730 ) ; if the level has water or oil

Sonic_top_speed =		ramaddr( $FFFFF760 )
Sonic_acceleration =	ramaddr( $FFFFF762 )
Sonic_deceleration =	ramaddr( $FFFFF764 )
Knuckles_top_speed =	ramaddr( $FFFFF760 )
Knuckles_acceleration =	ramaddr( $FFFFF762 )
Knuckles_deceleration =	ramaddr( $FFFFF764 )
Obj_placement_routine =	ramaddr( $FFFFF76C )
Obj_load_addr_0 =		ramaddr( $FFFFF770 )
Obj_load_addr_1 =		ramaddr( $FFFFF774 )
Obj_load_addr_2 =		ramaddr( $FFFFF778 )
Obj_load_addr_3 =		ramaddr( $FFFFF77C )
Collision_addr =		ramaddr( $FFFFF796 )
Current_Boss_ID =		ramaddr( $FFFFF7AA )
Control_Locked =		ramaddr( $FFFFF7CC )
Chain_Bonus_counter =	ramaddr( $FFFFF7D0 ) ; counts up when you destroy things that give points, resets when you touch the ground
Bonus_Countdown_1 =		ramaddr( $FFFFF7D2 ) ; level results time bonus or special stage sonic ring bonus
Bonus_Countdown_2 =		ramaddr( $FFFFF7D4 ) ; level results ring bonus or special stage tails ring bonus
Update_Bonus_score =	ramaddr( $FFFFF7D6 )
Camera_X_pos_coarse =	ramaddr( $FFFFF7DA ) ; (Camera_X_pos - 128) / 256

Sprite_Table =			ramaddr( $FFFFF800 ) ; Sprite attribute table buffer

Normal_palette =		ramaddr( $FFFFFB00 )
Normal_palette_line2 =	ramaddr( $FFFFFB20 )
Normal_palette_line3 =	ramaddr( $FFFFFB40 )
Normal_palette_line4 =	ramaddr( $FFFFFB60 )
Second_palette =		ramaddr( $FFFFFB80 )
Second_palette_line2 =	ramaddr( $FFFFFBA0 )
Second_palette_line3 =	ramaddr( $FFFFFBC0 )
Second_palette_line4 =	ramaddr( $FFFFFBE0 )

Object_Respawn_Table =	ramaddr( $FFFFFC00 )
System_Stack =			ramaddr( $FFFFFE00 )
Level_Inactive_flag = 	ramaddr( $FFFFFE02 ) ; (2 bytes)
Timer_total_frames =	ramaddr( $FFFFFE04 ) ; (2 bytes)
Debug_object =			ramaddr( $FFFFFE06 )
Debug_placement_mode =	ramaddr( $FFFFFE08 )
Current_ZoneAndAct =	ramaddr( $FFFFFE10 ) ; 2 bytes
Current_Zone =			ramaddr( $FFFFFE10 ) ; 1 byte
Current_Act =			ramaddr( $FFFFFE11 ) ; 1 byte
Life_count =			ramaddr( $FFFFFE12 )
Current_Special_Stage =	ramaddr( $FFFFFE16 )
Continue_count =		ramaddr( $FFFFFE18 )
Super_Sonic_flag =		ramaddr( $FFFFFE19 )
Super_Knuckles_flag =	ramaddr( $FFFFFE19 )
Time_Over_flag =		ramaddr( $FFFFFE1A )
Extra_life_flags =		ramaddr( $FFFFFE1B )

; If set, the respective HUD element will be updated.
Update_HUD_lives =		ramaddr( $FFFFFE1C )
Update_HUD_rings =		ramaddr( $FFFFFE1D )
Update_HUD_timer =		ramaddr( $FFFFFE1E )
Update_HUD_score =		ramaddr( $FFFFFE1F )

Ring_count =			ramaddr( $FFFFFE20 ) ; 2 bytes
Timer =					ramaddr( $FFFFFE22 ) ; 4 bytes
Timer_minute_word =		ramaddr( $FFFFFE22 ) ; 2 bytes
Timer_minute =			ramaddr( $FFFFFE23 ) ; 1 byte
Timer_second =			ramaddr( $FFFFFE24 ) ; 1 byte
Timer_frame =			ramaddr( $FFFFFE25 ) ; 1 byte
Score =					ramaddr( $FFFFFE26 ) ; 4 bytes
Last_star_pole_hit =	ramaddr( $FFFFFE30 ) ; 1 byte -- max activated starpole ID in this act

Saved_Last_star_pole_hit =	ramaddr( $FFFFFE31 )
Saved_x_pos =			ramaddr( $FFFFFE32 )
Saved_y_pos =			ramaddr( $FFFFFE34 )
Saved_Ring_count =		ramaddr( $FFFFFE36 )
Saved_Timer =			ramaddr( $FFFFFE38 )
Saved_art_tile =		ramaddr( $FFFFFE3C )
Saved_layer =			ramaddr( $FFFFFE3E )
Saved_Camera_X_pos =	ramaddr( $FFFFFE40 )
Saved_Camera_Y_pos =	ramaddr( $FFFFFE42 )
Saved_Water_Level =		ramaddr( $FFFFFE50 )
Saved_Water_routine =	ramaddr( $FFFFFE52 )
Saved_Water_move =		ramaddr( $FFFFFE53 )
Saved_Extra_life_flags =	ramaddr( $FFFFFE54 )
Saved_Extra_life_flags_2P =	ramaddr( $FFFFFE55 )
Saved_Camera_Max_Y_pos =	ramaddr( $FFFFFE56 )
Saved_Dynamic_Resize_Routine =	ramaddr( $FFFFFE58 )

Logspike_anim_counter =	ramaddr( $FFFFFEA0 )
Logspike_anim_frame =	ramaddr( $FFFFFEA1 )
Rings_anim_counter =	ramaddr( $FFFFFEA2 )
Rings_anim_frame =		ramaddr( $FFFFFEA3 )
Unknown_anim_counter =	ramaddr( $FFFFFEA4 ) ; I think this was $FFFFFEC4 in the alpha
Unknown_anim_frame =	ramaddr( $FFFFFEA5 )
Ring_spill_anim_counter =	ramaddr( $FFFFFEA6 ) ; scattered rings
Ring_spill_anim_frame =	ramaddr( $FFFFFEA7 )
Ring_spill_anim_accum =	ramaddr( $FFFFFEA8 )

; values for the second player (some of these only apply to 2-player games)
Tails_top_speed =		ramaddr( $FFFFFEC0 ) ; Tails_max_vel
Tails_acceleration =	ramaddr( $FFFFFEC2 )
Tails_deceleration =	ramaddr( $FFFFFEC4 )
Life_count_2P =			ramaddr( $FFFFFEC6 )
Extra_life_flags_2P =	ramaddr( $FFFFFEC7 )
Update_HUD_lives_2P =	ramaddr( $FFFFFEC8 )
Update_HUD_rings_2P =	ramaddr( $FFFFFEC9 )
Update_HUD_timer_2P =	ramaddr( $FFFFFECA )
Update_HUD_score_2P =	ramaddr( $FFFFFECB ) ; mostly unused
Time_Over_flag_2P =		ramaddr( $FFFFFECC )
Ring_count_2P =			ramaddr( $FFFFFED0 )
Timer_2P =				ramaddr( $FFFFFED2 ) ; 4 bytes
Timer_minute_word_2P =	ramaddr( $FFFFFED2 ) ; 2 bytes
Timer_minute_2P =		ramaddr( $FFFFFED3 ) ; 1 byte
Timer_second_2P =		ramaddr( $FFFFFED4 ) ; 1 byte
Timer_frame_2P =		ramaddr( $FFFFFED5 ) ; 1 byte
Score_2P =				ramaddr( $FFFFFED6 )
Last_star_pole_hit_2P =	ramaddr( $FFFFFEE0 )

Saved_Last_star_pole_hit_2P =	ramaddr( $FFFFFEE1 )
Saved_x_pos_2P =		ramaddr( $FFFFFEE2 )
Saved_y_pos_2P =		ramaddr( $FFFFFEE4 )
Saved_Ring_count_2P =	ramaddr( $FFFFFEE6 )
Saved_Timer_2P =		ramaddr( $FFFFFEE8 )
Saved_art_tile_2P =		ramaddr( $FFFFFEEC )
Saved_layer_2P =		ramaddr( $FFFFFEEE )

Loser_Time_Left =		ramaddr( $FFFFFEF8 )
Results_Screen_2P =		ramaddr( $FFFFFF10 ) ; 0 = act, 1 = zone, 2 = game, 3 = SS, 4 = SS all
Results_Data_2P =		ramaddr( $FFFFFF20 ) ; $18 bytes
EHZ_Results_2P =		ramaddr( $FFFFFF20 ) ; 6 bytes
MCZ_Results_2P =		ramaddr( $FFFFFF26 ) ; 6 bytes
CNZ_Results_2P =		ramaddr( $FFFFFF2C ) ; 6 bytes
SS_Results_2P =			ramaddr( $FFFFFF32 ) ; 6 bytes
SS_Total_Won =			ramaddr( $FFFFFF38 ) ; 2 bytes (player 1 then player 2)
Perfect_rings_left =	ramaddr( $FFFFFF40 )
Player_mode =			ramaddr( $FFFFFF70 ) ; 0 = Sonic and Tails, 1 = Sonic, 2 = Tails, 3 = Knuckles
Player_option =			ramaddr( $FFFFFF72 ) ; 0 = Sonic and Tails, 1 = Sonic, 2 = Tails, 3 = Knuckles

Two_player_items =		ramaddr( $FFFFFF74 )
Level_select_zone =		ramaddr( $FFFFFF82 )
Sound_test_sound =		ramaddr( $FFFFFF84 )
Title_screen_option =	ramaddr( $FFFFFF86 )
Current_Zone_2P =		ramaddr( $FFFFFF88 )
Current_Act_2P =		ramaddr( $FFFFFF89 )
Two_player_mode_copy =	ramaddr( $FFFFFF8A )
Options_menu_box =		ramaddr( $FFFFFF8C )
Level_Music =			ramaddr( $FFFFFF90 )
Game_Over_2P =			ramaddr( $FFFFFF98 )
Got_Emerald =			ramaddr( $FFFFFFB0 )
Emerald_count =			ramaddr( $FFFFFFB1 )
Got_Emeralds_array =	ramaddr( $FFFFFFB2 ) ; 7 bytes
Next_Extra_life_score =	ramaddr( $FFFFFFC0 )
Next_Extra_life_score_2P =	ramaddr( $FFFFFFC4 )
Level_Has_Signpost =	ramaddr( $FFFFFFC8 ) ; 1 byte ; 1 = signpost, 0 = boss or nothing

Cheat_flags =			ramaddr( $FFFFFFD0 )	; 1 byte
Cheat_active_flags =	ramaddr( $FFFFFFD1 )	; 1 byte
Correct_cheat_entries =	ramaddr( $FFFFFFD2 )	; 2 bytes

; Correct_cheat_entries ($ABCD)
; ==================================================
;		Options			Level select	Title
; ==================================================
; A		Saxman code		Saxman code		(unused)
; B		Level select	Debug			Miles/Tails
; C		(unused)		(unused)		(unused)
; D		14 continues	7 emeralds		Knuckles

; Cheat_flags (%HGFEDCBA)
; ==================================================
; A		Level select menu
; B		Slow motion
; C		Debug mode
; D		Invulnerability mode
; E		Knuckles enable
; F		(unused)
; G		(unused)
; H		(unused)

Two_player_mode =		ramaddr( $FFFFFFD8 ) ; flag (0 for main game)

; Values in these variables are passed to the sound driver during V-INT.
; They use a playlist index, not a sound test index.
Music_to_play =			ramaddr( $FFFFFFE0 )
SFX_to_play =			ramaddr( $FFFFFFE1 ) ; normal
SFX_to_play_2 =			ramaddr( $FFFFFFE2 ) ; alternating stereo
Music_to_play_2 =		ramaddr( $FFFFFFE4 ) ; alternate (higher priority?) slot
Current_music =			ramaddr( $FFFFFFE5 ) ; current music playing for entries 01-17 (added by Saxman)

Demo_mode_flag =		ramaddr( $FFFFFFF0 ) ; 1 if a demo is playing (2 bytes)
Demo_number =			ramaddr( $FFFFFFF2 ) ; which demo will play next (2 bytes)
Graphics_Flags =		ramaddr( $FFFFFFF8 ) ; misc. bitfield
Checksum_fourcc =		ramaddr( $FFFFFFFC ) ; (4 bytes)

; ---------------------------------------------------------------------------
; ROM addresses
Hint_Vector =			$000070 ; Setting this programmatically isn't supported by Gens

	if BUILD_32X_ROM == 1
ROM_Start = 			$880000 ; First 512 kilobytes of the ROM
ROM_Bank_0 =			$900000-$000000 ; 1MB bank #0
ROM_Bank_1 =			$900000-$100000 ; 1MB bank #1
ROM_Bank_2 =			$900000-$200000 ; 1MB bank #2
ROM_Bank_3 =			$900000-$300000 ; 1MB bank #3
	else
ROM_Start =				$000000
ROM_Bank_0 =			$000000
ROM_Bank_1 =			$000000
ROM_Bank_2 =			$000000
ROM_Bank_3 =			$000000
	endif

; ---------------------------------------------------------------------------
; VDP addressses
VDP_data_port =			$C00000 ; (8=r/w, 16=r/w)
VDP_control_port =		$C00004 ; (8=r/w, 16=r/w)

; ---------------------------------------------------------------------------
; Z80 addresses
Z80_RAM =				$A00000 ; start of Z80 RAM
Z80_RAM_End =			$A02000 ; end of non-reserved Z80 RAM
Z80_Version =			$A10001
Z80_Port_1_Data =		$A10002
Z80_Port_1_Control =	$A10008
Z80_Port_2_Control =	$A1000A
Z80_Expansion_Control =	$A1000C
Z80_Bus_Request =		$A11100
Z80_Reset =				$A11200

Security_Addr =			$A14000