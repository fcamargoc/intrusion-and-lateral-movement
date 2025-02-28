#!/bin/bash

# Actualizar los paquetes
sudo apt update -y

# Instalar nmap
sudo apt install nmap -y

# Crear el directorio franklin
sudo mkdir /home/franklin

echo "Nmap instalado y directorio franklin creado."