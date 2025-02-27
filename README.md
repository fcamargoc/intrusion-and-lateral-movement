# intrusion-and-lateral-movement
Laboratorio con fines educativos.

### Objetivo
Evaluar la seguridad de la red objetivo mediante la simulación de una intrusión y movimiento lateral para identificar vulnerabilidades explotables.

### Fase 1 Reconocimiento

El primer paso para toda prueba de prenetracion es realizar un reconomiento del objetivo ha atacar, en esta oportunidad vamos a utilizar una herramienta de OSINT
llamada Shodan.

Vamos realizar una busqueda de ips publicas que tengan el puerto 22 accesible desde internet adicional filtramos por pais de origen. ejecutamos la busqueda con los siguientes parametros
port: 22 country:US

![image](https://github.com/user-attachments/assets/704c1d08-8019-4a42-b523-8f4a207948d5)


### Fase 2 Explotación 

Ya teniendo claro el panorama debemos definir las herramientas que vamos a utilizar para realizar un ataque exitoso, en este caso serian las siguientes: 

- Kali Linux OS 
- Hydra
- Diccionario de contraseñas && usuarios

Lo primero que debemos realizar es la instalacion del sistema operativo Kali Likux, generalmente el sistema operativo ya cuenta con la libreria de Hydra, posterior a ello debemos realizar la busqueda de un diccionario de contraseñas el cual nos va a servir para realizar un ataque de fuerza bruta y poder acceder  al servidor objetivo. la pagina que vamos a utilizar para acceder a un diccionario es https://www.skullsecurity.org/wiki/Passwords

![image](https://github.com/user-attachments/assets/54c3c958-4e2e-4dda-94cf-92ea67ca95db)


dentro de Kali Linux vas a crear dos archivos con extensión txt el cual va utilizar hydra para realizar la explotacion, uno va contener el nombre de los usuarios y el otro las contraseñas. en este caso los voy a nombrar users.txt y password.txt.

abrimos una terminal en modo root y nos debemos dirigir a la ruta donde se encuentran los archivos.

![image](https://github.com/user-attachments/assets/f40aa93e-ce16-4515-946d-af6db9b34a94)


estan alli ejecutamos el siguiente script 

hydra -l <nombre de usuario> -P <ruta de la lista de contraseñas> <dirección IP pública de tu VM en Azure> <protocolo>

hydra -L users.txt -P password.txt 172.191.63.195 ssh


el va iniciar a realizar el ataque de fuerza bruta utilizando los dos archivos txt que le estamos indicando en el script anterior y como resultado nos debe arrojar el usuario y contraseña con el cual se puede iniciar sesion en el servidor objetivo.

![image](https://github.com/user-attachments/assets/4e1a0876-435b-494a-aa4d-1ddb2322e9e0)


Despues de obtener las credenciales ya podemos iniciar de forma exitosa la conexion remoto con el servidor objetivo.

ssh ADMINISTRADOR@172.191.63.195

![image](https://github.com/user-attachments/assets/95bbefd6-8b00-491f-8a0c-c2df65f4689f)





