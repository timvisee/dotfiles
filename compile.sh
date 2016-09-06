#!/usr/bin/env bash

# Header
echo "Dot files compiler"
echo

# Compile the given file and copy it's to it's proper directory
# $1: Source file to compile.
# $2: Destination file relative to home directory.
function compile_file {
    # Copy
    echo "Compiling $1";
    /bin/cp -T $1 ~/$2

    # Return
    return 0
}

# Copy dotfiles
echo "Compile and copy all dotfiles..."
compile_file .\git\.gitconfig.local .gitconfig.local
compile_file .\vim\.vimrc .vimrc
compile_file .\vim\.vimrc .ideavimrc

# Done
echo
echo "Done"
exit
