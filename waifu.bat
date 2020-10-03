@ECHO OFF
SETLOCAL EnableExtensions EnableDelayedExpansion
:SETCOLOURS
FOR /F %%a IN ('"prompt $E$S & echo on & for %%b in (1) do rem"') DO SET "COL=%%a"

:VERIFICATION
WHERE waifu2x-ncnn-vulkan >NUL
IF %ERRORLEVEL% NEQ 0 (ECHO. & ECHO %COL%[40;91mwaifu2x-ncnn-vulkans directory not pathed correctly or waifu.bat is being called from the wrong directory.%COL%[0m & ECHO %COL%[40;91mPlease make sure waifu2x-ncnn-vulkans and waifu.bat are in the same directory.%COL%[0m& GOTO STOPPING)
WHERE vulkaninfo >NUL
IF %ERRORLEVEL% NEQ 0 (ECHO. & ECHO %COL%[40;91mYour device does not have Vulkan support.%COL%[0m& GOTO STOPPING)

:CHECKINPUT
IF "%~1"=="" (GOTO FILE) ELSE (GOTO DECLARE)

:DECLARE
SET file=%1
SET args=%2
GOTO GETVARIABLES

:FILE
SET /P file=%COL%[40;92mPlease provide the file you wish to upscale using waifu:%COL%[0m 
GOTO GETVARIABLES

:GETVARIABLES
FOR %%i IN ("%file%") DO (
SET filedrive=%%~di
SET filepath=%%~pi
SET filename=%%~ni
SET fileextension=%%~xi
)
SET fileshort=%filedrive%%filepath%%filename%
GOTO CHECKEXTENSION

:CHECKEXTENSION
IF "%fileextension%" EQU "" (GOTO TESTEXTENSION) ELSE (GOTO CHECKEXIST)

:TESTEXTENSION
IF EXIST "%fileshort%.jpg" IF EXIST "%fileshort%.png" (GOTO SETEXTENSION)
IF EXIST "%fileshort%.jpg" (SET fileextension=.jpg)
IF EXIST "%fileshort%.png" (SET fileextension=.png)
IF EXIST "%fileshort%.*" IF "%fileextension%" EQU "" (GOTO SETEXTENSION)
GOTO CHECKEXIST

:SETEXTENSION
SET /P fileextension=%COL%[40;92mProvide the file extension:%COL%[0m 
IF %fileextension:~0,1%==. (GOTO CHECKEXIST) ELSE (GOTO FIXEXTENSION)

:FIXEXTENSION
SET fileextension=.%fileextension%
GOTO CHECKEXIST

:CHECKEXIST
SET argsbool=false
SET argsdupeextra=false
SET argsdupeslow=false
IF /I NOT EXIST "%fileshort%.*" (GOTO NOTFOUND)
IF /I NOT EXIST "%fileshort%%fileextension%" (GOTO EXTNOTFOUND)
IF /I "%args%" EQU "" IF EXIST "%fileshort%-cunetwaifu%fileextension%" (ECHO. & ECHO %COL%[40;91m%filename%-cunetwaifu%fileextension% already exists.%COL%[0m& GOTO EXISTS)
IF /I "%args%" EQU "extra" SET argsbool=true
IF /I "%args%" EQU "slow" SET argsbool=true
IF /I "%args%" EQU "all" SET argsbool=true
IF EXIST "%fileshort%-cunetwaifu%fileextension%" (SET argsdupeextra=true)
IF EXIST "%fileshort%-animewaifu%fileextension%" (SET argsdupeextra=true)
IF EXIST "%fileshort%-photowaifu%fileextension%" (SET argsdupeextra=true)
IF EXIST "%fileshort%-ttacunetwaifu%fileextension%" (SET argsdupeslow=true)
IF EXIST "%fileshort%-ttaanimewaifu%fileextension%" (SET argsdupeslow=true)
IF EXIST "%fileshort%-ttaphotowaifu%fileextension%" (SET argsdupeslow=true)
IF /I "%args%" EQU "extra" IF /I "%argsdupeextra%" EQU "true" (ECHO. & ECHO %COL%[40;91mAny of the following  "%filename%-cunetwaifu%fileextension% / %filename%-animewaifu%fileextension% / %filename%-photowaifu%fileextension%" already exist.%COL%[0m& GOTO EXISTS)
IF /I "%args%" EQU "slow" IF /I "%argsdupeslow%" EQU "true" (ECHO. & ECHO %COL%[40;91mAny of the following  "%filename%-ttacunetwaifu%fileextension% / %filename%-ttanimewaifu%fileextension% / %filename%-ttaphotowaifu%fileextension%" already exist.%COL%[0m& GOTO EXISTS)
IF /I "%args%" EQU "all" IF /I "%argsdupeextra%" EQU "true" (ECHO. & ECHO %COL%[40;91mAny of the following  "%filename%-cunetwaifu%fileextension% / %filename%-animewaifu%fileextension% / %filename%-photowaifu%fileextension% / %filename%-ttacunetwaifu%fileextension% / %filename%-ttaanimewaifu%fileextension% / %filename%-ttaphotowaifu%fileextension%" already exist.%COL%[0m& GOTO EXISTS)
IF /I "%args%" EQU "all" IF /I "%argsdupeslow%" EQU "true" (ECHO. & ECHO %COL%[40;91mAny of the following  "%filename%-cunetwaifu%fileextension% / %filename%-animewaifu%fileextension% / %filename%-photowaifu%fileextension% / %filename%-ttacunetwaifu%fileextension% / %filename%-ttaanimewaifu%fileextension% / %filename%-ttaphotowaifu%fileextension%" already exist.%COL%[0m& GOTO EXISTS)
IF /I "%args%" NEQ "extra" (IF /I "%args%" NEQ "slow" (IF /I "%args%" NEQ "all" (IF /I "%args%" NEQ "" (IF EXIST "%fileshort%-argwaifu%fileextension%" (ECHO. & ECHO %COL%[40;91m%filename%-argwaifu%fileextension% already exists.%COL%[0m& GOTO EXISTS)))))
GOTO WAIFUCHECK

:EXISTS
ECHO.
IF /I "%argsbool%" EQU "false" (SET /P exists="%COL%[40;93mDo you wish to overwrite the file (Y/N)?%COL%[0m ") ELSE (SET /P exists="%COL%[40;93mDo you wish to overwrite all files (Y/N)?%COL%[0m ")
IF /I "%exists%" NEQ "Y" (GOTO STOPPING) ELSE (GOTO WAIFUCHECK)

:WAIFUCHECK
IF /I "%args%" EQU "" (GOTO WAIFU)
IF /I "%args%" EQU "extra" (GOTO WAIFUEXT)
IF /I "%args%" EQU "slow" (GOTO WAIFUSLOW)
IF /I "%args%" EQU "all" (GOTO WAIFUALL)
ECHO.  
ECHO %COL%[40;95m"Free arguments enabled"%COL%[0m
ECHO %COL%[40;95m"File output path is set in stone"%COL%[0m
ECHO %COL%[40;95m"  -v                   verbose output"%COL%[0m
ECHO %COL%[40;95m"  -n noise-level       denoise level (-1/0/1/2/3, default=0)"%COL%[0m
ECHO %COL%[40;95m"  -s scale             upscale ratio (1/2, default=2)"%COL%[0m
ECHO %COL%[40;95m"  -t tile-size         tile size (>=32/0=auto, default=0) can be 0,0,0 for multi-gpu"%COL%[0m
ECHO %COL%[40;95m"  -m model-path        waifu2x model path (default=models-cunet)"%COL%[0m
ECHO %COL%[40;95m"  -g gpu-id            gpu device to use (default=0) can be 0,1,2 for multi-gpu"%COL%[0m
ECHO %COL%[40;95m"  -j load:proc:save    thread count for load/proc/save (default=1:2:2) can be 1:2,2,2:2 for multi-gpu"%COL%[0m
ECHO %COL%[40;95m"  -x                   enable tta mode"%COL%[0m
ECHO %COL%[40;95m"  -f format            output image format (jpg/png/webp, default=ext/png)"%COL%[0m
ECHO.  
SET /P args=%COL%[40;93m"Provide extra arguments for rescaling. Leave empty for waifu2x-ncnn-vulkan default: "%COL%[0m
GOTO WAIFUARGS

:WAIFUARGS
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i "%fileshort%%fileextension%" -o "%fileshort%-argwaifu%fileextension%" %args%
@ECHO OFF
GOTO COMPLETE

:WAIFU
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i "%fileshort%%fileextension%" -o "%fileshort%-cunetwaifu%fileextension%" -n 2 -s 2 -v
@ECHO OFF
GOTO COMPLETE

:WAIFUEXT
ECHO. 
IF /I "%args%" NEQ "all" (ECHO %COL%[106;30m Three commands are about to run in sequence. Please be patient. %COL%[0m)
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i "%fileshort%%fileextension%" -o "%fileshort%-cunetwaifu%fileextension%" -n 2 -s 2 -v
@ECHO OFF
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i "%fileshort%%fileextension%" -o "%fileshort%-animewaifu%fileextension%" -n 2 -s 2 -v -m models-upconv_7_anime_style_art_rgb
@ECHO OFF
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i "%fileshort%%fileextension%" -o "%fileshort%-photowaifu%fileextension%" -n 2 -s 2 -v -m models-upconv_7_photo
@ECHO OFF
IF /I "%args%" EQU "all" (GOTO WAIFUSLOW)
GOTO COMPLETE

:WAIFUSLOW
ECHO. 
IF /I "%args%" NEQ "all" (ECHO %COL%[106;30m Three very slow commands are about to run in sequence. Please be patient. %COL%[0m)
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i "%fileshort%%fileextension%" -o "%fileshort%-ttacunetwaifu%fileextension%" -n 2 -s 2 -v -x
@ECHO OFF
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i "%fileshort%%fileextension%" -o "%fileshort%-ttaanimewaifu%fileextension%" -n 2 -s 2 -v -x -m models-upconv_7_anime_style_art_rgb
@ECHO OFF
ECHO. 
@ECHO ON
waifu2x-ncnn-vulkan -i "%fileshort%%fileextension%" -o "%fileshort%-ttaphotowaifu%fileextension%" -n 2 -s 2 -v -x -m models-upconv_7_photo
@ECHO OFF
GOTO COMPLETE

:WAIFUALL
ECHO. 
ECHO %COL%[106;30m Six commands are about to run in sequence. This will take a while, please be patient. %COL%[0m
ECHO.
GOTO WAIFUEXT

:EXTNOTFOUND
ECHO. 
ECHO %COL%[40;91m%fileshort% exists, but %fileextension% is not correct, please provide the correct file extension.%COL%[0m
ECHO. 
GOTO SETEXTENSION

:NOTFOUND
ECHO. 
ECHO %COL%[40;91mInput file not found, please try again.%COL%[0m
ECHO. 
GOTO FILE

:COMPLETE
ECHO. 
ECHO %COL%[40;92mRescaling complete%COL%[0m
ECHO. 
ENDLOCAL
cmd /k

:STOPPING
ECHO.
ECHO %COL%[40;91mclosing%COL%[0m
ECHO. 
ENDLOCAL
cmd /k
