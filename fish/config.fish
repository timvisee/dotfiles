# Fish shell configuration

# Alias for TheFuck
eval (thefuck --alias | tr '\n' ';')

# Source the prompt
source ~/.config/fish/prompt.fish

# Add rust binaries to the path
if test -d "$HOME/.cargo/bin"
    set PATH $HOME/.cargo/bin $PATH
end
