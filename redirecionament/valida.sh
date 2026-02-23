#!/bin/bash

if [ -z "$1" ]
then
	echo "error: no s'ha especificat cap fitxer."
	echo "s'han rebut $# parametres"
	exit 1
fi
echo "fitxer o parametre rebut: $1"

