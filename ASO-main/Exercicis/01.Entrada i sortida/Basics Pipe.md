# Exercicis de Pipes en Linux

1. Mostra només les 5 primeres línies del fitxer `/etc/passwd`.  
	head -n 5 /etc/passwd
1. Mostra només les 10 últimes línies del fitxer `/etc/passwd`.  
	tail -n 10 /etc/passwd
1. Llista els arxius de la carpeta actual i ordena’ls alfabèticament.  
	ls | sort
1. Llista els arxius de la carpeta actual i compta quants hi ha.  
	ls | wc -l
1. Llista només els noms d’usuari que tenen com a shell `/bin/bash`.  
	cat /etc/passwd | grep -f /bin/bash | cut -d:f1 
1. Llista el nom de tots els usuaris ordenats alfabèticament. Només s'ha de visualitzar el nom.  
	cat /etc/passwd | cut -d:f1 | sort
1. Compta quants usuaris no poden fer login en el sistema (tenen com a shell /bin/false).  
	wc -l /etc/passwd | grep -f /bin/false
1. Compta quantes vegades apareix la cadena ERR dins dels fitxers de registre del sistema. Utilitza la cerca recursiva i combina-la amb pipes per obtenir només el recompte total. (Ignora possibles missatges d’error si hi ha fitxers binaris o no llegibles).
	wc -l registre.log | grep 'ERR'

