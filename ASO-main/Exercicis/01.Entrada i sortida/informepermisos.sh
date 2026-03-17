#!/bin/bash
if [ -z "$1" ]; then
	ls -l  | cut -c 1-4,44-80 >> permisos.txt 2>/dev/null
else
	ls -l "$1" | cut -c 1-4,44-80 >> permisos.txt 2>/dev/null
fi
