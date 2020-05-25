"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Indent style
set shiftwidth=2                " two spaces per indent
set tabstop=2                   " number of spaces per tab in display
set softtabstop=2               " number of spaces per tab when inserting
set expandtab                   " substitute spaces for tabs

" Filetype
filetype indent on
syntax enable

" Display
set ruler                       " show cursor position
set nonumber                    " hide line numbers
set nolist                      " hide tabs and EOL chars
set showcmd                     " show normal mode commands as they are entered
set showmode                    " show editing mode in status (-- INSERT --)
set showmatch                   " flash matching delimiters

" Scrolling
set scrolljump=5                " scroll five lines at a time vertically
set sidescroll=10               " minumum columns to scroll horizontally

" Search
"set nohlsearch                 " don't persist search highlighting
set incsearch                   " search with typeahead

" Indent
set autoindent                  " carry indent over to new lines

" Other
set noerrorbells                " no bells in terminal

set backspace=indent,eol,start  " enable backspace
set tags=tags;/                 " search up the directory tree for tags

set undolevels=1000             " number of undos stored
set viminfo='50,"50             " '=marks for x files, "=registers for x files

set modelines=0                 " disable modelines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Additional settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Splits navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Line numbers
set nu

" New line at the end of files
set eol

" Refresh
set autoread


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quirky settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map -p oimport ipdb; ipdb.set_trace(context=21)<ESC>
imap jj <esc>
nnoremap ; : 
set nocp
set mouse =a
" set number
set hlsearch

set background=light
set cursorline

let mapleader = ","
nnoremap <leader>w <C-W>v<C-W>l


" Disable the default Vim startup message.
set shortmess+=I

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase


" Fancy vimrc: https://github.com/spf13/spf13-vim
