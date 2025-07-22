@echo off
rem Obtained from https://github.com/agurwicz/scripts.

if "%1" == "-h" (
    echo Creates a Python environment.
    echo Usage: %~n0 environment_name python_version [-a]
    echo    environment_name    name of the environment to be created
    echo    python_version      python version of the environment e.g. 3.9, 3.12
    echo    -a, optional        activate the environment after creation
    goto :eof
)

set "scripts_path=%~dp0\.commonscripts.bat"
call %scripts_path% || exit /b 0

set "environment_name=%1"
set "python_version=%2"
set "activate=%3"

call %scripts_path% :check_variables python_environments_path python_versions_path python_relative_path activate_relative_path environment_name python_version || exit /b 0

call %scripts_path% :assert_environment_not_exist %environment_name% || exit /b 0

call "%python_versions_path%\Python%python_version:.=%\python.exe" -m venv "%python_environments_path%\%environment_name%"
call "%~dp0\installpackages.bat" "pip setuptools wheel" "%environment_name%" %activate%
