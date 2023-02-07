maquina bank htb ---------------------------------- linux 

aprendizajes

PHP
Penetration Tester Level 2
Web
Vulnerability Assessment
Common Applications
Cryptography
Security Tools
Metasploit
Web Site Structure Discovery
SUID Exploitation
Clear Text Credentials
Arbitrary File Upload
Misconfiguration

---------------------------------------------------------

en esta maquina hemos visto que tiene una explicacion de apache al principio pero es un poco rabbit hole hemos visto, 

lo que he hecho es poner bank.htb en el /etc/hosts para poder fuzzear de una manera mas limpia,
hemos fuceado y hemos visto unos directorios interesantes 

302      GET      188l      319w     7322c "http://bank.htb/ => login.php"
301      GET        9l       28w      304c http://bank.htb/assets => http://bank.htb/assets/
301      GET        9l       28w      301c http://bank.htb/inc => http://bank.htb/inc/
403      GET       10l       30w      288c http://bank.htb/server-status
301      GET        9l       28w      314c "http://bank.htb/balance-transfer => http://bank.htb/balance-transfer/"


lo que podemos ver en balance.transfer es que concretamente hay un archivo un poco mas pequeño que los demas 
y destaca un poco de los demas, y lo que hemos hecho es descargarlo para poder catearlo 

habia un nombre y una contraseña. 

===UserAccount===
Full Name: Christos Christopoulos
Email: chris@bank.htb
Password: !##HTBB4nkP4ssw0rd!##
CreditCards: 5
Transactions: 39
Balance: 8842803 .


hemos probado por ssh pero no nos ha dado resultado, asi que nos hemos metido 
dentro dento del directorio que nos ha proporcionado el fuzzeo y hemos podido entrar

en la pestaña suport podemos subir archivos pero solo imagenes en teoria pero nos ha cogido 
uno con la extension .htb 

lo que hemos puesto es una shell de php one line para poder poner cmd en el link y poder ejecutar 
comandos remotos, y listo, hemos puesto una shell de bash encodeada en url y listo, hemos entrado 

una vez dentro hemos enumerado capabilitis, binarios de suid y hemos visto varios documentos pero no arrojaba nada
hasta que hemos encontrado un binario que pasa desapercido en la ruta 

/usr/bin/emergency

que lo hemos ejecutado para ver que hace y lo que hace es meterte de una a root y listo

ya lo tendrias. 


