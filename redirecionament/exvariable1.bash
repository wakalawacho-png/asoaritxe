#!/bin/bash
if [ $# -ne 1 ]; then
	echo "us: $0 <limit_processos>"
	exit 1
fi

LIMIT=$1
NUMPROC=$(ps aux --no-heading | wc -l)
DATA=$(date)

if [ $NUMPROC -gt $LIMIT ]; then
	echo "ALERT:$DATA $USER Processos actuals: $NUMPROC , Limit: $LIMIT" >> alerta.log
else
	echo "OK:$DATA $USER Procesos actuals: $NUMPROC , Limit: $LIMIT" >>alerta.log
fi
