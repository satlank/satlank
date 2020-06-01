function! satlank#autocmds#idleboot() abort
	augroup SatlankIdleBoot
		autocmd!
	augroup END

	doautocmd User SatlankDefer
	autocmd! User SatlankDefer
endfunction
