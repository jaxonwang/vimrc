" General
set nocompatible               " be iMproved

scriptencoding utf-8           " utf-8 all the way
set encoding=utf-8

set history=256                " Number of things to remember in history.
set timeoutlen=250             " Time to wait after ESC (default causes an annoying delay)
set clipboard+=unnamed         " Yanks go on clipboard instead.
set pastetoggle=<F10>          " toggle between paste and normal: for 'safer' pasting from keyboard
set shiftround                 " round indent to multiple of 'shiftwidth'
set tags=.git/tags;$HOME       " consider the repo tags first, then
                               " walk directory tree upto $HOME looking for tags
                               " note `;` sets the stop , 'do':
                               " ':GoUpdateBinaries'folder. :h file-search

set modeline
set modelines=5                " default numbers of lines to read for modeline instructions

set autowrite                  " Writes on make/shell commands
set autoread

set mouse=a

set hidden                     " The current buffer can be put to the background without writing to disk

" enable very magic. ex. no more \<...\> but <...>
nnoremap / /\v
vnoremap / /\v
set hlsearch                   " highlight search
set ignorecase                 " be case insensitive when searching
set smartcase                  " be case sensitive when input has a capital letter
set incsearch                  " show matches while typing
" cancel the hightlight
nnoremap <silent> <Esc><Esc> :noh<CR>

let mapleader = ' '
let g:netrw_banner = 0         " do not show Netrw help banner

set nowrap                     " Don't wrap lines by default

set tabstop=4                  " tab size eql 4 spaces
set softtabstop=4
set shiftwidth=4               " default shift width for indents
set expandtab                  " replace tabs with ${tabstop} spaces
set smarttab

set autoindent
set cindent
set indentkeys-=0#            " do not break indent on #
set cinkeys-=0#
set cinoptions=:s,ps,ts,cs

" Visual
" syntax on                      " I use tree-sitter now

set showmatch                 " Show matching brackets.
set matchtime=2               " Bracket blinking.
set matchpairs+=<:>

set wildmode=longest,list     " At command line, complete longest common string, then list alternatives.

set completeopt-=preview      " disable auto opening preview window

set visualbell              " No blinking
set noerrorbells              " No noise.
set vb t_vb=                  " disable any beeps or flashes on error

set laststatus=2              " always show status line.
set shortmess=atI             " shortens messages
set showcmd                   " display an incomplete command in statusline

set nofoldenable              " do not fold when open
set foldmethod=expr
set foldlevel=100
set foldexpr=nvim_treesitter#foldexpr()

set virtualedit=block

set splitbelow
set splitright

set nofixendofline

" Dictionary
set dict+=/usr/share/dict/words

" highlight trailing
" future colorscheme commands may clear all user-defined highlight groups
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=green guibg=green
match ExtraWhitespace /\s\+$\| \+\ze\t/

" always show status bar
set ls=2
" line numbers
set number
set relativenumber

set list                      " display unprintable characters f12 - switches
"set listchars=tab:\ ·,eol:¬
"set listchars+=trail:·
"set listchars+=extends:»,precedes:«
"map <silent> <F12> :set invlist<CR>

" Tabs
nnoremap <leader>- :BufferLineCyclePrev<CR>
nnoremap <leader>= :BufferLineCycleNext<CR>

" map <silent> <C-W>v :vnew<CR>
" map <silent> <C-W>s :snew<CR>

" Make Control-direction switch between windows (like C-W h, etc)
nmap <silent> <C-k> <C-W><C-k>
nmap <silent> <C-j> <C-W><C-j>
nmap <silent> <C-h> <C-W><C-h>
nmap <silent> <C-l> <C-W><C-l>

" if has("nvim")
"     tnoremap <Esc> <C-\><C-n>
" endif

" when pasting copy pasted text back to
" buffer instead replacing with owerride
xnoremap p pgvy

" close/delete buffer when closing window
" map <silent> <D-w> :bdelete<CR>
function! BufferDeleteWithoutClosingWindow()
 let current_buff = bufnr("%")
 bprevious
 execute "bdelete" current_buff
endfunction
command! BufferDelele call BufferDeleteWithoutClosingWindow()
cnoreabbrev bd BufferDelele

" Control+S and Control+Q are flow-control characters: disable them in your terminal settings.
" $ stty -ixon -ixoff
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
"
" generate HTML version current buffer using current color scheme
map <leader>2h :runtime! syntax/2html.vim<CR>
