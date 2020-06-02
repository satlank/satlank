" Convenient way to switch to 'plaintext' settings via a function call
"   via https://github.com/wincent/wincent/blob/166ac6d4c9998eb36d5bb62220b8351c30412070/aspects/vim/files/.vim/autoload/wincent/functions.vim#L11
function! satlank#plaintext#init() abort
	if has('conceal')
		setlocal concealcursor=nc
	endif
	setlocal textwidth=0
	setlocal wrap
	setlocal wrapmargin=0

	call satlank#spell#spell()

	" When in insert mode for longer, break undo sequences at punctuation so
	" that an undo doesn't wipe quite so much text; see `:help i_CTRL-_u`
	inoremap <buffer> ! !<C-g>u
	inoremap <buffer> , ,<C-g>u
	inoremap <buffer> . .<C-g>u
	inoremap <buffer> : :<C-g>u
	inoremap <buffer> ; ;<C-g>u
	inoremap <buffer> ? ?<C-g>u

	" Make down/up movement keys not jump over wrapped lines
	nnoremap <buffer> j gj
	nnoremap <buffer> k gk
endfunction
