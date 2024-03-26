# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi
if [ x$(uname) == 'xDarwin' ]; then
	export CLICOLOR=1
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
if [ -x /usr/bin/notify-send ]; then
	alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

alias ll='ls -l'
alias la='ls -a'
alias l='ls -CF'
alias llh='ls -lh'
alias lh='ls -h'
alias vi='nvim'
alias lla='ll -a'
if [ x$(uname) == 'xDarwin' ]; then
    alias du1='du -d 1 -h'
else
    alias du1='du --max-depth=1 -h'
fi
alias ts='date -u +"%Y%m%d%H%M%S"'
alias lesss='less -S'
alias py='ipython'
alias m='neomutt -n'
alias sa='source ${ANACONDA_PATH}/activate'
alias sd='conda deactivate'
alias senv='env | sort'
alias k='kubectl'
