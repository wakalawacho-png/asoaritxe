#!/bin/bash

TOTAL=0
for PARAM in "$@"
do
	TOTAL=$(( TOTAL + 1 ))
	echo "$TOTAL $PARAM"
done

