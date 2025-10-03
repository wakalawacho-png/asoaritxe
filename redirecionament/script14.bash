#!/bin/bash

find / -type f 2>/dev/null | while read -r fichero; do
	"$fichero" >> llistaarchius.txt
	cat "$fichero" >> tot.txt 2>/dev/null
done

