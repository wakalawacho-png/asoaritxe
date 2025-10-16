#!/bin/bash
> permisos.txt
while read LINE; do
   ls -l "$LINE" | cut -c 1-11,45-80 >> permisos.txt 2>errors.txt
done
