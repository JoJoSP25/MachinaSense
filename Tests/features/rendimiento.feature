Feature: Rendimiento en Tiempo Real (US016)
  Scenario Outline: Devolución rápida de diagnósticos para toma de decisiones
    Given el operario envía el audio de la maquinaria "<tipo_maquina>" a la nube
    When el tamaño del archivo de audio comprimido es "<peso_archivo>" KB
    Then el sistema debe procesar la solicitud y devolver el diagnóstico en menos de "<tiempo_max_respuesta>" segundos

    Examples:
      | tipo_maquina | peso_archivo | tiempo_max_respuesta |
      | Telar        | 500          | 3                    |
      | Motor        | 800          | 5                    |
      