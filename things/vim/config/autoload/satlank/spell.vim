let s:spelllang=["de", "en_gb"]

function! satlank#spell#spell() abort
	" Enable spell checking
	if has('syntax')
		setlocal spelllang=en_gb
		setlocal spell
	endif
endfunction

function! satlank#spell#cycle() abort
	let l:newpos=(index(s:spelllang, &spelllang) + 1) % len(s:spelllang)
	let l:lang=s:spelllang[l:newpos]
	echo "Language " . lang . " selected"
	execute "set spelllang=" . lang
endfunction
