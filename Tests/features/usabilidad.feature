Feature: Usabilidad Intuitiva (US018)
  Scenario Outline: Eficiencia en el flujo de grabación para operarios
    Given el técnico de piso abre la aplicación móvil MachinaSense
    When desea iniciar el monitoreo del activo "<activo_seleccionado>"
    Then debe poder iniciar la grabación acústica en un máximo de "<num_clics>" clics

    Examples:
      | activo_seleccionado | num_clics |
      | Motor Textil #02    | 2         |
      | Compresor #01       | 2         |