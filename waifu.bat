@ECHO OFF
SETLOCAL
IF "%~1"=="" (GOTO FILE) ELSE (GOTO DECLARE)

:DECLARE
SET file=%1
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
IF "%fileextension%"=="" (GOTO TESTEXTENSION) ELSE (GOTO CHECKEXIST)

:TESTEXTENSION
IF EXIST %filedrive%%filepath%%filename%.jpg IF EXIST %filedrive%%filepath%%filename%.png (GOTO SETEXTENSION)
IF EXIST %filedrive%%filepath%%filename%.jpg (SET fileextension=.jpg)
IF EXIST %filedrive%%filepath%%filename%.png (SET fileextension=.png)
IF EXIST %filedrive%%filepath%%filename% (GOTO SETEXTENSION) ELSE (GOTO NOTFOUND)
GOTO CHECKEXIST

:SETEXTENSION
SET /P fileextension=Provide the file extension: 
IF %fileextension:~0,1%==. (GOTO CHECKEXIST) ELSE (GOTO FIXEXTENSION)

:FIXEXTENSION
SET fileextension=.%fileextension%
GOTO CHECKEXIST

:CHECKEXIST
IF NOT EXIST "%filedrive%%filepath%%filename%%fileextension%" (GOTO EXTNOTFOUND)
IF EXIST "%filedrive%%filepath%%filename%-waifu%fileextension%" (GOTO EXISTS) ELSE (GOTO WAIFUCHECK)

:EXISTS
ECHO %filedrive%%filepath%%filename%-waifu%fileextension% already exists.
SET /P exists=Do you wish to overwrite the file (Y/N)?
IF /I "%exists%" NEQ "Y" (GOTO STOPPING) ELSE (GOTO WAIFUCHECK)

:WAIFUCHECK
IF "%~2"=="" (GOTO WAIFU)
SET /P args="Provide extra arguments for rescaling. Leave empty for waifu2x-ncnn-vulkan default: "
GOTO WAIFUARGS

:WAIFUARGS
ECHO "Free arguments enabled, please add the arguments you wish to enable for this rescaling"
ECHO "File output path is set in stone"
ECHO "  -v                   verbose output"
ECHO "  -n noise-level       denoise level (-1/0/1/2/3, default=0)"
ECHO "  -s scale             upscale ratio (1/2, default=2)"
ECHO "  -t tile-size         tile size (>=32/0=auto, default=0) can be 0,0,0 for multi-gpu"
ECHO "  -m model-path        waifu2x model path (default=models-cunet)"
ECHO "  -g gpu-id            gpu device to use (default=0) can be 0,1,2 for multi-gpu"
ECHO "  -j load:proc:save    thread count for load/proc/save (default=1:2:2) can be 1:2,2,2:2 for multi-gpu"
ECHO "  -x                   enable tta mode"
ECHO "  -f format            output image format (jpg/png/webp, default=ext/png)"
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-waifu%fileextension% %args%
@ECHO OFF
cmd /k

:WAIFU
@ECHO ON
waifu2x-ncnn-vulkan -i %filedrive%%filepath%%filename%%fileextension% -o %filedrive%%filepath%%filename%-waifu%fileextension% -n 2 -s 2 -v
@ECHO OFF
cmd /k

:EXTNOTFOUND
ECHO %filedrive%%filepath%%filename% exists, but %fileextension% is not correct, please provide the correct file extension.
GOTO SETEXTENSION

:NOTFOUND
ECHO Input file not found, please try again.
GOTO FILE

:STOPPING
ECHO closing
cmd /k