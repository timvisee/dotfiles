# Fish shell configuration

# Set some variables
set -x EDITOR vim
set -x GPG_TTY (tty)

# Add PATHs
set PATH $HOME/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH $HOME/.composer/vendor/bin:$PATH

# Source other configuration files
source ~/.config/fish/aliases.fish
source ~/.config/fish/nvm.fish

# Prompt
if test -x (which starship)
    eval (starship init fish)
else
    source ~/.config/fish/prompt.fish
end

# Disable fish greeting
set fish_greeting

# Enable VI mode
fish_vi_key_bindings

# Set-up keychain
test -e keychain && eval (keychain --eval --quiet --agents ssh,gpg id_rsa)

# Set-up Rust environment
test -f ~/.cargo/env && . ~/.cargo/env
