#!/bin/bash

# Elevate permissions
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

# Header
echo "Dotfiles installer"
echo "by Tim Visee, timvisee.com"
echo

# Install the given file
# $1: Source file to install.
# $2: Destination file relative to home directory.
install_home_file() {
    # Copy
    echo "Installing $2...";
    cp -T $1 ~/$2

    # Return
    return 0
}

# Setup dotfiles
echo "Installing all dotfiles..."
install_home_file ./git/.gitconfig.local .gitconfig.local
install_home_file ./vim/.vimrc .vimrc
install_home_file ./vim/.vimrc .ideavimrc
install_home_file ./fish/config.fish .config/fish/config.fish

# Done
echo
echo "Done"
exit
