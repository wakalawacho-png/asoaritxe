#!/bin/bash

U=0
S=0
P=0

while [ $# -gt 0 ]
do
	case $1 in
	"-u")
		U=$(( $U + 1 ))
		;;
	"-s")
		S=$(( $S + 1 ))
		;;
	"-p")
		P=$(( $P + 1 ))
		;;
	*)
		ERROR=1
		;;
	esac
	if [ -z "$2" ]; then
		Error=1
	fi
	shift 2
done

if [ $U -ne 1 && $S -ne 1 && $P -gt 1 ]
echo "Us: $0 -s Server -u Nomusuari [-p contrasenya]"
	exit 2
fi
