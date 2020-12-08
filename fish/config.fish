# Fish shell configuration

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

# Add rust binaries to the path
if test -d "$HOME/.cargo/bin"
    set PATH $HOME/.cargo/bin $PATH
end

# Add the rust source path to the path
if test -x "~/.cargo/bin/rustc"
    set RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src
    if test -d $RUST_SRC_PATH
        export RUST_SRC_PATH
    end
end

# Configure Go's environment
if test -d "/usr/local/go/bin"
    set -x GOROOT /usr/local/go
    set -x GOPATH $HOME/.go
    set -x PATH $PATH $GOROOT/bin
else if test -d "/usr/lib/go"
    set -x GOROOT /usr/lib/go
    set -x GOPATH $HOME/.go
    set -x PATH $PATH $GOROOT/bin
end

# Configure composer
if test -d "$HOME/.composer/vendor/bin"
    set -x PATH $PATH $HOME/.composer/vendor/bin
end

# Configure keychain if installed
if test -e keychain
    # Initialize if no SSH agent has been initialized by us
    # ; or test -z $SSH_AGENT_PID; or test -z (keychain -l); and test -e ~/.ssh/id_rsa
    if test -z $SSH_AGENT_INIT; or test -z $SSH_AGENT_PID
        echo "Initializing keychain..."
        keychain --agents ssh id_rsa
        set -Ux SSH_AGENT_INIT 1
    end

    # Import the current keychain environment
    set SSH_AGENT_ENV $HOME/.keychain/(hostname)-fish
    test -f $SSH_AGENT_ENV
    and source $SSH_AGENT_ENV
end

# Set the preferred editor
set -x EDITOR vim

# GPG key
set -x GPG_TTY (tty)
