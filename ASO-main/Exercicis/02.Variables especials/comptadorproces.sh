#!/bin/bash


NUMPROC=$(ps aux | wc -l)
LIMIT="$1"

DATA=$(date)
if  [[ $NUMPROC -ge $LIMIT ]]; then
	echo "ALERT: $DATE , $USER Procesos actuals: $NUMPROC , Limit: $LIMIT" >> alerta.log
	else
	echo "OK : $DATE , $USER procesos actuals: $NUMPROC , Limit: $LIMIT" >> alerta.log
fi
