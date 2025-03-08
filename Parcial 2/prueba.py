import cv2
import os
import numpy as np

# Crear la carpeta 'capturas' si no existe
if not os.path.exists("capturas"):
    os.makedirs("capturas")

# Cargar el clasificador Haar para detección de rostros
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')

# Iniciar la captura de video desde la cámara
cap = cv2.VideoCapture(0)

# Diccionario para almacenar rostros detectados recientemente
rostros_detectados = {}
contador = 0  # Contador para las capturas

# Parámetros de detección
UMBRAL_DISTANCIA = 50  # Distancia mínima entre rostros para considerarlos nuevos
FRAMES_PARA_RESET = 30  # Cuántos cuadros debe desaparecer un rostro antes de eliminarlo

while True:
    ret, frame = cap.read()
    if not ret:
        break  # Si no se captura un frame, salir del bucle

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)  # Convertir a escala de grises
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.3, minNeighbors=5)

    rostros_actuales = []

    for (x, y, w, h) in faces:
        # Calcular el centro del rostro detectado
        cx, cy = x + w // 2, y + h // 2
        nuevo_rostro = (cx, cy)

        # Verificar si el rostro es nuevo comparando la distancia con los anteriores
        es_nuevo = True
        for rostro_ant in list(rostros_detectados.keys()):
            distancia = np.linalg.norm(np.array(nuevo_rostro) - np.array(rostro_ant))
            if distancia < UMBRAL_DISTANCIA:
                es_nuevo = False
                rostros_detectados[rostro_ant] = FRAMES_PARA_RESET  # Reiniciar contador de persistencia
                break

        if es_nuevo:
            # Dibujar un rectángulo alrededor del rostro detectado
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)

            # Agregar texto en la imagen del rostro antes de guardarla
            rostro = frame[y:y+h, x:x+w].copy()
            cv2.putText(rostro, "PENDEJO DETECTADO", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)

            # Guardar la captura del rostro con el texto
            filename = f"capturas/rostro_{contador}.jpg"
            cv2.imwrite(filename, rostro)
            print(f"Captura guardada: {filename}")

            # Agregar rostro a la lista de detectados
            rostros_detectados[nuevo_rostro] = FRAMES_PARA_RESET
            contador += 1  # Incrementar el contador

        rostros_actuales.append(nuevo_rostro)

    # Reducir el contador de persistencia de cada rostro
    rostros_detectados = {rostro: frames - 1 for rostro, frames in rostros_detectados.items() if frames > 0}

    # Agregar título a la ventana
    cv2.imshow('Detector de Pendejos', frame)

     # Salir del programa si se presiona la tecla "q"
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Liberar la cámara y cerrar ventanas
cap.release()
cv2.destroyAllWindows()
