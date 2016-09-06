:: Clear the console
@ECHO OFF
SETLOCAL
CLS

:: Set the console title
TITLE Dotfiles compiler
@ECHO Dotfiles compiler
@ECHO.

:: Copy dotfiles
@ECHO Compile and copy all dotfiles...
CALL :CompileFile .\git\.gitconfig.local .gitconfig.local
CALL :CompileFile .\vim\.vimrc .vimrc
CALL :CompileFile .\vim\.vimrc .ideavimrc

:: Done
@ECHO.
@ECHO Done
EXIT

:: Compile the given file and move it to it's proper directory
:: %1: Source file to compile.
:: %2: Destination file relative to user profile.
:CompileFile
@ECHO Compiling %2
COPY /V /Y %1 "%USERPROFILE%\%2" > NUL
GOTO:EOF
