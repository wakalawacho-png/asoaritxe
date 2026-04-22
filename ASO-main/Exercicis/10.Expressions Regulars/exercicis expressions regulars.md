# Exercicis amb expressions regulars

* Només vocals (una o més)**
grep -E "[aeiou]+"
---

* Un número amb o sense signe + o –**
grep -E "[^0-9]
---

* Només primera lletra en majúscula. 
grep -E ^[A-Z]
---

* Un o més espais al principi. Utilitza \s per a indicar un espai.
grep -E ^+/s
---

* Tres repetits exactes de la síl·laba "h" seguida per una lletra minúscula
grep -E "^h${3}"
---

* Correu senzill amb @ i "." en el domini  (no estricte)
grep -E "^[A-Za-z0-9]@gmail.com$"
---

* Codi postal de la provincia de Girona
grep -E "^17[0-9]{3}$"
---

* Frases acabades en ? o !
grep -E "?$|!$"
---

* IP simple (digits + punts)
grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}"
---

* Comença per error: o err:
grep -E "^error|^err"
---

* Números binaris (només 0 i 1)**
grep -e "[0-1]"
