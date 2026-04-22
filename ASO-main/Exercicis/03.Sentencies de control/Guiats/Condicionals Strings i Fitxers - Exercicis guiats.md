# PRÀCTICA GUIADA: Comparacions de text i comprovacions de fitxers

## Recordatori teòric

### Comparacions de text

| Operador | Significat      | Exemple                 |
| -------- | --------------- | ----------------------- |
| `=`      | Igual           | `[ "$STR" = "$STR2" ]`  |
| `!=`     | Diferent        | `[ "$STR" != "$STR2" ]` |
| `-z`     | Cadena buida    | `[ -z "$STR" ]`         |
| `-n`     | Cadena no buida | `[ -n "$STR" ]`         |

---

### Comparacions amb fitxers

| Operador | Significat           | Exemple             |
| -------- | -------------------- | ------------------- |
| `-e`     | Existeix             | `[ -e fitxer.txt ]` |
| `-f`     | És un fitxer regular | `[ -f fitxer.txt ]` |
| `-d`     | És un directori      | `[ -d carpeta ]`    |
| `-r`     | És llegible          | `[ -r fitxer.txt ]` |
| `-w`     | És modificable       | `[ -w fitxer.txt ]` |
| `-x`     | És executable        | `[ -x script.sh ]`  |

---

## Activitat 1: Missatge d’ajuda amb `-h`

### Crea un script anomenat `ajuda.sh`

```bash
#!/bin/bash

if [ "$1" = "-h" ]
then
  echo "Ús: $0 <nom_fitxer>"
  echo "Mostra informació bàsica d’un fitxer."
  exit 0
fi

echo "No s’ha demanat ajuda. Continua l’execució..."
```

### Executa'l per a cada una de les situacions

[Captura de pantalla]
<img width="798" height="245" alt="image" src="https://github.com/user-attachments/assets/9bbaa2ce-7376-473f-a5d1-11a3031c4be4" />


### Respòn a...

1. Què fa l’script quan el primer paràmetre és `-h`? surt un misatje sobre com executar el script
2. Què passa si no es posa cap argument? surt el mateix misatje que si posesis un argument qualsevol(excepte -h)
3. Quina variable s’està comparant i amb quin operador? es compara el primer argument amb un =

---

## Activitat 2: Validar si hi ha argument amb `-z` i `$#`

### Crea `valida.sh`

```bash
#!/bin/bash

if [ -z "$1" ]
then
  echo "Error: no s’ha especificat cap fitxer."
  echo "S’han rebut $# paràmetres."
  exit 1
fi

echo "Fitxer o paràmetre rebut: $1"
```

### Executa'l per a cada una de les situacions

[Captura de pantalla]
<img width="788" height="257" alt="image" src="https://github.com/user-attachments/assets/810137c5-2fbd-43ea-9a67-6bbc05adc941" />


### Respòn a...

1. Quin operador detecta si la cadena està buida? el -z
2. Quina diferència hi ha entre `$1` i `$#`? $1 es el primer argumet, $# es el numero total de arguments
3. Si passes diversos arguments, què mostrarà `$1`? mostrara sempre el primer argument

---

## Activitat 3: Comprovació de fitxer amb `-e`

### Crea `comprova.sh`

```bash
#!/bin/bash

if [ -z "$1" ]; then
  echo "Cal indicar un fitxer!"
  exit 1
fi

if [ -e "$1" ]; then
  echo "El fitxer '$1' existeix!"
else
  echo "El fitxer '$1' NO existeix!"
fi
```

### Executa'l per a cada una de les situacions

[Captura de pantalla]
<img width="819" height="252" alt="image" src="https://github.com/user-attachments/assets/fd9bc7e0-2b5c-4cb0-ae30-eddc4e5a2a94" />

### Respòn a...

1. Quin operador comprova si el fitxer existeix? el -e
2. Si en comptes d’un fitxer passes un directori, què passa? et diu que existeix
3. Com ho canviaries perquè només acceptés fitxers regulars?
   amb el operardor -f
   (if [ -z "$1" ]; then)

---

##  Activitat 4: És fitxer, directori o executable?

### Crea `tipus.sh`

```bash
#!/bin/bash

for ITEM in "$@"; do
  if [ -d "$ITEM" ]; then
    echo "$ITEM és un directori."
  elif [ -f "$ITEM" ]; then
    echo "$ITEM és un fitxer regular."
  elif [ -x "$ITEM" ]; then
    echo "$ITEM és executable."
  else
    echo "$ITEM no existeix o no és accessible."
  fi
done
```

### Executa'l per a cada una de les situacions

[Captura de pantalla]
<img width="794" height="418" alt="image" src="https://github.com/user-attachments/assets/623dd419-6a61-424f-9600-77316936cd58" />

### Preguntes de reflexió

1. Què passa si passes més d’un argument? et mostra la sortida que donaria el seu cas
2. Per què aquí s’utilitza `"$@"` en comptes de `$*`? per a que tracti els arguments com una llista no com un sol
3. Quin tipus d’estructura de control s’utilitza per diferenciar casos?
   -d, -f , -x amb if i elif
