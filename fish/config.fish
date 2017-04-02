# Fish shell configuration

# Alias for TheFuck
eval (thefuck --alias | tr '\n' ';')

# Source other configuration files
source ~/.config/fish/nvm.fish
source ~/.config/fish/prompt.fish
source ~/.config/fish/transfer.fish

# Add rust binaries to the path
if test -d "$HOME/.cargo/bin"
    set PATH $HOME/.cargo/bin $PATH
end
