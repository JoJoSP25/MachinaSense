Feature: Filtro de Ruido IA (US013)
  Como supervisor de transformación digital, quiero que el asistente de inteligencia artificial aísle automáticamente el ruido
  de fondo durante la grabación para garantizar que el análisis se centre en el motor.

  Scenario Outline: Aislamiento de señal en entorno de alto ruido ambiental
    Given el motor de IA recibe un archivo de audio con un nivel de ruido de fondo de "<ruido_db>" dB
    When el sistema procesa el espectro de frecuencias aplicando el filtro acústico
    Then el algoritmo aísla el sonido del motor con una precisión mayor al "<precision_minima>" y descarta 
    sonidos externos de tipo "<tipo_ruido>"

    Examples:
      | ruido_db | precision_minima | tipo_ruido       |
      | 80       | 85%              | Voces y pisadas  |
      | 90       | 85%              | Ruido eléctrico  |
      | 75       | 90%              | Metales cayendo  |
      