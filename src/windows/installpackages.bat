@echo off
rem Obtained from https://github.com/agurwicz/scripts.

if "%~1" == "-h" (
    echo Installs and upgrades packages in a Python environment.
    echo Usage: %~n0 "packages" [environment_name] [-a]
    echo    packages                      list of packages to install and upgrade ^(accepts versions with "package==version"^)
    echo    environment_name, optional    name of the environment to install in ^(default: currently active environment^)
    echo    -a, optional                  activate the environment after installation
    goto :eof
)

set "scripts_path=%~dp0\.commonscripts.bat"
call %scripts_path% || exit /b 0

set "packages=%~1"
set "environment_name=%~2"
set "activate=%~3"

if not "%environment_name%" == "" (
    call %scripts_path% :check_variables python_environments_path python_relative_path environment_name || exit /b 0
    call %scripts_path% :assert_environment_exist %environment_name% || exit /b 0
    set "python_path=%python_environments_path%\%environment_name%\%python_relative_path%"
) else (
    set "python_path=python.exe"
)

call "%python_path%" -m pip install --upgrade --no-cache-dir %packages%

if "%activate%" == "-a" (
    call "%~dp0\activateenv.bat" %environment_name%
)
