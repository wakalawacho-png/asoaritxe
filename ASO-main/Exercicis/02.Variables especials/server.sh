#!/bin/bash

S="$1"
SERVER="$2"
U="$3"
USUARI="$4"
P="$5"
CONTRA="$6"

if [[ $S -eq -s ]]; then
	if [[ $U -eq -u ]]; then
		if [[ $P -eq -p ]]; then
			echo "conectat"
		fi
	fi
	else
	echo "Us: ./server.sh -s Server -u NomUsuari [-p Contraseña]"
fi
