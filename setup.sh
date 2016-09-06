#!/usr/bin/env bash

# Header
echo "Dotfiles setup"
echo

# Set up the given file
# $1: Source file to set up.
# $2: Destination file relative to home directory.
function setup_file {
    # Copy
    echo "Setting up $1";
    /bin/cp -T $1 ~/$2

    # Return
    return 0
}

# Copy dotfiles
echo "Setting up all dotfiles..."
setup_file .\git\.gitconfig.local .gitconfig.local
setup_file .\vim\.vimrc .vimrc
setup_file .\vim\.vimrc .ideavimrc

# Done
echo
echo "Done"
exit
