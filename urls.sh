#!/bin/bash

# Lista de URLs a consultar
urls=("https://www.facebook.com/"
      "https://www.instagram.com/"
      "https://www.reddit.com/")

# Iterar sobre las URLs
for url in "${urls[@]}"; do
    # Obtener el código de estado HTTP
    status=$(curl -o /dev/null -s -w "%{http_code}" "$url")
    
    # Imprimir la URL y su estado
    echo "$url $status"
done
