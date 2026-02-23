#!/bin/bash

CONFIG="usuaris.cnf"
LOG="quota.log"
DATA=$(date)

if [ ! -f "$CONFIG" ]; then
	echo "ERORR: No existeix el fitxer $CONFIG"
	exit 1
fi

while IFS=: read -r USER QUOTA; do
