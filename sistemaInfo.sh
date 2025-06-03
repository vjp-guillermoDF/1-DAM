#!/bin/bash

# Con este comando instalamos una serie de utilidades adecuadas para los scripts
"Instalando apt update && apt install -y coreutils procps util-linux whois sudo"
apt update && apt install -y coreutils procps util-linux whois sudo
sleep 4
clear

# Con este comando mostramos el nombre del script
echo "Nombre del script: sistemaInfo.sh"
sleep 4
clear

# Este comando muestra la fecha y hora actual #
echo "La fecha y hora actual son:"
date
sleep 4
clear

# Este comando muestra el tiempo que lleva encendido el sistema
echo "Tiempo que el sistema lleva encendido:"
uptime -p
sleep 4
clear

# Mostrar la memoria RAM libre y en uso
echo "Informacion de la memoria RAM:"
free -h
sleep 4
clear

# Este comando muestra los discos montados y su espacio disponible
echo "Espacio disponible en los discos montados:"
df -h
sleep 4
clear

# Este comando muestra la cantidad de usuarios conectados
echo "Usuarios conectados actualmente:"
whoami
sleep 4
clear

# Este comando cuenta un chiste de despedida
echo "Nos vamos del sistema en diez segundos. Pero antes, le dice un argentino a otro. 'Che vos sabes que cada ves que hablas sonas como un gallo?? - Contenta el otro: Y KIKIRIKILIHAAGA?Â"
sleep 10
exit
