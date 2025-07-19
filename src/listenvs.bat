@echo off
rem Obtained from https://github.com/agurwicz/scripts

if "%1" == "-h" (
    echo Lists all Python environments.
    echo Usage: %~n0
    goto :eof
)

set "scripts_path=%~dp0\.commonscripts.bat"
call %scripts_path% || exit /b 0
call %scripts_path% :check_variables python_environments_path python_relative_path || exit /b 0

setlocal enabledelayedexpansion
for /f "delims= " %%A in ('dir /b "%python_environments_path%"') do (

    set "python_path=%python_environments_path%\%%A\%python_relative_path%"
    for /f "tokens=2 delims= " %%B in ('"!python_path!" --version') do (
        set "python_version=%%B"
    )

    echo %%A: !python_version!
)
endlocal
