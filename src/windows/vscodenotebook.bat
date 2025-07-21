@echo off
rem Obtained from https://github.com/agurwicz/scripts

if "%1" == "-h" (
    echo Creates empty Jupyter Notebook in %%CD%% and opens in Visual Studio Code.
    echo Usage: %~n0 notebook_name 
    echo    notebook_name    name of the notebook to be created
    goto :eof
)

set "scripts_path=%~dp0\.commonscripts.bat"
call %scripts_path% || exit /b 0

set "notebook_name=%1"

call %scripts_path% :check_variables vscode_path notebook_name || exit /b 0

call "%~dp0\createnotebook.bat" %notebook_name%
start "" "%vscode_path%" "%notebook_path%"
