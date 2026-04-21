#!/bin/bash

if [ "$1" = "-s" ]; then
	SERVER="$2"
fi
if [ "$3" = "-u" ]; then
	USUARI="$4"
fi
if [ "$5" = "-p" ]; then
	CONTRASENYA="$6"
fi
if [ -z "$SERVER" ] || [ -z "$USUARI" ] || [ -z "$CONTRASENYA" ]; then
	echo " us: $0 -s servidor -u nomusuari -p contrasenya]"
	else
	echo "conectat"
fi

