#!/bin/bash

CURLOAD=$(cat servers.txt | grep "$1" | cut -d ':' -f3)
LIMIT="$2"
DATA=$(date)
if [[ $CURLOAD -ge $LIMIT ]]; then
	echo "ALERT: $DATA , $USER , carrega actual: $CURLOAD , Limit: $LIMIT" >> sistema.log
	else
	echo "OK: $DATA , $USER , carrega actual: $CURLOAD , Llimit: $LIMIT" >> sistema.log 
fi
