#!/bin/bash

# Instalar las utilidades de tar, gzip, bzip2, nano y tree sin pedir confirmacion

echo "Instalando las utilidades tar, gzip, bzip2, nano y tree"

apt update && apt install -y tar gzip bzip2 nano tree

# Crear el directorio backup

echo "Creando el directorio backup"

mkdir backup

# Acceder a backup

echo "Accediendo a backup"

cd backup

# Mostrar los tiempos de backup y agruparlo en un archivo llamado analisis

echo "Se van a almacenar los tiempos de ejecucion de backup en tres copias distintas, la primera sin comprimir"

{ time tar -cf /backup/etc-backup.tar /etc; } 2>&1 | grep -E 'real|user|sys' > analisis.txt
{ time tar -czf /backup/etc-backup.tar.gz /etc; } 2>&1 | grep -E 'real|user|sys' >> analisis.txt
{ time tar -cjf /backup/etc-backup.tar.bz2 /etc; } 2>&1 | grep -E 'real|user|sys' >> analisis.txt

# Mostrar la informacion detallada de los archivos y directorios dentro de analisis

echo "Vamos a mostrar informacion detallada de los archivos y directorios dentro del archivo de analisis"

ls -lh >> analisis.txt

# Extracciones

echo "Llevaremos a cabo las extracciones"

tar -xf etc-backup.tar
tar -xzf etc-backup.tar.gz
tar -xjf etc-backup.tar.bz2

echo "Todo se ha llevado a cabo correctamente"
