@echo off
rem Obtained from https://github.com/agurwicz/scripts

if "%1" == "-h" (
    echo Opens a script in %%PATH%%.
    echo Usage: %~n0 script_name
    echo    script_name    name of the script to open
    goto :eof
)

set "scripts_path=%~dp0\.commonscripts.bat"
call %scripts_path% || exit /b 0

set "script_name=%1"

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

setlocal enabledelayedexpansion

set "txt_extension=.txt"

set "registry_txt_path=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%txt_extension%\UserChoice"
for /f "tokens=3 delims= " %%A in ('reg query "%registry_txt_path%" /v ProgId 2^>nul ^| findstr /i "ProgId"') do (
    set "program_key=%%A"
)

if not defined program_key (    
    for /f "tokens=2 delims==" %%A in ('assoc !txt_extension! 2^>nul') do ( 
        set "program_key=%%A"
    )
)

rem Falling back to Notepad if default program not found.
if not defined program_key (
    start "" "notepad" "%script_path%"
    exit /b 0
)

set "registry_txt_open_path=HKEY_CLASSES_ROOT\!program_key!\shell\open\command"
for /f "tokens=2,*" %%A in ('reg query "!registry_txt_open_path!" /ve 2^>nul ^| findstr /i "REG_SZ"') do (
    set txt_open_command=%%B
)

set txt_open_command=%txt_open_command: "%1"=%
set txt_open_command=%txt_open_command: %1=%

start "" %txt_open_command% "%script_path%"

endlocal
