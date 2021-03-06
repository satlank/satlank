# Takes a hex colour in the form of "RRGGBB" and outputs its luma (0-255, where
# 0 is black and 255 is white).
#
# Based on: https://github.com/lencioni/dotfiles/blob/b1632a04/.shells/colours
# Taken from
# https://github.com/wincent/wincent/blob/master/aspects/dotfiles/files/.zsh/colours#L7
luma() {
	local COLOUR_HEX=$1

	if [ -z "$COLOUR_HEX" ]; then
		echo "Missing argument hex colour (RRGGBB)"
		return 1
	fi

	# Extract hex channels from background colour (RRGGBB).
	local COLOUR_HEX_RED=$(echo "$COLOUR_HEX" | cut -c 1-2)
	local COLOUR_HEX_GREEN=$(echo "$COLOUR_HEX" | cut -c 3-4)
	local COLOUR_HEX_BLUE=$(echo "$COLOUR_HEX" | cut -c 5-6)

	# Convert hex colours to decimal.
	local COLOUR_DEC_RED=$((16#$COLOUR_HEX_RED))
	local COLOUR_DEC_GREEN=$((16#$COLOUR_HEX_GREEN))
	local COLOUR_DEC_BLUE=$((16#$COLOUR_HEX_BLUE))

	# Calculate perceived brightness of background per ITU-R BT.709
	# https://en.wikipedia.org/wiki/Rec._709#Luma_coefficients
	# http://stackoverflow.com/a/12043228/18986
	local COLOUR_LUMA_RED=$((2126 * $COLOUR_DEC_RED))
	local COLOUR_LUMA_GREEN=$((7152 * $COLOUR_DEC_GREEN))
	local COLOUR_LUMA_BLUE=$((722 * $COLOUR_DEC_BLUE))

	local COLOUR_LUMA=$(( ($COLOUR_LUMA_RED + $COLOUR_LUMA_GREEN + $COLOUR_LUMA_BLUE) / 10000))

	echo "$COLOUR_LUMA"
}

function __colour_impl {
	local SCHEME=$1
	local FILE="$BASE16_DIR/base16-${SCHEME}.sh"
	if [[ -f "$FILE" ]]; then
		local BG=$(grep color_background= "$FILE" | cut -d \" -f2 | sed -e 's#/##g')
		local LUMA=$(luma "$BG") 
		local LIGHT=$((LUMA > 127))
		local BACKGROUND=dark
		if [ $LIGHT -eq 1 ]; then
			BACKGROUND=light
		fi

		echo "$SCHEME" > $BASE16_CONFIG
		echo "$BACKGROUND" >> $BASE16_CONFIG
		sh "$FILE"

		if [ -n "$TMUX" ]; then
			local CC=$(grep color18= "$FILE" | cut -d \" -f2 | sed -e 's#/##g')
			if [ -n "$BG" -a -n "$CC" ]; then
				command tmux set -a window-active-style "bg=#$BG"
				command tmux set -a window-style "bg=#$CC"
				command tmux set -g pane-active-border-style "bg=#$CC"
				command tmux set -g pane-border-style "bg=#$CC"
			fi
		fi
	else
		echo "Scheme '$SCHEME' not found in $BASE16_DIR"
		return 1
	fi
}

function colour {
	if [ -z ${BASE16_CONFIG+x} ]; then
		echo "BASE16_CONFIG is not set, cannot continue"
		return 1
	fi
	if [ -z ${BASE16_DIR+x} ]; then
		echo "BASE16_DIR is not set, cannot continue"
		return 1
	fi
	if [ $# -eq 0 ]; then
		if [ -f "$BASE16_CONFIG" ]; then
			local SCHEME=`head -n1 "$BASE16_CONFIG"`
			__colour_impl "$SCHEME"
			return
		else
			local SCHEME="help"
		fi
	else
		local SCHEME="$1"
	fi

	case "$SCHEME" in
	help)
		echo 'colour                                  (re-apply current scheme if set)'
		echo 'colour info                             (show current scheme)'
		echo 'colour default-dark|harmonic-dark|...   (switch to scheme)'
		echo 'colour help                             (show this help)'
		echo 'colour ls [pattern]                     (list available schemes)'
		echo ''
		echo "BASE16_CONFIG: $BASE16_CONFIG"
		echo "BASE16_DIR: $BASE16_DIR"
		return
		;;
	ls)
		find "$BASE16_DIR" -name 'base16-*.sh' | \
		sed -E 's|.+/base16-||' | \
		sed -E 's/\.sh//' | \
		grep "${2:-.}" | \
		sort | \
		column
		return
		;;
	info)
		if [ -f "$BASE16_CONFIG" ]; then
			cat "$BASE16_CONFIG"
		else
			echo "No scheme configured yet"
		fi
		return
		;;
	*)
		__colour_impl "$SCHEME"
		;;
	esac
}
