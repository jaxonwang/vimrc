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

" Dictionary
set dict+=/usr/share/dict/words

" highlight trailing
highlight ExtraWhitespace ctermbg=red guibg=red
"future colorscheme commands may clear all user-defined highlight groups
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
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

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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

Plug 'junegunn/vim-easy-align'
Plug 'vim-scripts/lastpos.vim'

Plug 'Lokaltog/vim-easymotion'
map <Leader> <Plug>(easymotion-prefix)

" Displaying thin vertical lines at each indentation level for code indented
" with spaces.
Plug 'Yggdroot/indentLine'

" icons
Plug 'kyazdani42/nvim-web-devicons'

" line & tab
Plug 'itchyny/lightline.vim'
let g:lightline = { 'enable': { 'tabline': 0 } }
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

" Better file browser
Plug 'kyazdani42/nvim-tree.lua'
map <F3> :NvimTreeToggle<CR>

" a start screen
Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0

Plug 'tomtom/tlib_vim'
Plug 'tomtom/tcomment_vim'
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

" Colorscheme
Plug 'sainnhe/gruvbox-material'

" coc as LSP server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = ['coc-json', 'coc-go', 'coc-rust-analyzer', 'coc-clangd', 'coc-tsserver',
            \'@yaegassy/coc-pylsp', 'coc-pydocstring',
            \'coc-sh',
            \'coc-dictionary']

" use k to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<cr>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" go to def, ref, impl
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" add rename command
command! -nargs=0 Rename :call CocActionAsync('rename')

" Apply AutoFix to problem on the current line.
" command! -nargs=0 Autofix :call CocAction('doQuickfix')
nmap <F1>  <Plug>(coc-fix-current)

" format
nmap <F7> <Plug>(coc-format)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Range select by lsp
nmap <silent> vv <Plug>(coc-range-select)
xmap <silent> vv <Plug>(coc-range-select)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Show all diagnostics.
nnoremap <silent><nowait> <F6> :<C-u>CocList diagnostics<cr>

filetype plugin indent on      " Automatically detect file types.

call plug#end()

set background=dark

" Important!!
if has('termguicolors')
    set termguicolors
endif
" The configuration options should be placed before `colorscheme sonokai`.
"
function! s:gruvbox_material_custom() abort
    highlight! link TSNamespace AquaItalic
endfunction

augroup GruvboxMaterialCustom
    autocmd!
    autocmd ColorScheme gruvbox-material call s:gruvbox_material_custom()
augroup END
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:gruvbox_material_diagnostic_text_highlight = 1
colorscheme gruvbox-material

" hight contract match pair color
hi MatchParen cterm=none ctermbg=gray ctermfg=white

lua require('config')
