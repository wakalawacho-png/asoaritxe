#!/bin/bash

USUARIQUOTA="$1"
QUOTA=$(cat usuaris.cnf | grep "$1" | cut -d ':' -f2)
SPACE="$2"
DATA=$(date)
if [[ $SPACE -ge $QUOTA ]]; then
	echo "ALERT: $DATA , $USUARIQUOTA:$SPACE:$QUOTA" >> quota.log
elif [[ $SPACE -le $QUOTA ]]; then
	echo "NORMAL: $DATA , $USUARIQUOTA:$SPACE:$QUOTA" >> quota.log
else
	echo "ERR: $DATA , $USUARIQUOTA:$SPACE:$QUOTA" >> quota.log
fi 
