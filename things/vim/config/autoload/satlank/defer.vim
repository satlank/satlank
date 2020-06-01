function! satlank#defer#defer(evalable) abort
	if has('autocmd') && has('vim_starting')
		execute 'autocmd User SatlankDefer ' . a:evalable
	else
		execute a:evalable
	endif
endfunction
