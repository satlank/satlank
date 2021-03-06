export PROMPT_COMMAND=__prompt_command

# Kube PS1 magic from
# https://github.com/jonmosco/kube-ps1/blob/master/kube-ps1.sh
function _kube_ps1_update_cache {
	local conf
	if [[ "${KUBECONFIG}" != "${KUBE_PS1_KUBECONFIG_CACHE}" ]]; then
		KUBE_PS1_KUBECONFIG_CACHE=${KUBECONFIG}
		_kube_ps1_get_context_ns
		return
	fi

	#  kubectl will read the environment variable $KUBECONFIG
	# otherwise set it to ~/.kube/config
	for conf in $(_kube_ps1_split : "${KUBECONFIG:-$HOME/.kube/config}"); do
		[[ -r "${conf}" ]] || continue
		if _kube_ps1_file_newer_than "${conf}" "${KUBE_PS1_LAST_TIME}"; then
			_kube_ps1_get_context_ns
			return
		fi
	done
}

function _kube_ps1_split {
	type setopt >/dev/null 2>&1 && setopt SH_WORD_SPLIT
	local IFS=$1
	echo $2
}

function _kube_ps1_file_newer_than {
	local mtime
	local file=$1
	local check_time=$2

	mtime=$(stat -f %m "$file")

	[ "${mtime}" -gt "${check_time}" ]
}

function _kube_ps1_get_context_ns() {
	KUBE_PS1_LAST_TIME=$(date +%s)

	KUBE_PS1_CONTEXT="$(kubectl config current-context 2>/dev/null)"
	if [[ -z "${KUBE_PS1_CONTEXT}" ]]; then
		KUBE_PS1_CONTEXT=""
		KUBE_PS1_NAMESPACE=""
		return
	else 
		KUBE_PS1_NAMESPACE="$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)"
		# Set namespace to 'default' if it is not defined
		KUBE_PS1_NAMESPACE="${KUBE_PS1_NAMESPACE:-default}"
	fi
}

function __prompt_command {
	local EXIT="$?"
	PS1=""

	local RCol='\[\e[0m\]'	# Text Reset
	local Red='\[\e[0;31m\]'
	local Gre='\[\e[0;32m\]'
	local Cya='\[\e[0;36m\]'
	local Whi='\[\e[0;37m\]'
	local Yel='\[\e[0;33m\]'
	local Pur='\[\e[0;35m\]'
	local On_Red='\e[41m'

	# Exit code tracking
	if [ $EXIT != 0 ]; then
		local ExitCodeToken="${On_Red}($EXIT)${RCol}"
	fi

    # Conda env
	if [ $CONDA_DEFAULT_ENV ]; then
		# Python token U+16E1 (IOR: World Serpent)
		local CondaToken="${Cya}ᛡ${CONDA_DEFAULT_ENV}${RCol}"
	fi

	# Git branch details
	readarray -td' ' git_details <<<"$(__git_ps1 '%s') "
	unset 'git_details[-1]'
	if [ "${git_details[0]}" != "" ]; then
		if [ ${#git_details[@]} == 2 ]; then
			if [ "${git_details[1]}" == "%" ]; then
				local GitColor=$Yel
			else
				local GitColor=$Red
			fi
		else
			local GitColor=$Gre
		fi
		# Branch symbol U+2387
		local GitToken="${GitColor}⎇ ${git_details[0]}${RCol}"
	fi

	# Kube context/namespace
	if [ $KUBECONFIG ]; then
		_kube_ps1_update_cache
		if [ ! -z $KUBE_PS1_CONTEXT ]; then
			# Helm symbol U+2388
			local KubeToken="${Pur}⎈ ${KUBE_PS1_CONTEXT}:${KUBE_PS1_NAMESPACE}${RCol}"
		fi
	fi


	local UserHostToken="\u@\h"
	local PathToken="${Whi}\W${RCol}"
	#PS1+="[$UserHostToken ${CondaToken+$CondaToken }${GitToken+$GitToken }$PathToken]\$ ${ExitCodeToken+$ExitCodeToken }"
	PS1+="# $UserHostToken "
	PS1+="${KubeToken+$KubeToken }"
	PS1+="${CondaToken+$CondaToken }"
	PS1+="${GitToken+$GitToken }"
	PS1+="$PathToken ${ExitCodeToken+$ExitCodeToken }\n"
}
