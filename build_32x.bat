@ECHO OFF

REM // make sure we can write to the file s2built.32x
REM // also make a backup to s2built.prev.32x
IF NOT EXIST s2built.32x goto LABLNOCOPY
IF EXIST s2built.prev.32x del s2built.prev.32x
IF EXIST s2built.prev.32x goto LABLNOCOPY
move /Y s2built.32x s2built.prev.32x
IF EXIST s2built.32x goto LABLERROR3
REM IF EXIST s2built.prev.32x copy /Y s2built.prev.32x s2built.32x
:LABLNOCOPY

REM // delete some intermediate assembler output just in case
IF EXIST main.p del main.p
IF EXIST main.p goto LABLERROR2
IF EXIST main.h del main.h
IF EXIST main.h goto LABLERROR1

REM // clear the output window
cls


REM // run the assembler
REM // -xx shows the most detailed error output
REM // -c outputs a shared file (main.h)
REM // -A gives us a small speedup
set AS_MSGPATH=win32/msg
set USEANSI=n
"win32/sh-elf-as" sh2master.asm
"win32/sh-elf-objcopy" -O binary --only-section=.text a.out sh2master.bin
"win32/sh-elf-as" sh2slave.asm
"win32/sh-elf-objcopy" -O binary --only-section=.text a.out sh2slave.bin
"win32/sh-elf-as" sh2int.asm
"win32/sh-elf-objcopy" -O binary --only-section=.text a.out sh2int.bin
"win32/asw" -xx -c -A main.asm

REM // combine the assembler output into a rom
IF EXIST main.p "win32/s2p2bin" main.p s2built.32x main.h

REM // fix some pointers and things that are impossible to fix from the assembler without un-splitting their data
IF EXIST s2built.32x "win32/fixpointer" main.h s2built.32x   off_3A294 MapRUnc_Sonic $2D 0 4   word_728C_user Obj5F_MapUnc_7240 2 2 1  

REM REM // fix the rom header (checksum)
IF EXIST s2built.32x "win32/fixheader" s2built.32x


REM // done -- pause if we seem to have failed, then exit
IF NOT EXIST main.p goto LABLPAUSE
IF EXIST s2built.32x exit /b
:LABLPAUSE
pause


exit /b

:LABLERROR1
echo Failed to build because write access to main.h was denied.
pause


exit /b

:LABLERROR2
echo Failed to build because write access to main.p was denied.
pause


exit /b

:LABLERROR3
echo Failed to build because write access to s2built.32x was denied.
pause


