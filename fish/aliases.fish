# Fish shell configuration

# Alias for TheFuck
eval (thefuck --alias | tr '\n' ';')

# Alias to support tmux colors
alias tmux='tmux -2'

# Create the composer alias if it exists
if test -e "/usr/local/bin/composer.phar"
    alias composer="php /usr/local/bin/composer.phar"
end

# Aliases to hide and show hidden files on macOS
switch (uname)
    case Darwin
        alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
        alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
end
