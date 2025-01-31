#!/bin/bash
# Ruta de la carpeta a verificar o crear segun sea necesario
CARPETA="./MiCarpeta" #crea "MiCarpeta en la ruta que sea ejecutado 
# Nombre del archivo a buscar para backup o lo crea
ARCHIVO="ArchivoPrueba.txt"
# Obtener la fecha actual para el titulo del backup del archivo
FECHA=$(date +%F)
# Crear la carpeta si no existe usando la condicion IF
if [ ! -d "$CARPETA" ]; then
    echo "La carpeta '$CARPETA' no existe. Creándola..." #Muestra en pantalla un mensaje para crear carpeta en caso de que no este
    mkdir -p "$CARPETA" #comando para crear la carpeta
else
    echo "La carpeta '$CARPETA' ya existe." #Carpeta encontrada por eso se salto la condicion de arriba
fi
# Ruta completa del archivo
RUTA_ARCHIVO="$CARPETA/$ARCHIVO" #busca el archivo dentro de la carpeta
# Condicional if similar a la de arriba para el archivo 
if [ -f "$RUTA_ARCHIVO" ]; then
    echo "El archivo '$ARCHIVO' ya existe. Creando un backup..." #Mensaje en pantalla para crear el backup del archivo porque paso la condicion
    mv "$RUTA_ARCHIVO" "$CARPETA/${ARCHIVO%.txt}_backup_$FECHA.txt" #comando para crear el backup del archivo
else
    echo "El archivo '$ARCHIVO' no existe. Creándolo..." #mensaje en pantalla para avisar que esta creando el archvo porque no paso la condici>
    touch "$RUTA_ARCHIVO" #Comando para crear el archivo dentro de la carpeta
fi
echo "Archivo '$ARCHIVO' creado exitosamente en '$CARPETA'."
