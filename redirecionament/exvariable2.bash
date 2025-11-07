#!/bin/bash
if [ $# -ne 1 ]; then
	echo "us: $0 <carrega_limit>"
	exit 1
fi

LIMIT=$1

CURLOAD=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | cut -c 1-4)

CURLOADENT=$(echo "$CURLOAD * 100 / 1" | bc)
LIMITENT=$(echo "$LIMIT * 100 / 1" | bc)

DATA=$(date)
if [ $CURLOADENT -gt $LIMITENT ]; then 2>>/dev/null
	echo "Alert: $DATA $USER Carrega actual $CURLOAD , Limit: $LIMIT" >> sistema.log
else
	echo "Ok: $DATA $USER Carrega actual: $CURLOAD , Limit: $LIMIT" >> sistema.log
fi
