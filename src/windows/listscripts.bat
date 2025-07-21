@echo off
rem Obtained from https://github.com/agurwicz/scripts.

if "%1" == "-h" (
    echo Lists the scripts available.
    echo Usage: %~n0
    goto :eof
)

set "scripts_path=%~dp0\.commonscripts.bat"
call %scripts_path% || exit /b 0

rem Removing directories, files starting with "." and files not ending in ".bat".
for /f "delims=" %%A in ('dir /b /a-d "%~dp0*.bat" ^| findstr /v /r "^\."') do (
    echo %%~nA
)
