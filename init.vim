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
call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'

" Golang
Plug 'fatih/vim-go',{ 'for': 'go' , 'do': ':GoUpdateBinaries'}
" unlike gofmt also adds/removes imports
let g:go_fmt_command = 'gofmt'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_build_constraints = 1

" Snippets
Plug 'rafamadriz/friendly-snippets'
Plug 'L3MON4D3/LuaSnip'
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

" Class/module browser
Plug 'liuchengxu/vista.vim'
" toggle Tagbar display
map <F4> :Vista!!<CR>
" autofocus on Tagbar open
let g:vista_sidebar_width = 35
let g:vista_echo_cursor = 0
let g:vista_executive_for = {
    \ 'cpp': 'coc',
    \ 'go': 'coc',
    \ 'rust': 'coc',
    \ }
let g:vista_blink = [0, 0] " disable blink

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
let g:neomake_open_list = 2
noremap <F5> :Neomake!<CR>

Plug 'vim-test/vim-test'
noremap <F6> :TestNearest<CR>
let test#strategy = "neomake"

" Syntax highlight
Plug 'gmarik/vim-markdown', {'for': 'markdown'}

" Git integration
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'lewis6991/gitsigns.nvim'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'windwp/nvim-autopairs'

Plug 'gmarik/sudo-gui.vim'

Plug 'junegunn/vim-easy-align'
Plug 'vim-scripts/lastpos.vim'

Plug 'phaazon/hop.nvim'
noremap s :HopWordAC<CR>
noremap S :HopWordBC<CR>

" Peak number
Plug 'nacro90/numb.nvim'

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
" folders that contain only one folder are grouped
let g:nvim_tree_group_empty = 1
map <F3> :NvimTreeToggle<CR>

" a start screen
Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0

" comment
Plug 'numToStr/Comment.nvim'
nnoremap // <Plug>(comment_toggle_current_linewise)
vnoremap // <Plug>(comment_toggle_linewise_visual)
nnoremap /b <Plug>(comment_toggle_current_blockwise)
vnoremap /b <Plug>(comment_toggle_blockwise_visual)

Plug 'dstein64/vim-startuptime'

" range select
Plug 'terryma/vim-expand-region'
xmap <silent> v <Plug>(expand_region_expand)
let g:expand_region_text_objects = {
        \ 'i]'  :1,
        \ 'ib'  :1,
        \ 'iB'  :1,
        \ 'ip'  :0,
        \ }

" Colorscheme
Plug 'sainnhe/gruvbox-material'

" coc as LSP server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = ['coc-json', 'coc-go', 'coc-rust-analyzer', 'coc-clangd', 'coc-tsserver',
            \'@yaegassy/coc-pylsp', 'coc-pydocstring',
            \'coc-sh',
            \'coc-sql',
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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Show all diagnostics.
nnoremap <silent><nowait> <F8> :<C-u>CocList diagnostics<cr>

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

" hight contract match pair color
hi MatchParen cterm=none ctermbg=gray ctermfg=white

colorscheme gruvbox-material

lua require('config')
