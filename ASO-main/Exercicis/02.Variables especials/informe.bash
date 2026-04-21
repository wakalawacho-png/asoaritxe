#!/bin/bash
PARAMETRE="$*"

find / "*.log" | grep -i -n "$PARAMETRE"  > informe.log 2>>/dev/null

cat informe.log 

