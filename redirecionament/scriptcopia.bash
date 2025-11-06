#!/bin/bash
DIRACT=$ (pwd)
echo "$DIRACT"
QUISOC=$ (whoami)
echo "$DIRACT"
ROOTUSER=$ (cat /etc/passwd | grep "root")
echo "$ROOTUSER"
