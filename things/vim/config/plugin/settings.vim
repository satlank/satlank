scriptencoding utf-8

set autoindent                  " maintain indent of current line
set backspace=indent,start,eol  " sane backspace behaviour

set backup                                " delete old backup
set writebackup                           " backup current file
set backupdir=$XDG_DATA_HOME/vim/backup   " set directory for backup files

set swapfile                            " enable swap files
set directory=$XDG_DATA_HOME/vim/swap   " set directory for swap files

set noemoji                     " don't assume all emoji are double width
set noexpandtab                 " use real tabs by default (override behaviour per ft)

if has('folding')
	if has('windows')
		set fillchars=diff:∙   " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
		set fillchars+=fold:·  " MIDDLE DOT (U+00B&, UTF-8: C2 B7)
		set fillchars+=vert:┃  " BOX DRAWINS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
	endif

	set foldmethod=indent    " faster than syntax
	set foldlevelstart=99    " start unfolded
endif

if v:version > 703 || v:version == 703 && has('patch541')
	set formatoptions+=j     " remove comment leader when joining comment lines
endif

set formatoptions+=n         " smart auto-indenting inside numbered lists
set hidden                   " no prompt when hiding buffers with unsaved changes

if !has('nvim')
	set highlight+=@:Conceal
	set highlight+=D:Conceal
	set highlight+=N:FoldColumn
	set highlight+=c:LineNr
endif

if exists('inccommand')
	set inccommand=split      " live preview of :s results
endif

set laststatus=2              " always show status line
set lazyredraw                " don't bother updating screen during macro playback

if has('linebreak')
	set linebreak             " wrap long lines at characters in 'breakat'
endif

set list
set listchars=nbsp:⦸          " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▸\         " BLACK RIGHT-POINTING SMALL TRIANGLE (U+25B8, UTF-8: E2 96 B8)
                              " + filling with blank
set listchars+=extends:»      " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«     " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:·        " MIDDLE DOT (U+00B7, UTF-8: C2 B7)

set modelines=5               " scan this many lines looking for modeline
set number                    " show line numbers in gutter

if exists('+relativenumber')
	set norelativenumber
endif

set scrolloff=3               " start scrollingg 3 lines before edge of viewport
set shell=sh                  " shell to use for '!', ':!', 'system()' etc
set noshiftround              " don't always indent by multiple of shiftwidth
set shiftwidth=4              " spaces per tab (when shifting)
set shortmess+=A              " ignore annoying swapfile messages
set shortmess+=I              " no splash screen
set shortmess+=O              " file-read message overwrites previous
set shortmess+=T              " truncate non-file messages in middle
set shortmess+=W              " don't echo "[w]"/"[written]" when writing
set shortmess+=a              " use abbreviations in messages eg. `[RO]` instead of `[readonly]`

if has('linebreak')
  let &showbreak='↳ '         " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
endif

if has('showcmd')
	set noshowcmd             " don't show extra info at end of command line
endif

set sidescroll=0              " sidescroll in jumps because terminals are slow
set sidescrolloff=3           " same as scrolloff, but for columns
set smarttab                  " <tab>/<BS> indent/dedent in leading whitespace


if v:progname !=# 'vi'
	set softtabstop=-1        " use 'shiftwidth' for tab/bs at end of line
endif

if has('windows')
	set splitbelow            " open horizontal splots below current window
endif

if has('vertsplit')
	set splitright            " open vertical splits to the right of current window
endif

set switchbuf=usetab          " try to reuse windows/tabs when switching buffers

if has('syntax')
	set synmaxcol=200         " don't bother syntax highlightin long lines
endif

set tabstop=4                 " spaces per tab

if has('termguicolors')
	set termguicolors         " use gufg/guibg instead of ctermf/ctermbgg in terminal
endif

set textwidth=80              " automatically hardwrap at 80 columns

if has('persistent_undo')
	if exists('$SUDO_USER')
		set noundofile        " don't create root owned files
	else
		set undodir=$XDG_DATA_HOME/vim/undo   " keep undo files out of the way
		set undofile                " do not use undo files
	endif
endif

if has('viminfo')  " ie vim
	let s:viminfo='viminfo'
elseif has('shada')  " ie neovim
	let s:viminfo='shada'
endif

if exists('s:viminfo')
	if exists('$SUDO_USER')
		" Don't create root-owned files.
		execute 'set ' . s:viminfo . '='
	else
		" Defaults:
		"   Neovim: !,'100,<50,s10,h
		"   Vim:    '100,<50,s10,h
		"
		" - ! save/restore global variables (only all-uppercase variables)
		" - '100 save/restore marks from last 100 files
		" - <50 save/restore 50 lines from each register
		" - s10 max item size 10KB
		" - h do not save/restore 'hlsearch' setting
		"
		" Our overrides (keep h):
		" - '0 store marks for 0 files
		" - <0 don't save registers
		" - f0 don't store file marks
		" - n: store in $XDG_DATA_HOME/vim/
		"
		execute 'set ' . s:viminfo . "='0,<0,f0,h,n$XDG_DATA_HOME/vim/" . s:viminfo

		if !empty(glob('$XDG_DATA_HOME/vim/' . s:viminfo))
			if !filereadable(expand('$XDG_DATA_HOME/vim/' . s:viminfo))
				echoerr 'warning: $XDG_DATA_HOME/vim/' . s:viminfo . ' exists but is not readable'
			endif
		endif
	endif
endif

if has('mksession')
	set viewdir=$XDG_DATA_HOME/vim/view      "override ~/.vim/view default
	set viewoptions=cursor,folds             " save/restore just these
endif

if has('virtualedit')
	set virtualedit=block            " allow cursor to move where there is no text in visual block mode
endif
set visualbell t_vb=                 " stop annoying bell
set whichwrap=b,s,<,>,[,],~      " allow movements to cross line boundaries
set wildcharm=<C-z>                  " subsitute for 'wildchar' (<Tab>) in macros
if has('wildignore')
	set wildignore+=*.o,*.obj,build,build-*,.*.swp,.*.swo
	set wildignore+=*.pyc,*.class,*.jar,*~
	set wildignore+=.git,.svn
endif
if has('wildmenu')
	set wildmenu
endif
set wildmode=longest:full,full

set spelllang=en_gb

set hlsearch   " Highlights the searches
set incsearch  " Incremental searching
set ignorecase " Be case-insensitve when searchin
set smartcase  " Be smart about it
if executable('rg')  " Use a fast grep
	set grepprg=rg\ --color=never\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'rust', 'yaml']
