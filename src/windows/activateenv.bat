@echo off
rem Obtained from https://github.com/agurwicz/scripts

if "%1" == "-h" (
    echo Activates a Python environment.
    echo Usage: %~n0 environment_name
    echo    environment_name    name of the environment to be activated
    goto :eof
)

set "scripts_path=%~dp0\.commonscripts.bat"
call %scripts_path% || exit /b 0

set "environment_name=%1"

call %scripts_path% :check_variables python_environments_path python_relative_path activate_relative_path environment_name || exit /b 0
call %scripts_path% :assert_environment_exist %environment_name% || exit /b 0

call %python_environments_path%\%environment_name%\%activate_relative_path%
