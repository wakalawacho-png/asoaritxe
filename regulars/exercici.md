# exercicis expresions regulars

* nomes vocals

---

[a+ aeiouAEIOU ]+$

* un numero amb o sense signe + o -**
---

[+-]?[0-9]+$

* nomes primera lletra majuscula

--

[A-Z][a-z]*$


* un o mes espais

^\s+

* tres repetits exactes de silaba h seguida de minuscula

(h[a-z]){3}$

* correu senzill amb @ i "." en domini
[^@]+@[^@]+\.[^@]+$

* codi posta de la provincia girona
^17[0-9]{3}$

* frases acabades en ? o !

^.*[?!]$

* ip simple

^([0-9]{1,3}\.){3} [0-9]{1,3}$

* comença per "error" o "err"

^(error:|err:)

* numeros binaris 
^[01]+$
