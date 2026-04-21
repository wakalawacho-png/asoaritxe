#!/bin/bash
PARAMETRE="$*"
find / "*.log" | grep -i -n "$PARAMETRE"  >> informe.log 2>>/dev/null
TOTAL=$(find / "*.log" | grep -i -c "$PARAMETRE")
echo "======= RESUM GLOBAL =======" >> informe.log
echo "total de coincidencies: $TOTAL" >> informe.log
echo "======= FI DE L' INFORME =======" >> informe.log
cat informe.log 

