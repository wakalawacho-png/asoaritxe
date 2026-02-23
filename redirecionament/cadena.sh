#!7bin/bash
ENTRADA="$*"

TOTALC=$(echo -n $ENTRADA | wc -c)
echo -e "$ENTRADA \nTOTAL CARACTERS: $TOTALC "

