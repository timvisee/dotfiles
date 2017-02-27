""" General
" We're using Vim, not Vi
set nocompatible

" We've a fast terminal
set ttyfast

" Detect file types and specific indents/settings
filetype on
filetype indent on
filetype plugin on



""" Appearance
" Syntax highlighting
syntax enable

" Dark interface
set background=dark

" Enable 256-color mode for terminals
set t_Co=256

" Relative line numbers
set relativenumber
set number

" Line number on the bar
set ruler

" Highlight the current line
set cul
"hi CursorLine term=none cterm=none ctermbg=3 " Highlight color

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" Color rows that have lines longer than 81 columns, lines shouldn't be that
" long
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\v%81v', 100)

" Highlight matching brackets
set showmatch

" No text wrapping
set nowrap

" Show 8 rows, 16 columns around the cursor when scrolling, scroll by 1 column
set scrolloff=8
set sidescrolloff=16
set sidescroll=1

" Show commans being typed
set showcmd

" Two lines for the command line
set cmdheight=2

" Always show the status line
set laststatus=2



""" Editing
" Smart indents
set autoindent smartindent
set smarttab



""" Code style
" Tab formatting with 4 spaces
set autoindent
set tabstop=4
set expandtab

" Shift 4 columns (rounded to nearest multiple)
set shiftwidth=4
set shiftround



""" Other utilities
" Ignore case sensitivity, unless there's a capital character
set ignorecase
set smartcase

" Highlight while searching, not after
set nohlsearch
set incsearch

" Store lots of history
set history=1000

" Find recursively in directories
set path+=**

" Show a bigger 'wildmenu' for things like tab completion
set wildmenu

