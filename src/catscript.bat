@echo off
rem Obtained from https://github.com/agurwicz/scripts

if "%1" == "-h" (
    echo Prints the content of a script in %%PATH%%.
    echo Usage: %~n0 script_name
    echo    script_name    name of the script to print
    goto :eof
)

set "scripts_path=%~dp0\.commonscripts.bat"
call %scripts_path% || exit /b 0

set "script_name=%1"

call %scripts_path% :check_variables script_name || exit /b 0

set "script_path="
for /f "delims=" %%A in ('where %script_name% 2^>nul') do ( 
    set "script_path=%%A"
    rem Getting just the first value returned by `where`.
    goto done
)
:done

if "%script_path%"=="" (
    echo Error: Script not found.
    exit /b 0
)

call type "%script_path%"
