#!/bin/bash
total_args() {
	echo "total arguments $#"
}
mostrar_args() {
	local a 
	for a in "$@"; do
		echo "[$a]"
	done
	total_args "$@"
	total_args "$*"
}

mostrar_args 1 2 3

