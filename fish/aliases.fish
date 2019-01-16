# Fish shell configuration

# Grep aliases
alias grep 'grep --color=auto'
alias grepi 'grep -i --color=auto'
alias fgrep 'fgrep --color=auto'
alias egrep 'egrep --color=auto'

# Shell exit alias
alias q 'exit'
alias :q 'exit'

# Nvim and vim aliases
if test -x "/usr/bin/nvim"; or test -x "/usr/bin/local/nvim"
    alias vi 'nvim'
    alias vim 'nvim'
    alias nvi 'nvim'
else
    alias vi 'vim'
    alias nvi 'vim'
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
alias g 'git'
alias ga 'git add'
alias ga. 'git add .'
alias gap 'git add --patch'
alias gapn 'git add --intent-to-add .; and git add --patch'
alias gb 'git branch'
alias gc 'git commit'
alias gca 'git commit --amend'
alias gp 'git push'
alias gs 'git status'
alias gd 'git diff'
alias gl 'git log'
alias gf 'git fetch'
alias gfp 'git fetch; and git pull'
alias gt 'git tag'

# Clipboard aliases
if [ `uname -s` = "Darwin" ]
    alias getclip 'pbpaste'
    alias setclip 'pbcopy'
else
    alias getclip 'xclip -selection c -o'
    alias setclip 'xclip -selection c'
end

# Tmux alias
alias tmux 'tmux -u -2'
alias tl 'tmux -u -2 ls'
function ta
    tmux -u -2 attach $argv; or tmux
end
function tn
    tmux -u -2 new -s $argv; or tmux
end

# Cargo aliases
alias cr 'cargo run'
alias crr 'cargo run --release'
alias cb 'cargo build'
alias cbr 'cargo build --release'
alias cc 'cargo check'
alias ct 'cargo test'

# Create the composer alias if it exists
if test -e '/usr/local/bin/composer.phar'
    alias composer 'php /usr/local/bin/composer.phar'
end

# Aliases to hide and show hidden files on macOS
if [ `uname -s` = "Darwin" ]
    alias showFiles 'echo "Showing files..."; defaults write com.apple.finder AppleShowAllFiles YES; sleep 1; killall Finder; /System/Library/CoreServices/Finder.app; echo "Done"'
    alias hideFiles 'echo "Hiding files..."; defaults write com.apple.finder AppleShowAllFiles NO; sleep 1; killall Finder /System/Library/CoreServices/Finder.app; echo "Done"'
end
