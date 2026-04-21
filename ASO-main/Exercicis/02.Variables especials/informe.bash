#!/bin/bash
PARAMETRE="$1"

find / "*.log" | grep -i -n "$1"  > informe.log 2>>/dev/null

cat informe.log 

