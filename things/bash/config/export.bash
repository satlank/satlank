# Ensure we are using the correct locale
export LANG=en_GB.UTF-8

# Use local terminfo if exists
if [ -d ${XDG_CONFIG_HOME}/terminfo ]; then
	export TERMINFO="${XDG_CONFIG_HOME}/terminfo"
fi

# Enable colours for things like 'ls' etc
export CLICOLOR=1

# Set the default editor; for difference between EDITOR and VISUAL see
# https://unix.stackexchange.com/questions/4859/visual-vs-editor-whats-the-difference
# I don't care about non-'advanced' terminals, so setting them to the
# same works for me (though VISUAL should be enough) and 'does the right
# thing' if something only looks at EDITOR.
export EDITOR=nvim
export VISUAL=$EDITOR

# History Settings
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%F %T "
export HISTIGNORE='ls:ll:bg:fg:history'

# Ensure we get __git_ps1 to include change information
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

# Ensure GPG will work
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"
export GPG_TTY=`tty`
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# Ensure that there is no default kube config being used
export KUBECONFIG=

# Consistent location for go stuff
export GOPATH=$HOME/Code/go

# Deal with rust/cargo
export CARGO_HOME=${XDG_CACHE_HOME}/cargo
export RUSTUP_HOME=${XDG_CACHE_HOME}/rustup
export RUSTFLAGS="-C target-cpu=native"

# Deal with (ana)conda
if [ -d $HOME/opt/miniconda3 ]; then
	# The new location for miniconda3 everywhere (ideally)
	export ANACONDA_PATH=$HOME/opt/miniconda3/bin
elif [ -d /opt/miniconda3 ]; then
	# Location of anaconda on OSX (manual install)
	export ANACONDA_PATH=/opt/miniconda3/bin
elif [ -d /opt/anaconda ]; then
	# Location of anaconda on Arch Linux (from AUR)
	export ANACONDA_PATH=/opt/anaconda/bin
fi
if [ ! -z ${ANACONDA_PATH+x} ]; then
	export CONDA_PKGS_DIRS=${XDG_CACHE_HOME}/conda/pkgs
	export CONDA_ENVS_PATH=${XDG_DATA_HOME}/conda/envs
fi

# Update path
if [ -d /usr/local/opt/openssl/bin ]; then
	# openssl installation from homebrew
	export PATH="/usr/local/opt/openssl/bin:$PATH"
fi
if [ -d ${CARGO_HOME}/bin ]; then
	export PATH="$CARGO_HOME/bin:$PATH"
fi
if [ -d ~/bin ]; then
	export PATH=~/bin:$PATH
fi

# Set locations for base16 colours
BASE16_DIR=${XDG_CONFIG_HOME}/base16/scripts/
BASE16_CONFIG=${XDG_CONFIG_HOME}/base16/info

# Make Starship use an XDG directory
export STARSHIP_CONFIG=${XDG_CONFIG_HOME}/starship/starship.toml
