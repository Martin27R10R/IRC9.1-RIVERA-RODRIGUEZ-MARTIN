#!/bin/bash
# Declaramos un array con las URLs
declare -a urls=(
    "https://www.facebook.com/"
    "https://www.instagram."
    "https://www.tiktok.com/"
)

# Creamos un archivo temporal para almacenar los resultados
file=url.csv

# Bucle infinito para monitorear las URLs
    # Agregamos la fecha actual al archivo temporal
printf "$(date)\n" > "$file"
# Iteramos sobre cada URL
for url in "${urls[@]}"; do
# Obtenemos el código de estado HTTP con curl
	status=$(curl -m 10 -s -I "$url" | head -n 1 | awk '{print $2}')
        # Guardamos la URL y el estado en el archivo temporal
        printf "%s$url,$status\n" >> "$file"
done
# Mostramos la salida en formato tabular
column -s, -t "$file"
