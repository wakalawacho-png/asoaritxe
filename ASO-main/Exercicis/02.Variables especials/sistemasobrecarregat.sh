#!/bin/bash

CARREGA=$(uptime | cut -c 46-49)
CURLOAD=$(echo "$CARREGA * 100" | bc)
LIMIT=$(echo "$1 * 100" | bc)
DATA=$(date)
if [[ $CURLOAD -ge $LIMIT ]]; then
	echo "ALERT: $DATA , $USER , carrega actual: $CURLOAD , Limit: $LIMIT" >> sistema.log
	else
	echo "OK: $DATA , $USER , carrega actual: $CURLOAD , Llimit: $LIMIT" >> sistema.log 
fi
