#exercicis


1. cat /etc/passwd | head -n 5
2. cat /etc/passwd | tail -n 10
3. ls | sort
4. ls | wc -l
5. grep '/bin/bash' /etc/passwd | cut -d: -f1
6. cut -d: -f1 /etc/passwd | sort
7. grep '/bin/false' /etc/passwd | wc -l 
8. grep -R "ERR" /var/log 2>/devnull | wc -l
