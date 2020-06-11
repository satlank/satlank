function _kon_usage {
	local files
	files=$(find ${HOME}/.kube/envs/ -type f -maxdepth 1 -exec basename {} \;)
	echo "Pick one of"
	echo $files
}

function kon {
	if [ $# -eq 0 ]; then
		_kon_usage
		return
	fi
	if [ ! -f ${HOME}/.kube/envs/$1 ]; then
		echo "$1 unknown"
		_kon_usage
		return 1
	fi
	export KUBECONFIG=${HOME}/.kube/envs/$1
}

function koff {
	export KUBECONFIG=
}
