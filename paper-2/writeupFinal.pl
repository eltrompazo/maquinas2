maquina paper htb-------------------linux 

aprendizaje 

Web
Vulnerability Assessment
Injection
Common Applications
Outdated Software
Wordpress
Polkit
Penetration Tester Level 1
System Exploitation
Authentication bypass
Information Disclosure
Directory Traversal

------------------------------------------

en esta maquina la cosa es que cuando entramos a la ip no nos muestra nada ineresante, hemos fuzeado los subdomininos
ytambien los directorios, pero no nos da nada interesante. hemos metido por burpsuite y nos ha dado un subdomino 

HTTP/1.1 403 Forbidden
Date: Sun, 15 Jan 2023 22:44:23 GMT
Server: Apache/2.4.37 (centos) OpenSSL/1.1.1k mod_fcgid/2.3.9
X-Backend-Server: office.paper < ---------------------------------------------------------
Last-Modified: Sun, 27 Jun 2021 23:47:13 GMT
ETag: "30c0b-5c5c7fdeec240"
Accept-Ranges: bytes
Content-Length: 199691
Connection: close
Content-Type: text/html; charset=UTF-8


con esto nos lo hemos metido en el etc/hosts y hemos obtenido una pagina workpress que tenia la version 5.4.2 

hemos buscado algo por internet poniendo la version y nos ha dado que tenia una pagina por defecto 
que era estatica y podemos acceder a ver que tiene dentro 

http://office.paper/?static=1/

ahi nos ha dado una direccion de chat 

http://chat.office.paper/register/8qozr226AhkCHZdyY 

en esa pagina no hemos podido acceder hasta uqe no hemos puesto en el etc/hosts y hemos accedido al chat

ahi podemos ver que han puesto un bot que podemos preguntarle cosas sobre el sistema, con el comando 
help nos arroja lo que puede y no puede hacer, puede mostrar archivos y listar carpetas... viendo carpetas 
podemos ver que se llama hubot 

hemos buscado en internet y hemos visto que tiene una carpeta en concreto que es intersante que se llama .env

al ver que tiene esa carpeta/archivo (no recuerdo) podemos ver que tiene una contraseña y tambien un usuario
hemos metido eso en ssh pero no nos ha dado respuesta, por lo que hemos cateado el /etc/passwd y vemos que tiene
un usuario que se llama dwitne o algo asi, y hemos puesto en el ssh ese usuario y esa contraseña y listo. 

una vez dentro de la maquina hemos podido meter un linpeas y nos ha arrojado que es vulnerable a polkit 

lo hemos mandado con un servidor python3 y ese exploit lo que hace es crearte un usuario 

VER DENTRO DEL EXPLOIT QUE USUARIO TIRA Y EL README

cuando lo ejecutas lo hace por un periodo corto de tiempo 

la contraseña y el usuario que crea lo tienes dentro del sh y el readme

cuando entras con ese usuario tienes que poner "sudo bash" y listo, ya estas dentro como root
