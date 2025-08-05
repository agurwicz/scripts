@echo off
rem Obtained from https://github.com/agurwicz/scripts.

set command=

rem This currently requires the user to have set up to run Python without calling `python`.
for /f "delims=" %%i in ('"%~dp0\_activateenv.py" %*') do (
    set "command=%%i"
)

if defined command ( 
    call %command%
)
