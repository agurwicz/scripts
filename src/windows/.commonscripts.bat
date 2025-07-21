@echo off
rem Obtained from https://github.com/agurwicz/scripts.

if "%~1" == "" (     

    for /F "usebackq tokens=1,2 delims==" %%A in ("%~dp0\variables.txt") do (
        set "%%A=%%B"
    )

    set "python_relative_path=Scripts\python.exe"        
    set "activate_relative_path=Scripts\activate.bat"

) else (

    call :%~1 %*
    if errorlevel 1 (
        exit /b 1        
    )

)
goto :eof

:check_variables    
    
    setlocal enabledelayedexpansion    
    for %%A in (%*) do (
        if not :%%A == %0 (
            if !%%A! == "" (
                echo Error: Variable "%%A" is not defined.
                endlocal
                exit /b 1
            )
            if not defined %%A (
                echo Error: Variable "%%A" is not defined.
                endlocal
                exit /b 1
            )
        )
    )
    endlocal

goto :eof

:assert_environment_exist
    
    set "python_path=%python_environments_path%\%2\%python_relative_path%"
    set "activate_path=%python_environments_path%\%2\%activate_relative_path%"

    if not exist %python_path% (
        echo Error: Environment "%2" does not exist.
        exit /b 1
    )
    if not exist %activate_path% (
        echo Error: Environment "%2" does not exist.
        exit /b 1
    )

goto :eof

:assert_environment_not_exist
    
    set "python_path=%python_environments_path%\%2\%python_relative_path%"
    set "activate_path=%python_environments_path%\%2\%activate_relative_path%"

    if exist %python_path% (
        echo Error: Environment "%2" already exists.
        exit /b 1
    )
    if exist %activate_path% (
        echo Error: Environment "%2" already exists.
        exit /b 1
    )

goto :eof
