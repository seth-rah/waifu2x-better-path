@ECHO OFF
SETLOCAL 
:SETCOLOURS
FOR /F "tokens=1,2 delims=#" %%a in ('"PROMPT #$H#$E# & ECHO ON & FOR %%b IN (1) DO REM"') DO ( SET COL=%%b )

:CHECKINPUT
IF "%~1"=="" (GOTO FILE) ELSE (GOTO DECLARE)

:DECLARE
SET file=%1
SET args=%2
GOTO GETVARIABLES

:FILE
SET /P file=Please provide the file you wish to upscale using waifu: 
GOTO GETVARIABLES

:GETVARIABLES
FOR %%i IN ("%file%") DO (
SET filedrive=%%~di
SET filepath=%%~pi
SET filename=%%~ni
SET fileextension=%%~xi
)
GOTO CHECKEXTENSION

:CHECKEXTENSION
IF "%fileextension%"=="" (GOTO TESTEXTENSION) ELSE (GOTO CHECKEXIST)

:TESTEXTENSION
IF EXIST "%filedrive%%filepath%%filename%.jpg" IF EXIST "%filedrive%%filepath%%filename%.png" (GOTO SETEXTENSION)
IF EXIST "%filedrive%%filepath%%filename%.jpg" (SET fileextension=.jpg)
IF EXIST "%filedrive%%filepath%%filename%.png" (SET fileextension=.png)
IF EXIST "%filedrive%%filepath%%filename%.*" IF "%fileextension%"=="" (GOTO SETEXTENSION)
GOTO CHECKEXIST

:SETEXTENSION
SET /P fileextension=Provide the file extension: 
IF %fileextension:~0,1%==. (GOTO CHECKEXIST) ELSE (GOTO FIXEXTENSION)

:FIXEXTENSION
SET fileextension=.%fileextension%
GOTO CHECKEXIST

:CHECKEXIST
IF /I NOT EXIST "%filedrive%%filepath%%filename%.*" (GOTO NOTFOUND)
IF /I NOT EXIST "%filedrive%%filepath%%filename%%fileextension%" (GOTO EXTNOTFOUND)
IF /I "%args%"=="" IF EXIST "%filedrive%%filepath%%filename%-cunetwaifu%fileextension%" (ECHO. & ECHO %COL%[91m%filename%-cunetwaifu%fileextension% already exists.%COL%[0m & GOTO EXISTS)
IF /I "%args%"=="extra" IF EXIST "%filedrive%%filepath%%filename%-cunetwaifu%fileextension%" (ECHO. & ECHO %COL%[91mAny of the following  "%filename%-cunetwaifu%fileextension% / %filename%-animewaifu%fileextension% / %filename%-photowaifu%fileextension%" already exist.%COL%[0m & GOTO EXISTS)
IF /I "%args%"=="extra" IF EXIST "%filedrive%%filepath%%filename%-animewaifu%fileextension%" (ECHO. & ECHO %COL%[91mAny of the following  "%filename%-cunetwaifu%fileextension% / %filename%-animewaifu%fileextension% / %filename%-photowaifu%fileextension%" already exist.%COL%[0m & GOTO EXISTS)
IF /I "%args%"=="extra" IF EXIST "%filedrive%%filepath%%filename%-photowaifu%fileextension%" (ECHO. & ECHO %COL%[91mAny of the following  "%filename%-cunetwaifu%fileextension% / %filename%-animewaifu%fileextension% / %filename%-photowaifu%fileextension%" already exist.%COL%[0m & GOTO EXISTS) 
IF /I "%args%"=="slow" IF EXIST "%filedrive%%filepath%%filename%-ttacunetwaifu%fileextension%" (ECHO. & ECHO %COL%[91mAny of the following  "%filename%-ttacunetwaifu%fileextension% / %filename%-ttanimewaifu%fileextension% / %filename%-ttaphotowaifu%fileextension%" already exist.%COL%[0m & GOTO EXISTS)
IF /I "%args%"=="slow" IF EXIST "%filedrive%%filepath%%filename%-ttaanimewaifu%fileextension%" (ECHO. & ECHO %COL%[91mAny of the following  "%filename%-ttacunetwaifu%fileextension% / %filename%-ttaanimewaifu%fileextension% / %filename%-ttaphotowaifu%fileextension%" already exist.%COL%[0m & GOTO EXISTS)
IF /I "%args%"=="slow" IF EXIST "%filedrive%%filepath%%filename%-ttaphotowaifu%fileextension%" (ECHO. & ECHO %COL%[91mAny of the following  "%filename%-ttacunetwaifu%fileextension% / %filename%-ttaanimewaifu%fileextension% / %filename%-ttaphotowaifu%fileextension%" already exist.%COL%[0m & GOTO EXISTS) 
IF /I "%args%"=="all" IF EXIST "%filedrive%%filepath%%filename%-cunetwaifu%fileextension%" (ECHO. & ECHO %COL%[91mAny of the following  "%filename%-cunetwaifu%fileextension% / %filename%-animewaifu%fileextension% / %filename%-photowaifu%fileextension% / %filename%-ttacunetwaifu%fileextension% / %filename%-ttaanimewaifu%fileextension% / %filename%-ttaphotowaifu%fileextension%" already exist.%COL%[0m & GOTO EXISTS)
IF /I "%args%"=="all" IF EXIST "%filedrive%%filepath%%filename%-animewaifu%fileextension%" (ECHO. & ECHO %COL%[91mAny of the following  "%filename%-cunetwaifu%fileextension% / %filename%-animewaifu%fileextension% / %filename%-photowaifu%fileextension% / %filename%-ttacunetwaifu%fileextension% / %filename%-ttaanimewaifu%fileextension% / %filename%-ttaphotowaifu%fileextension%" already exist.%COL%[0m & GOTO EXISTS)
IF /I "%args%"=="all" IF EXIST "%filedrive%%filepath%%filename%-photowaifu%fileextension%" (ECHO. & ECHO %COL%[91mAny of the following  "%filename%-cunetwaifu%fileextension% / %filename%-animewaifu%fileextension% / %filename%-photowaifu%fileextension% / %filename%-ttacunetwaifu%fileextension% / %filename%-ttaanimewaifu%fileextension% / %filename%-ttaphotowaifu%fileextension%" already exist.%COL%[0m & GOTO EXISTS) 
IF /I "%args%"=="all" IF EXIST "%filedrive%%filepath%%filename%-ttacunetwaifu%fileextension%" (ECHO. & ECHO %COL%[91mAny of the following  "%filename%-cunetwaifu%fileextension% / %filename%-animewaifu%fileextension% / %filename%-photowaifu%fileextension% / %filename%-ttacunetwaifu%fileextension% / %filename%-ttanimewaifu%fileextension% / %filename%-ttaphotowaifu%fileextension%" already exist.%COL%[0m & GOTO EXISTS)
IF /I "%args%"=="all" IF EXIST "%filedrive%%filepath%%filename%-ttaanimewaifu%fileextension%" (ECHO. & ECHO %COL%[91mAny of the following  "%filename%-cunetwaifu%fileextension% / %filename%-animewaifu%fileextension% / %filename%-photowaifu%fileextension% / %filename%-ttacunetwaifu%fileextension% / %filename%-ttaanimewaifu%fileextension% / %filename%-ttaphotowaifu%fileextension%" already exist.%COL%[0m & GOTO EXISTS)
IF /I "%args%"=="all" IF EXIST "%filedrive%%filepath%%filename%-ttaphotowaifu%fileextension%" (ECHO. & ECHO %COL%[91mAny of the following  "%filename%-cunetwaifu%fileextension% / %filename%-animewaifu%fileextension% / %filename%-photowaifu%fileextension% / %filename%-ttacunetwaifu%fileextension% / %filename%-ttaanimewaifu%fileextension% / %filename%-ttaphotowaifu%fileextension%" already exist.%COL%[0m & GOTO EXISTS) 
ECHO made to end
IF /I "%args%" NEQ "extra" (IF /I "%args%" NEQ "slow" (IF /I "%args%" NEQ "all" (IF /I "%args%" NEQ "" (IF EXIST "%filedrive%%filepath%%filename%-argwaifu%fileextension%" (ECHO. & ECHO %COL%[91m%filename%-argwaifu%fileextension% already exists.%COL%[0m & GOTO EXISTS)))))
GOTO WAIFUCHECK

:EXISTS
ECHO.
IF /I "%args%" EQU "extra" SET /P exists=Do you wish to overwrite all files (Y/N)? 
IF /I "%args%" EQU "slow" SET /P exists=Do you wish to overwrite all files (Y/N)? 
IF /I "%args%" EQU "all" SET /P exists=Do you wish to overwrite all files (Y/N)? 
IF /I "%args%" NEQ "extra" IF /I "%args%" NEQ "slow" IF /I "%args%" NEQ "all" SET /P exists=Do you wish to overwrite the file (Y/N)? 
IF /I "%exists%" NEQ "Y" (GOTO STOPPING) ELSE (GOTO WAIFUCHECK)

:WAIFUCHECK
IF "%args%"=="" (GOTO WAIFU)
IF "%args%"=="extra" (GOTO WAIFUEXT)
IF "%args%"=="slow" (GOTO WAIFUSLOW)
IF "%args%"=="all" (GOTO WAIFUALL)
ECHO.  
ECHO %COL%[95m"Free arguments enabled"%COL%[0m
ECHO %COL%[95m"File output path is set in stone"%COL%[0m
ECHO %COL%[95m"  -v                   verbose output"%COL%[0m
ECHO %COL%[95m"  -n noise-level       denoise level (-1/0/1/2/3, default=0)"%COL%[0m
ECHO %COL%[95m"  -s scale             upscale ratio (1/2, default=2)"%COL%[0m
ECHO %COL%[95m"  -t tile-size         tile size (>=32/0=auto, default=0) can be 0,0,0 for multi-gpu"%COL%[0m
ECHO %COL%[95m"  -m model-path        waifu2x model path (default=models-cunet)"%COL%[0m
ECHO %COL%[95m"  -g gpu-id            gpu device to use (default=0) can be 0,1,2 for multi-gpu"%COL%[0m
ECHO %COL%[95m"  -j load:proc:save    thread count for load/proc/save (default=1:2:2) can be 1:2,2,2:2 for multi-gpu"%COL%[0m
ECHO %COL%[95m"  -x                   enable tta mode"%COL%[0m
ECHO %COL%[95m"  -f format            output image format (jpg/png/webp, default=ext/png)"%COL%[0m
ECHO.  
SET /P args="Provide extra arguments for rescaling. Leave empty for waifu2x-ncnn-vulkan default: "
GOTO WAIFUARGS

:WAIFUARGS
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-argwaifu%fileextension% %args%
@ECHO OFF
ECHO. 
ECHO %COL%[93mRescaling complete%COL%[0m
ENDLOCAL
cmd /k

:WAIFU
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-cunetwaifu%fileextension% -n 2 -s 2 -v
@ECHO OFF
ECHO. 
ECHO %COL%[93mRescaling complete%COL%[0m
ECHO. 
ENDLOCAL
cmd /k

:WAIFUEXT
ECHO. 
ECHO %COL%[104;30m Three commands are about to run in sequence. Please be patient. %COL%[0m
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-cunetwaifu%fileextension% -n 2 -s 2 -v
@ECHO OFF
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-animewaifu%fileextension% -n 2 -s 2 -v -m models-upconv_7_anime_style_art_rgb
@ECHO OFF
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-photowaifu%fileextension% -n 2 -s 2 -v -m models-upconv_7_photo
@ECHO OFF
ECHO. 
ECHO %COL%[93mRescaling complete%COL%[0m
ECHO. 
ENDLOCAL
cmd /k

:WAIFUSLOW
ECHO. 
ECHO %COL%[104;30m Three very slow commands are about to run in sequence. Please be patient. %COL%[0m
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-ttacunetwaifu%fileextension% -n 2 -s 2 -v -x
@ECHO OFF
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-ttaanimewaifu%fileextension% -n 2 -s 2 -v -x -m models-upconv_7_anime_style_art_rgb
@ECHO OFF
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-ttaphotowaifu%fileextension% -n 2 -s 2 -v -x -m models-upconv_7_photo
@ECHO OFF
ECHO. 
ECHO %COL%[93mRescaling complete%COL%[0m
ECHO. 
ENDLOCAL
cmd /k

:WAIFUALL
ECHO. 
ECHO %COL%[104;30m Six commands are about to run in sequence. This will take a while, please be patient. %COL%[0m
ECHO.
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-cunetwaifu%fileextension% -n 2 -s 2 -v
@ECHO OFF
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-animewaifu%fileextension% -n 2 -s 2 -v -m models-upconv_7_anime_style_art_rgb
@ECHO OFF
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-photowaifu%fileextension% -n 2 -s 2 -v -m models-upconv_7_photo
@ECHO OFF
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-ttacunetwaifu%fileextension% -n 2 -s 2 -v -x
@ECHO OFF
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-ttaanimewaifu%fileextension% -n 2 -s 2 -v -x -m models-upconv_7_anime_style_art_rgb
@ECHO OFF
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-ttaphotowaifu%fileextension% -n 2 -s 2 -v -x -m models-upconv_7_photo
@ECHO OFF
ECHO. 
ECHO %COL%[93mRescaling complete%COL%[0m
ECHO. 
ENDLOCAL
cmd /k

:EXTNOTFOUND
ECHO. 
ECHO %COL%[91m%filedrive%%filepath%%filename% exists, but %fileextension% is not correct, please provide the correct file extension.%COL%[0m
ECHO. 
GOTO SETEXTENSION

:NOTFOUND
ECHO. 
ECHO %COL%[91mInput file not found, please try again.%COL%[0m
ECHO. 
GOTO FILE

:STOPPING
ECHO.
ECHO %COL%[91mclosing%COL%[0m
ECHO. 
ENDLOCAL
cmd /k