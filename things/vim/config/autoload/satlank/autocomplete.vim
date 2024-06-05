function! satlank#autocomplete#setup_mappings() abort
	"" Disabling the below because it is causing issues with CoPilot completions
	"" (can't accept the completion).
	" inoremap <buffer> <silent> <Tab> <C-R>=satlank#autocomplete#expand_or_jump("N")<CR>
	" snoremap <buffer> <silent> <Tab> <C-R>=satlank#autocomplete#expand_or_jump("N")<CR>
	" inoremap <buffer> <silent> <S-Tab> <C-R>=satlank#autocomplete#expand_or_jump("N")<CR>
	" snoremap <buffer> <silent> <S-Tab> <C-R>=satlank#autocomplete#expand_or_jump("N")<CR>

	imap <expr> <buffer> <silent> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
	smap <expr> <buffer> <silent> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

	nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
	nnoremap <silent> gi <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
	nnoremap <silent> ge <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
	nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.format { async = true }<CR>
	nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
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
