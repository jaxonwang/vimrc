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

let mapleader = ' '
let g:netrw_banner = 0         " do not show Netrw help banner

set nowrap                     " Don't wrap lines by default

set tabstop=4                  " tab size eql 4 spaces
set softtabstop=4
set shiftwidth=4               " default shift width for indents
set expandtab                  " replace tabs with ${tabstop} spaces
set smarttab

set backspace=indent
set backspace+=eol
set backspace+=start

set autoindent
set cindent
set indentkeys-=0#            " do not break indent on #
set cinkeys-=0#
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do
set cinwords+=for,switch,case

" Visual
syntax on                      " enable syntax

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

set foldenable                " Turn on folding
set foldmethod=syntax         " Fold on the marker
set foldlevel=100             " Don't autofold anything (but I can still fold manually)
set foldopen=block,hor,tag    " what movements open folds
set foldopen+=percent,mark
set foldopen+=quickfix

set virtualedit=block

set splitbelow
set splitright

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

if has('gui_running')
  set guioptions=cMg " console dialogs, do not show menu and toolbar

  " Fonts
  " :set guifont=* " to launch a GUI dialog
  if has('mac')
    if has('macligatures')
      set antialias macligatures guifont=Fira\ Code\ Light:h13 " -> <=
    else
      set noantialias guifont=Andale\ Mono:h14
    end
  set fuoptions=maxvert,maxhorz ",background:#00AAaaaa
  else
  set guifont=Terminus:h16
  end
endif
" "}}}

" Tabs
nnoremap <leader>- :bprev<CR>
nnoremap <leader>= :bnext<CR>

" map <silent> <C-W>v :vnew<CR>
" map <silent> <C-W>s :snew<CR>

" Make Control-direction switch between windows (like C-W h, etc)
nmap <silent> <C-k> <C-W><C-k>
nmap <silent> <C-j> <C-W><C-j>
nmap <silent> <C-h> <C-W><C-h>
nmap <silent> <C-l> <C-W><C-l>

  " vertical paragraph-movement
nmap <C-K> {
nmap <C-J> }

if has("nvim")
    tnoremap <Esc> <C-\><C-n>
endif

" when pasting copy pasted text back to 
" buffer instead replacing with owerride
xnoremap p pgvy

" map(range(1,9), 'exec "imap <D-".v:val."> <C-o>".v:val."gt"')
" map(range(1,9), 'exec " map <D-".v:val."> ".v:val."gt"')

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

"

" AutoCommands "
au BufRead,BufNewFile {*.go}                                          setl ft=go tabstop=4 softtabstop=4 noexpandtab smarttab
au BufRead,BufNewFile {*.coffee}                                      setl ft=coffee tabstop=2 softtabstop=2 expandtab smarttab
au BufRead,BufNewFile {*.cc,*.h,*.cpp,*.hpp,*.cxx}                    setl ft=cpp tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
au BufRead,BufNewFile {Gemfile,Rakefile,*.rake,config.ru,*.rabl}      setl ft=ruby tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
au BufRead,BufNewFile {*.local}                                       setl ft=sh
au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                         setl ft=markdown
au BufRead,BufNewFile {*.scala}                                       setl ft=scala
au! BufReadPost       {COMMIT_EDITMSG,*/COMMIT_EDITMSG}               exec 'setl ft=gitcommit noml list spell' | norm 1G
au! BufWritePost      {*.snippet,*.snippets}                          call ReloadAllSnippets()

" open help in vertical split
" au BufWinEnter {*.txt} if 'help' == &ft | wincmd H | nmap q :q<CR> | endif
" " }}}

" Scripts and Plugs " {{{
filetype off
call plug#begin()

" Golang
Plug 'fatih/vim-go',{ 'for': 'go' , 'do': ':GoUpdateBinaries'}
" unlike gofmt also adds/removes imports
let g:go_fmt_command = 'gofmt'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_build_constraints = 1


" goes to the definition under cursor in a new split
" TODO: doesn't work
nnoremap <C-W>gd <C-W>^zz

" Erlang Runtime
Plug 'vim-erlang/vim-erlang-runtime', { 'for': 'erlang' }
Plug 'vim-erlang/vim-erlang-tags', { 'for': 'erlang' }
Plug 'vim-erlang/vim-erlang-compiler', { 'for': 'erlang' }
Plug 'vim-erlang/vim-erlang-skeletons', { 'for': 'erlang' }

" Scala
Plug 'derekwyatt/vim-scala',{ 'for': 'scala' }

" Js
Plug 'pangloss/vim-javascript',{ 'for': 'javascript' }
Plug 'mxw/vim-jsx',{ 'for': 'javascript' }

" Haskell
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}

" Snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'honza/vim-snippets'
let g:snipMate = { 'snippet_version' : 1 }
Plug 'garbas/vim-snipmate'

" Class/module browser
Plug 'majutsushi/tagbar'
" toggle Tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on Tagbar open
let g:tagbar_autofocus = 0
let g:tagbar_autoclose = 0 
let g:tagbar_foldlevel = 0 
let g:tagbar_width = 30
let g:tagbar_autofocus = 0

" " LearderF fuzy function jump
" Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" noremap <leader>f :LeaderfFunction<CR>
" noremap <leader>m :LeaderfMru<CR>
" let g:Lf_ShortcutF= '<leader>t'
" let g:Lf_WindowPosition = 'popup'
" let g:Lf_PreviewInPopup = 1
" " universal ctags bug: --go-kinds=f renders segment fault
" let g:Lf_CtagsFuncOpts = { 
"             \ 'go': '--language-force=go'}

 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
 Plug 'junegunn/fzf.vim'
 noremap <leader>t :Files<CR>
 noremap <leader>f :BTags<CR>
 noremap <leader>h :History<CR>
 let g:fzf_tags_command = 'ctags -R'
 if executable('bat')
 command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse',
     \ '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
 endif

" Make
Plug 'neomake/neomake'
noremap <F5> :Neomake!<CR>
let g:neomake_open_list = 2

" Syntax highlight
Plug 'gmarik/vim-markdown'
Plug 'timcharper/textile.vim'

" Git integration
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'gmarik/sudo-gui.vim'

" Plug 'SuperTab'
Plug 'junegunn/vim-easy-align'
Plug 'vim-scripts/lastpos.vim'

Plug 'Lokaltog/vim-easymotion'
map <Leader> <Plug>(easymotion-prefix)

" Displaying thin vertical lines at each indentation level for code indented
" with spaces.
Plug 'Yggdroot/indentLine'

" line
" Plug 'vim-airline/vim-airline'
" let g:airline#extensions#tabline#enabled = 1
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'

" Better file browser
Plug 'scrooloose/nerdtree'
" NERDTree (better file browser) toggle
" Ignore files on NERDTree
let NERDTreeShowBookmarks=1

let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$', '^\.git$', '__pycache__', '\.DS_Store' ]

Plug 'jistr/vim-nerdtree-tabs'
map <F3> :NERDTreeTabsToggle<CR>

" a start screen
Plug 'mhinz/vim-startify'

Plug 'tomtom/tlib_vim'
Plug 'tomtom/tcomment_vim'
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

" Colorscheme
Plug 'morhetz/gruvbox'

" coc as LSP server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

filetype plugin indent on      " Automatically detect file types.


call plug#end()

set background=dark
    let g:gruvbox_contrast_dark='hard'

" use try block so won't fail first time execute PlugInstall
try
colorscheme gruvbox 
catch
endtry

" hight contract match pair color
hi MatchParen cterm=none ctermbg=gray ctermfg=white
