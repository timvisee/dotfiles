#!/bin/bash

# Elevate permissions
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

# Header
echo
echo "Dotfiles installer"
echo "by Tim Visee, timvisee.com"
echo

# Log a success message.
# $1: Message.
log_success() {
  # Print a message in green with a checkmark
  printf "\e[0;32m[✔] $1\e[0m\n"
}

# Log an error message.
# $1: Message.
log_error() {
  # Print a message in red with a cross
  printf "\e[0;31m[✖] $1 $2\e[0m\n"
}

# Log a question message.
# $1: Message.
log_question() {
  # Print a message in orange with a question mark
  printf "\e[0;33m[?] $1\e[0m"
}

# Log an info message.
# $1: Message
log_info() {
  # Print an indented message in purple
  printf "\n\e[0;35m    $1\e[0m\n\n"
}

# Log a result message.
# $1: Exit code.
# $2: Message.
# $3: "true" to exit on error.
log_result() {
  [ $1 -eq 0 ] \
    && print_success "$2" \
    || print_error "$2"

  [ "$3" == "true" ] && [ $1 -ne 0 ] && exit
}

# Symlink a dotfile to a file in the dotfiles repository.
# $1: File in repository.
# $2: Target dotfile.
symlink_file() {
	if [[ -e "$2" ]]; then
		echo "Backing up $2 to $2.old..."
		mv "$2" "$2.old"
	fi

	echo "Linking '$1'..."
	ln -s $1 $2

	return 0
}

# Unlink a previously symlinked dotfile.
# $1: File to unlink.
unlink_file() {
	echo "Unlinking '$1'..."
	rm $1

	if [[ -e "$1.old" ]]; then
        echo "Restoring $1.old to $1..."
        mv "$1.old" "$1"
	fi

	return 0
}

# Install the given file.
# $1: Source file to install.
# $2: Destination file relative to home directory.
install_home_file() {
    # Copy
    echo "Installing $2...";
    cp -T $1 ~/$2

    # Return
    return 0
}

# Install dotfiles
echo "Installing all dotfiles..."
install_home_file ./git/.gitconfig.local .gitconfig.local
install_home_file ./vim/.vimrc .vimrc
install_home_file ./vim/.vimrc .ideavimrc
install_home_file ./fish/config.fish .config/fish/config.fish
install_home_file ./fish/prompt.fish .config/fish/prompt.fish
install_home_file ./bash/.bashrc .bashrc
install_home_file ./bash/.bash_profile .bash_profile
install_home_file ./bash/.bash_aliases .bash_aliases

# Done
echo
echo "Done"
exit
