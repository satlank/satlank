if has('autocmd')
	augroup satlankIdleBoot
		if has('vim_starting')
			autocmd CursorHold,CursorHoldI * call satlank#autocmds#idleboot()
		endif
	augroup END
endif
