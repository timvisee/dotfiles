@ECHO OFF
SETLOCAL

:: Header
TITLE Dotfiles installer
@ECHO Dotfiles installer
@ECHO by Tim Visee, timvisee.com
@ECHO.

:: Setup dotfiles
@ECHO Installing all dotfiles...
CALL :InstallHomeFile .\git\.gitconfig.local .gitconfig.local
CALL :InstallHomeFile .\vim\.vimrc .vimrc
CALL :InstallHomeFile .\vim\.vimrc .ideavimrc

:: Done
@ECHO.
@ECHO Done
EXIT

:: Set up the given file
:: %1: Source file to set up.
:: %2: Destination file relative to user profile.
:InstallHomeFile
@ECHO Installing %2...
COPY /V /Y %1 "%USERPROFILE%\%2" > NUL
GOTO:EOF
