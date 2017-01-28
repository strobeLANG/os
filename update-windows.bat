@echo off
:: The Strobe update script
title StrobeOS Update Script

:: Check for git
git --version >nul 2>&1 && (
    echo Git found, Trying to update...
) || (
    echo Git wasn't found in path.
	goto End
)

:: Update the repo
git pull

:: Update the modules
git submodule update --recursive --remote

:: Install the current files
call install-current.bat --no-title
goto End

:: Pause end
:End
pause
