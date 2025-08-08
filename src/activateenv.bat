@echo off
rem Obtained from https://github.com/agurwicz/scripts.

rem Checking for Python in PATH, ensuring it's not the Windows placeholder.
set python_path=
for /f "delims=" %%p in ('where python 2^>nul') do (
    echo %%p | find /i "Microsoft\WindowsApps" >nul
    if errorlevel 1 (
        set "python_path=%%p"
        goto :found
    )
)
echo [31mException: [0mPython not found in %%PATH%%.
goto :eof

:found
set command=
for /f "delims=" %%i in ('call "%python_path%" "%~dp0\_activateenv.py" %*') do (
    set "command=%%i"
)
if defined command (
    call %command%
)
