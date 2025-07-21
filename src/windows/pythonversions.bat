@echo off
rem Obtained from https://github.com/agurwicz/scripts

if "%1" == "-h" (
    echo Lists all Python versions available.
    echo Usage: %~n0
    goto :eof
)

set "scripts_path=%~dp0\.commonscripts.bat"
call %scripts_path% || exit /b 0

call %scripts_path% :check_variables python_versions_path || exit /b 0

setlocal enabledelayedexpansion
for /f "delims=" %%A in ('dir /b /ad "%python_versions_path%"') do (
    if exist "%python_versions_path%\%%A\python.exe" (
        set "python_version=%%A"
        set "python_version=!python_version:Python=!"
        echo !python_version!
    )
)
endlocal
