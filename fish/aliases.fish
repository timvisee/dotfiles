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
    alias v 'nvim'
    alias vi 'nvim'
    alias vim 'nvim'
    alias nvi 'nvim'
else
    alias v 'vim'
    alias vi 'vim'
    alias nvi 'vim'
end

# neomutt and mutt aliases
if test -x "/usr/bin/neomutt"; or test -x "/usr/bin/local/neomutt"
    alias m 'neomutt'
    alias mutt 'neomutt'
else
    alias m 'mutt'
end

# Exa alias
alias e 'exa'
alias ela 'exa -lab --git'

# Ranger alias
alias r 'ranger'

# Pass aliases
alias p 'prs show --verbose --timeout 20'
alias pc 'prs copy'

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
alias gll "git -c core.pager='less -p^commit.*\$' log -p -M -w --stat --pretty=fuller --show-notes"
alias glg 'git log --pretty="format:%Cred%h %Cblue%d %Cgreen%s %Creset%an %ar" --graph'
alias gf 'git fetch'
alias gfm 'git pull'
alias gr 'git remote'
alias grr 'git reset'
alias grrh 'git reset --hard'
alias gt 'git tag'
alias git_clean_repo 'git clean -dfx'

# Docker
alias d 'docker'
alias dc 'docker-compose'

# Clipboard aliases
if [ (uname -s) = "Darwin" ]
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
alias cu 'cargo update'

# Free memory cache and swap
alias drop_cache 'sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a"'

# Create the composer alias if it exists
if test -e '/usr/local/bin/composer.phar'
    alias composer 'php /usr/local/bin/composer.phar'
end

# Aliases to hide and show hidden files on macOS
if [ (uname -s) = "Darwin" ]
    alias showFiles 'echo "Showing files..."; defaults write com.apple.finder AppleShowAllFiles YES; sleep 1; killall Finder; /System/Library/CoreServices/Finder.app; echo "Done"'
    alias hideFiles 'echo "Hiding files..."; defaults write com.apple.finder AppleShowAllFiles NO; sleep 1; killall Finder /System/Library/CoreServices/Finder.app; echo "Done"'
end
