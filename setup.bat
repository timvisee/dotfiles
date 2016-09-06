@ECHO OFF
SETLOCAL

:: Header
TITLE Dotfiles setup
@ECHO Dotfiles setup
@ECHO.

:: Copy dotfiles
@ECHO Setting up all dotfiles...
CALL :CompileFile .\git\.gitconfig.local .gitconfig.local
CALL :CompileFile .\vim\.vimrc .vimrc
CALL :CompileFile .\vim\.vimrc .ideavimrc

:: Done
@ECHO.
@ECHO Done
EXIT

:: Set up the given file
:: %1: Source file to set up.
:: %2: Destination file relative to user profile.
:CompileFile
@ECHO Setting up %2
COPY /V /Y %1 "%USERPROFILE%\%2" > NUL
GOTO:EOF
