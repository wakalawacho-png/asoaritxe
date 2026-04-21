# PRÀCTICA GUIADA: La comanda `case` en Bash

## Estructura `case` 

```bash
case VARIABLE in
    valor1)
        # Ordres
        ;;
    valor2)
        # Ordres
        ;;
    *)
        # Per defecte
        ;;
esac
```

* Cada bloc acaba amb `;;`.
* El `*` actua com a "else" (cap coincidència).
* Es poden unir diversos patrons amb `|` (p. ex. `start | Start`).

---

## 🧪 Activitat 1: Prova bàsica amb text fix

### Crea un fitxer anomenat `colors.sh`

```bash
#!/bin/bash

color="blau"

case $color in
  vermell)
    echo "Color càlid"
    ;;
  blau)
    echo "Color fred"
    ;;
  verd)
    echo "Color natural"
    ;;
  *)
    echo "Color desconegut"
    ;;
esac
```

### Executa'l per a cada una de les situacions

[Captura de pantalla]
<img width="561" height="309" alt="image" src="https://github.com/user-attachments/assets/bf064ca1-6a08-45f7-863f-5d185d63acb3" />


### Preguntes de reflexió

1. Quina variable s’està avaluant dins del `case`?
   la variable $color
3. Quina línia indica el final de cada bloc?
   la que es nomes ;;
5. Què fa el bloc amb `*`?
    fa que en cas de que el argument o variable no coincideixi amb cap dels casos executa una comanda
---

## 🧩 Activitat 2: `case` amb paràmetre

### Crea `accio.sh`

```bash
#!/bin/bash

opcio=$1

case $opcio in
  start | Start)
    echo "Iniciant el servei..."
    ;;
  stop | Stop)
    echo "Aturant el servei..."
    ;;
  restart | Restart)
    echo "Reiniciant el servei..."
    ;;
  *)
    echo "Ús: $0 {start|stop|restart}"
    exit 1
    ;;
esac
```

###  Executa el programa amb diferent nombre d'arguments (cada un dels casos)

[Captura de pantalla]
<img width="443" height="312" alt="image" src="https://github.com/user-attachments/assets/6d2192d3-f52a-415d-a5fa-a27285212b64" />

### Preguntes de reflexió

1. Què passa quan l’opció no coincideix amb cap cas? et mostra una linea la cual et diu com utilitzar l' script
2. Per què hi ha una línia amb `exit 1`? per aturar completament l' script
3. Quina diferència hi ha entre `start` i `Start`? la majuscula, l' script diferencia majuscules i minuscules
4. Com s’indica més d’un patró en una mateixa línia? amb un pipe |
