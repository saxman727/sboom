@ECHO OFF

REM // make sure we can write to the file s2built.bin
REM // also make a backup to s2built.prev.bin
IF NOT EXIST s2built.bin goto LABLNOCOPY
IF EXIST s2built.prev.bin del s2built.prev.bin
IF EXIST s2built.prev.bin goto LABLNOCOPY
move /Y s2built.bin s2built.prev.bin
IF EXIST s2built.bin goto LABLERROR3
REM IF EXIST s2built.prev.bin copy /Y s2built.prev.bin s2built.bin
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
"win32/asw" -xx -c -A main.asm

REM // combine the assembler output into a rom
IF EXIST main.p "win32/s2p2bin" main.p s2built.bin main.h

REM // fix some pointers and things that are impossible to fix from the assembler without un-splitting their data
IF EXIST s2built.bin "win32/fixpointer" main.h s2built.bin   off_3A294 MapRUnc_Sonic $2D 0 4   word_728C_user Obj5F_MapUnc_7240 2 2 1  

REM REM // fix the rom header (checksum)
IF EXIST s2built.bin "win32/fixheader" s2built.bin


REM // done -- pause if we seem to have failed, then exit
IF NOT EXIST main.p goto LABLPAUSE
IF EXIST s2built.bin exit /b
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
echo Failed to build because write access to s2built.bin was denied.
pause


