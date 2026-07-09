Feature: Confiabilidad de Conexión y Gestión Offline (US017)
  Scenario Outline: Sincronización de datos ante interferencias eléctricas
    Given el técnico realiza el escaneo en una zona con conectividad de tipo "<estado_red>"
    When finaliza la captura acústica en la aplicación
    Then el sistema almacena el registro localmente y lo sincroniza con la base de datos cuando la conexión sea "<red_requerida>"

    Examples:
      | estado_red   | red_requerida |
      | Offline      | Wi-Fi         |
      | Intermitente | 4G / Wi-Fi    |
      