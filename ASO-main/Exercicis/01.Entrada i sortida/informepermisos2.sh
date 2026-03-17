#!/bin/bash

ls -l "$1" | cut -c 1-4,44-60 >> permisos.txt 2>/dev/null
ls -l  | cut -c 1-4,44-60 >> permisos2.txt 2>/dev/null

