@echo off
if "%~1" NEQ "--no-title" title StrobeOS Installation Script
set errorlevel=0
if exist "%appdata%\Cosmos User Kit\unins000.exe" call "%appdata%\Cosmos User Kit\unins000"
if "%errorlevel%" == "0" goto :installNew
echo Install has failed because there was an error with the uninstaller.
goto :End

:installNew
echo Starting installation of Cosmos...
if exist "cosmos\install-VS2015.bat" goto installreal
echo Cosmos wasn't found!
goto Clone

:Clone
set back=%cd%
cd ..
if not exist "os" cd %back%
if exist "os" rmdir "os" /S /Q
git --version >nul 2>&1 && (
    echo Git found, Trying to git clone...
) || (
    echo Git wasn't found in path.
	goto End
)
git clone https://github.com/StrobeOS/os.git
cd os
git submodule update --init --recursive
goto installNew

:installreal
cd cosmos
call "install-VS2015.bat"
call :waitUntilFinish
echo Installation finished, feel free to modify!
goto End

:waitUntilFinish
echo Waiting installation to finish...
:internal
if exist "%appdata%\Cosmos User Kit\unins000.exe" goto out
timeout /nobreak /t 1 > nul
goto internal
:out
goto realEnd

:End
pause
:realEnd