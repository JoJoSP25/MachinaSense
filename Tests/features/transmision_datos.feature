Feature: Transmisión Segura de Datos (US019)
  Scenario Outline: Cifrado de información corporativa en tránsito
    Given la aplicación móvil se conecta con el backend para subir datos
    When se transmiten cargas útiles de tipo "<tipo_carga>"
    Then la conexión debe estar asegurada mediante el protocolo "<protocolo_seguridad>"

    Examples:
      | tipo_carga            | protocolo_seguridad |
      | Archivo de audio .wav | HTTPS/TLS           |
      | Credenciales Login    | HTTPS/TLS           |