#!/bin/bash
while [ $# -gt 0 ]; do
	echo "total parametres: $#"
	echo "\$1: $1"
	shift
done
