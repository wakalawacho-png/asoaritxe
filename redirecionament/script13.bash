#!/bin/bash
find / -type f 2>/dev/null | while read -r fichero; do
	echo "$fichero" >> archius.txt
	ls -l "$fichero" >> propietats.txt
done
