if has('folding')
	setlocal nofoldenable
endif

call satlank#spell#spell()

call satlank#autocomplete#deoplete_init()
