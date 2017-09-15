# Fish shell configuration

# Source other configuration files
source ~/.config/fish/aliases.fish
source ~/.config/fish/nvm.fish
source ~/.config/fish/prompt.fish
source ~/.config/fish/transfer.fish

# Disable fish greeting
set fish_greeting

# Add rust binaries to the path
if test -d "$HOME/.cargo/bin"
    set PATH $HOME/.cargo/bin $PATH
end

# Configure Go's environment
if test -d "/usr/lib/go"
    set -x GOROOT /usr/lib/go
    set -x GOPATH $HOME/.go
    set -x PATH $PATH $GOROOT/bin
end

# Configure composer
if test -d "$HOME/.composer/vendor/bin"
    set -x PATH $PATH $HOME/.composer/vendor/bin
end

# Set the preferred editor
set -x EDITOR vim
