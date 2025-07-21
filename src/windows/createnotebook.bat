@echo off
rem Obtained from https://github.com/agurwicz/scripts

if "%1" == "-h" (
    echo Creates empty Jupyter Notebook in %%CD%%.
    echo Usage: %~n0 notebook_name 
    echo    notebook_name    name of the notebook to be created
    goto :eof
)

set "scripts_path=%~dp0\.commonscripts.bat"
call %scripts_path% || exit /b 0

set "notebook_name=%1"

call %scripts_path% :check_variables notebook_name || exit /b 0

set "notebook_path=%CD%\%notebook_name%.ipynb"

(echo {"cells": [], "metadata": {"kernelspec": {"display_name": "Python 3 (ipykernel)", "language": "python", "name": "python3"}}, "nbformat": 4, "nbformat_minor": 5}) > "%notebook_path%"
