Feature: Captura Acústica (US005)
  Como técnico de mantenimiento, quiero grabar el sonido de la maquinaria directamente con el micrófono de mi teléfono celular 
  para obtener una captura acústica sin necesidad de instalar sensores físicos.

  Scenario Outline: Captura exitosa de audio en diferentes tipos de maquinaria
    Given el operario ha iniciado sesión y se encuentra frente a un activo de tipo "<tipo_maquina>"
    When el operario presiona "Iniciar grabación" durante "<tiempo_segundos>" segundos en un entorno 
    industrial con "<ruido_db>" dB de ruido
    Then el sistema captura el audio, guarda el archivo temporalmente y muestra el mensaje "<mensaje_estado>"

    Examples:
      | tipo_maquina   | tiempo_segundos | ruido_db | mensaje_estado                       |
      | Motor Textil   | 5               | 75       | Grabación exitosa - Procesando IA    |
      | Compresor      | 10              | 85       | Grabación exitosa - Entorno ruidoso  |
      | Faja Transp.   | 7               | 60       | Grabación exitosa - Procesando IA    |