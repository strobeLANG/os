@echo off
:: Check if no-title has been switched on.
if "%~1" NEQ "--no-title" title StrobeOS Installation Script

:: Check if Cosmos has been installed, if true, uninstall it.
set errorlevel=0
if exist "%appdata%\Cosmos User Kit\unins000.exe" call "%appdata%\Cosmos User Kit\unins000"
if "%errorlevel%" == "0" goto :installNew
echo Install has failed because there was an error with the uninstaller.
goto :End


:installNew
:: Check if the Cosmos installation files are there, if they are, install them.
echo Starting installation of Cosmos...
if exist "cosmos\install-VS2015.bat" goto installreal

:: If not, clone the git repo and get them.
echo Cosmos wasn't found!
goto Clone

:Clone
:: Check for the "os" folder and delete it.
set back=%cd%
cd ..
if not exist "os" cd %back%
if exist "os" rmdir "os" /S /Q

:: Check for git
git --version >nul 2>&1 && (
    echo Git found, Trying to git clone...
) || (
    echo Git wasn't found in path.
	goto End
)

:: Clone and update the submodules
git clone https://github.com/StrobeOS/os.git
cd os
git submodule update --init --recursive

:: Go back to the installer
goto installNew

:installreal
:: Actually install cosmos
cd cosmos
call "install-VS2015.bat"
call :waitUntilFinish

:: End the program
echo Installation finished, feel free to modify!
goto End

:waitUntilFinish
:: Wait untill finish, not really working, but that's what i got.
echo Waiting installation to finish...
:internal
:: Check for the uninstaller.
if exist "%appdata%\Cosmos User Kit\unins000.exe" goto out
timeout /nobreak /t 1 > nul
:: Loop.
goto internal
:out
:: Go to the real end
goto realEnd

:: The pause end
:End
pause

:: The real end
:realEnd
