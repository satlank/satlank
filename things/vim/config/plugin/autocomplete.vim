if has('nvim')
	packadd deoplete.nvim
	call satlank#defer#defer('call satlank#autocomplete#deoplete_init()')

	inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
	inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
	inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
	inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
endif
