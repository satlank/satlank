function s:CheckColorScheme()
	if !has('termguicolors')
		let g:base16colorspace=256
	endif

	let s:config_file = $XDG_CONFIG_HOME . '/base16/info'

	if filereadable(s:config_file)
		let s:config = readfile(s:config_file, '', 2)

		if s:config[1] =~# '^dark\|light$'
			execute 'set background=' . s:config[1]
		else
			echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
		endif

		if filereadable($XDG_CONFIG_HOME . '/vim/pack/external/opt/base16-vim/colors/base16-' . s:config[0] . '.vim')
			execute 'colorscheme base16-' . s:config[0]
		else
			echoerr 'Bad scheme ' . s:config[0] . ' in ' . s:config_file
		endif
	else
		set background=dark
		colorscheme base16-synth-midnight-dark
	endif
endfunction

if v:progname !=# 'vi'
	if has('autocmd')
		augroup Autocolor
			autocmd!
			autocmd FocusGained * call s:CheckColorScheme()
		augroup END
	endif
	call s:CheckColorScheme()
endif
