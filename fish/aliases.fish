# Fish shell configuration

# Shell exit alias
alias q 'exit'
alias :q 'exit'

# Nvim and vim aliases
# TODO: explicitly check whether the command is invokable from the current context
if test -x "/usr/bin/nvm"
    alias vi 'nvim'
    alias vim 'nvim'
    alias nvi 'nvim'
else
    alias vi 'vim'
    alias nvi 'vim'
    alias nvim 'vim'
end

# Exa alias
alias e 'exa'
alias ela 'exa -lab --git'

# Ranger alias
alias r 'ranger'

# Make a directory and change to it
function mkcd
    # Make the directory
    mkdir $argv

    # Change to the newly created directory
    cd $argv
end

# Git aliases
alias ga 'git add'
alias gb 'git branch'
alias gc 'git commit'
alias gp 'git push'
alias gs 'git status'
alias gfp 'git fetch; and git pull'

# Clipboard aliases
alias getclip 'xclip -selection c -o'
alias setclip 'xclip -selection c'

# Tmux alias
alias tmux 'tmux -u -2'
alias ta 'tmux -u -2 attach'
alias tl 'tmux -u -2 ls'
alias tn 'tmux -u -2 new -s'

# Cargo aliases
alias cr 'cargo run'

# Create the composer alias if it exists
if test -e '/usr/local/bin/composer.phar'
    alias composer 'php /usr/local/bin/composer.phar'
end

# Aliases to hide and show hidden files on macOS
switch (uname)
    case Darwin
        alias showFiles 'echo "Showing files..."; defaults write com.apple.finder AppleShowAllFiles YES; sleep 1; killall Finder; /System/Library/CoreServices/Finder.app; echo "Done"'
        alias hideFiles 'echo "Hiding files..."; defaults write com.apple.finder AppleShowAllFiles NO; sleep 1; killall Finder /System/Library/CoreServices/Finder.app; echo "Done"'
end
