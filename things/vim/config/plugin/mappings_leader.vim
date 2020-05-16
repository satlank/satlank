" Leader mappings.

" <Leader><Leader> -- Open last buffer.
nnoremap <Leader><Leader> <C-^>

" Exit/write shorts
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

" <LocalLeader>e -- Edit file, starting in same directory as current file.
nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

" Spell checking mappings
"   Toggle spell checking on/off
nnoremap <silent> <Leader>ss :set spell!<CR>
"   Show correction suggestions
nnoremap <Leader>s? z=
"   Add word to dictionary
nnoremap <Leader>si zg
"   Cycle through languages
nnoremap <Leader>sl :call satlank#spell#cycle()<CR>

" Toggle list symbols on/off
nnoremap <Leader>l :set list!<CR>
