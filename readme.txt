se debe convertir el archivo install_nmap.sh a base 64 

ejecuta el siguiente comando 

[Convert]::ToBase64String([IO.File]::ReadAllBytes("<ruta>"))

para conectar el storage account a la vm debes ejecutar el siguiente script 

sudo mount -t cifs //<nombre-de-tu-cuenta-de-almacenamiento>.file.core.windows.net/<namefilesystem> /mnt/azurefiles \
-o vers=3.0,username=<nombre-de-tu-cuenta-de-almacenamiento>,password='<clave-de-acceso>',dir_mode=0777,file_mode=0777,sec=ntlmssp