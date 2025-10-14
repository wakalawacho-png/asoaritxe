#!/bin/bash
>resultats.txt
while read LINE; do
  ls -l "$LINE" >> resultats.txt 2>errors.txt 
done
#sh scriptfitxers.bash < fitxers.txt

