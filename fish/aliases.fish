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
if command -qv nvim
    abbr v 'nvim'
    abbr vi 'nvim'
    abbr vim 'nvim'
    abbr nvi 'nvim'
else
    abbr v 'vim'
    abbr vi 'vim'
    abbr nvi 'vim'
end

# Eza/exa alias
if command -qv eza
    abbr e 'eza'
    abbr ela 'eza -lab --git'
else
    abbr e 'exa'
    abbr ela 'exa -lab --git'
end

# Ranger alias
abbr r 'ranger'

# Pass aliases
abbr p 'prs show --verbose --timeout 20'
abbr pc 'prs copy'

# Git aliases
abbr g 'git'
abbr ga 'git add'
abbr ga. 'git add .'
abbr gap 'git add --patch'
abbr gapn 'git add --intent-to-add .; and git add --patch'
abbr gb 'git branch'
abbr gc 'git commit'
abbr gca 'git commit --amend'
abbr gp 'git push'
abbr gpf 'git push --force-with-lease'
abbr gs 'git status'
abbr gd 'git diff'
abbr gl 'git log'
abbr gll "git -c core.pager='less -p^commit.*\$' log -p -M -w --stat --pretty=fuller --show-notes"
abbr glg 'git log --pretty="format:%Cred%h %Cblue%d %Cgreen%s %Creset%an %ar" --graph'
abbr gf 'git fetch'
abbr gfm 'git pull'
abbr gr 'git rebase'
abbr grc 'git rebase --continue'
abbr grr 'git reset'
abbr grrh 'git reset --hard'
abbr gt 'git tag'
abbr git_clean_repo 'git clean -dfx'

# Docker
abbr d 'docker'
abbr dc 'docker-compose'

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
abbr cr 'cargo run'
abbr crr 'cargo run --release'
abbr cb 'cargo build'
abbr cbr 'cargo build --release'
abbr cc 'cargo check'
abbr ct 'cargo test'
abbr cu 'cargo update'

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

alias stripcolors 'sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g"'
