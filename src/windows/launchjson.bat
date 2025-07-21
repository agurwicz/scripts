@echo off
rem Obtained from https://github.com/agurwicz/scripts.

if "%1" == "-h" (
    echo Creates "launch.json" file for Visual Studio Code with default configuration.
    echo Usage: %~n0 [environment_name] [main_relative_path]
    echo    environment_name      name of the environment to be activated ^(default: "general"^)
    echo    main_relative_path    path of the main file relative to %%CD%% ^(default: "main.py"^)
    goto :eof
)

set "scripts_path=%~dp0\.commonscripts.bat"
call %scripts_path% || exit /b 0

set "environment_name=%~1"
if "%environment_name%"=="" set "environment_name=general"

set "main_relative_path=%~2"
if "%main_relative_path%"=="" set "main_relative_path=main.py"

call %scripts_path% :check_variables python_environments_path python_relative_path || exit /b 0

set "vscode_directory=%CD%\.vscode"
set "launch_file=%vscode_directory%\launch.json"

if not exist "%vscode_directory%" mkdir "%vscode_directory%"
(
    echo {
    echo     "version": "0.2.0",
    echo     "configurations": [
    echo         {
    echo             "name": "main",
    echo             "program": "${workspaceFolder}\%main_relative_path%",
    echo             "python": "%python_environments_path%\%environment_name%\%python_relative_path%",
    echo             "type": "debugpy",
    echo             "request": "launch",
    echo             "console": "internalConsole",
    echo             "internalConsoleOptions": "openOnSessionStart"
    echo         }
    echo     ]
    echo }
) > "%launch_file%"
