let s:vimrc_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
exec 'source ' .. s:vimrc_dir .. '/base.vim'
exec 'source ' .. s:vimrc_dir .. '/extend.vim'
