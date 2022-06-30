@echo off
setlocal EnableDelayedExpansion

rem Find working directory
set "WD=%__CD__%"
if NOT EXIST "%WD%msys-2.0.dll" set "WD=%~dp0usr\bin\"

rem Set login shell
set LOGINSHELL=zsh

rem Activate windows native symlinks
set MSYS=winsymlinks:nativestrict

rem Set shell type
set MSYSTEM=MSYS

rem Set console type
set MSYSCON=

rem Set PATH type
set MSYS2_PATH_TYPE=inherit

rem Use current directory as working directory
set CHERE_INVOKING=enabled_from_arguments

rem Setup title and icon
set "CONTITLE=HarperShell"
set "CONICON=msys2.ico"

set HOME=%HOMEDRIVE%%HOMEPATH%

"%WD%\%LOGINSHELL%" --login
exit /b 0
