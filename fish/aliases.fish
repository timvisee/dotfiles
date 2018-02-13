# Fish shell configuration

# Shell exit alias
alias q 'exit'

# Alias to support tmux colors
alias tmux 'tmux -2'

# Exa alias
alias e 'exa'
alias ela 'exa -la'

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
alias gc 'git commit'
alias gs 'git status'
alias gp 'git push'

# Clipboard aliases
alias getclip 'xclip -selection c -o'
alias setclip 'xclip -selection c'

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
