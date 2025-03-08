#!/bin/bash

# Declaramos un array con las URLs
declare -a urls=(
    "https://www.facebook.com/"
    "https://www.instagram."
    "https://www.tiktok.com/"
    "https://es.pornhub.com/"
    "https://www.xvideos.com/"
)

# Archivos para almacenar los resultados
csv_file="URLcsv.csv"
json_file="URLjson.json"
xml_file="URLxml.xml"
yml_file="URLyml.yml"

# Agregamos cabeceras a los archivos
echo "URL,Status" > "$csv_file"
echo "[" > "$json_file"
echo "<\urls>" >> "$xml_file"
echo "urls:" > "$yml_file"

# Iteramos sobre cada URL
for url in "${urls[@]}"; do
    # Obtenemos el código de estado HTTP con curl
    status=$(curl -m 10 -s -I "$url" | head -n 1 | awk '{print $2}')
    
    # Guardamos la URL y el estado en el archivo CSV
    echo "$url,$status" >> "$csv_file"
    
    # Guardamos los datos en el archivo JSON
    echo "  {\"url\": \"$url\", \"status\": \"$status\"}," >> "$json_file"
    
    # Guardamos los datos en el archivo XML
    echo "    <link>$url</link>" >> "$xml_file"
    echo "    <status>$status</status>" >> "$xml_file"
    echo "  </url>" >> "$xml_file"
    
    # Guardamos los datos en el archivo YAML
    echo "  - url: $url" >> "$yml_file"
    echo "    status: $status" >> "$yml_file"
done

echo "]" >> "$json_file"
echo "</urls>" >> "$xml_file"
