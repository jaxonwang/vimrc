" easymotion
set easymotion
let g:EasyMotion_do_mapping=0
map s <Plug>(easymotion-w)
map S <Plug>(easymotion-b)

map <F3> <Action>(ActivateStructureToolWindow)
map <F4> <Action>(ActivateProjectToolWindow)
map <F6> <Action>(RunClass)
map <F7> <Action>(ReformatCode)

map gi <Action>(GotoImplementation)
map gt <Action>(GotoTest)

map <leader>f <Action>(FileStructure)
map <leader>t <Action>(GotoFile)
map <leader>h <Action>(RecentFiles)

map // <Action>(CommentByLineComment)

" TODO snippets
