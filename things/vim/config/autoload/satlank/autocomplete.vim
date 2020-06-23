function! satlank#autocomplete#setup_mappings() abort
	inoremap <buffer> <silent> <Tab> <C-R>=satlank#autocomplete#expand_or_jump("N")<CR>
	snoremap <buffer> <silent> <Tab> <C-R>=satlank#autocomplete#expand_or_jump("N")<CR>
	inoremap <buffer> <silent> <S-Tab> <C-R>=satlank#autocomplete#expand_or_jump("N")<CR>
	snoremap <buffer> <silent> <S-Tab> <C-R>=satlank#autocomplete#expand_or_jump("N")<CR>

	imap <expr> <buffer> <silent> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
	smap <expr> <buffer> <silent> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

function! satlank#autocomplete#expand_or_jump(direction) abort
	if pumvisible()
		if a:direction ==# 'N'
			return "\<C-N>"
		else
			return "\<C-P>"
		endif
	else
		if a:direction ==# 'N'
			return "\<Tab>"
		end
	endif
	return ''
endfunction

let s:deoplete_init_done = 0
function! satlank#autocomplete#deoplete_init() abort
	if s:deoplete_init_done || !has('nvim')
		return
	endif
	let s:deoplete_init_done=1
	call deoplete#enable()
endfunction
