#!/bin/bash

# Header
echo "dotfiles installation"
echo

# Set up the given file
# $1: Source file to set up.
# $2: Destination file relative to home directory.
setup_home_file() {
    # Copy
    echo "Setting up $1";
    /bin/cp -T $1 ~/$2

    # Return
    return 0
}

# Setup dotfiles
echo "Setting up all dotfiles..."
setup_home_file ./git/.gitconfig.local .gitconfig.local
setup_home_file ./vim/.vimrc .vimrc
setup_home_file ./vim/.vimrc .ideavimrc

# Done
echo
echo "Done"
exit
