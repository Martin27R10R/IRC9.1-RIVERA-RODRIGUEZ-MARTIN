#!/bin/bash

# Declaramos un array con las URLs
declare -a urls=(
    "https://www.facebook.com/"
    "https://www.instagram."
    "https://www.tiktok.com/"
)

# Creamos un archivo temporal para almacenar los resultados
file=$(mktemp)

# Bucle infinito para monitorear las URLs
while true; do
    # Agregamos la fecha actual al archivo temporal
    printf "$(date)\n" > "$file"

    # Iteramos sobre cada URL
    for url in "${urls[@]}"; do
        # Obtenemos el código de estado HTTP con curl
        status=$(curl -m 10 -s -I "$url" | head -n 1 | awk '{print $2}')
        # Guardamos la URL y el estado en el archivo temporal
        printf "%s,%s\n" "$url" "$status" >> "$file"
    done

    # Mostramos la salida en formato tabular
    column -s, -t "$file"

    # Eliminamos el archivo temporal
    rm -f "$file"

    # Creamos un nuevo archivo temporal para la próxima iteración
    file=$(mktemp)

    # Esperamos 10 segundos antes de repetir
    sleep 10
done
