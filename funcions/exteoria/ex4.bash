#!/bin/bash
divideix() {
	local a=$1 b=$2

	if [ $b -eq 0 ]
	then
		echo "divisio per zero" >&2
		return 2
	fi
	echo $(( a / b ))
}

q=$(divideix 10 0) || { echo "ha fallat ($?)"; exit 1; }
echo "quocient=$q"
