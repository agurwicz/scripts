@echo off
rem Obtained from https://github.com/agurwicz/scripts

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

call %scripts_path% :check_variables python_environments_path python_versions_path python_relative_path activate_relative_path environment_name python_version || exit /b 0

call %scripts_path% :assert_environment_not_exist %environment_name% || exit /b 0

set "packages_to_install=pip setuptools wheel"
set "environment_path=%python_environments_path%\%environment_name%"

call "%python_versions_path%\Python%python_version:.=%\python.exe" -m venv "%environment_path%"
call "%environment_path%\%python_relative_path%" -m pip install --upgrade %packages_to_install%

if "%3" == "-a" (
    call "%~dp0\activateenv.bat" %environment_name%
)
