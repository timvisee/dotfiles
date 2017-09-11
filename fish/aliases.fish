# Fish shell configuration

# Alias for TheFuck
eval (thefuck --alias | tr '\n' ';')

# Alias to support tmux colors
alias tmux='tmux -2'

# Create the composer alias if it exists
if test -e "/usr/local/bin/composer.phar"
    alias composer="php /usr/local/bin/composer.phar"
end
