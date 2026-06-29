# MachinaSense — Prototipo de Dashboard Web

> **Software de mantenimiento predictivo basado en IA acústica para maquinaria industrial**  
> Startup: MachinaSense · Curso: 1ASI0786 – Ingeniería de Requisitos · UPC 2026

---

## 📋 Descripción

MachinaSense es un prototipo funcional de dashboard web para una plataforma SaaS de mantenimiento predictivo. Permite a técnicos y jefes de planta monitorear maquinaria industrial mediante análisis acústico simulado con IA, sin necesidad de sensores físicos costosos — solo el micrófono del smartphone.

El prototipo cubre las historias de usuario del Sprint 1, 2 y 3 del TB3, incluyendo:

- **EP01** Gestión de usuarios y activos
- **EP02** Monitoreo y captura acústica
- **EP03** Semáforo de salud, alertas y reporte PDF
- **EP04** Filtro de ruido IA y análisis espectral
- **EP05** Dashboard de KPIs en tiempo real
- **EP06** Historial de diagnósticos por activo

---

## 🗂️ Estructura del Proyecto

```
└── machinasense.html   # Versión bundled (todo en un solo archivo)
```

> **Para uso inmediato:** abrir `machinasense.html` directamente en el navegador. No requiere servidor ni dependencias externas.

---

## 🖥️ Vistas del Prototipo

### 1. Panel General (`/dashboard`)
Panel de control central para el **Jefe de Planta**.

| Sección | Historia de Usuario |
|---|---|
| KPIs en tiempo real | US012 — Dashboard KPIs |
| Grid de activos con semáforo | US009 — Semáforo de Salud |
| Oscilograma animado | US005 — Captura Acústica |
| Calendario predictivo | US007 — Calendario Predictivo |
| Gráfico de tendencia 30 días | US022 — Historial Acústico |

### 2. Escáner Acústico (`/scanner`)
Simula la **captura de audio desde smartphone** y el análisis IA. Flujo completo:

```
[Seleccionar activo] → [Presionar micrófono] → [Grabación 5s]
       ↓
[Paso 1: Captura de Audio]
[Paso 2: Filtro de Ruido IA]   ← US013
[Paso 3: Análisis Espectral]
[Paso 4: Diagnóstico Final]
       ↓
[Semáforo: Verde / Amarillo / Rojo]   ← US009
[Datos técnicos: Hz, RPM, Temp, Confianza IA]
[Botón: Generar Reporte PDF]   ← US011
```

**Activos con resultado diferente según selección:**
- `Motor Textil #01` → 🟢 NORMAL (94% confianza)
- `Motor Textil #02` → 🟡 ATENCIÓN — Desalineación 220 Hz (78%)
- `Motor Textil #03` → 🔴 FALLA CRÍTICA — Rodamiento 840 Hz (91%)
- `Compresor #01`   → 🟢 NORMAL (88%)
- `Turbina #01`     → 🟡 ATENCIÓN — Vibración 310 Hz (72%)

### 3. Activos / Máquinas (`/machines`)
Catálogo de los 8 activos registrados en la planta. Incluye:
- Búsqueda en tiempo real por nombre, sector o tipo
- Barra visual de confianza IA por activo
- Pills de estado con colores semáforo
- Botón **"+ Agregar Activo"** con modal de registro (US021)

### 4. Historial (`/history`)
Timeline cronológico filtrable por activo y estado. Muestra:
- Fecha y hora del escaneo
- Diagnóstico completo de la IA
- Frecuencias detectadas
- Técnico responsable

Cubre: **US022 — Historial de registros acústicos**

### 5. Centro de Alertas (`/alerts`)
Lista de alertas activas con prioridad:
- 🔴 Falla crítica — Motor Textil #03
- 🟡 Atención — Motor Textil #02
- 🟡 Atención — Turbina #01

Cubre: **US008 — Alertas Preventivas**

---

## 🎨 Design System

### Paleta de colores
```css
--bg:        #0c0e14    /* Fondo principal — negro industrial */
--surface:   #131720    /* Superficie de tarjetas */
--accent:    #00d4ff    /* Cian eléctrico — color de marca */
--green:     #22c55e    /* Estado: Normal */
--yellow:    #f59e0b    /* Estado: Atención */
--red:       #ef4444    /* Estado: Crítico */
```

### Tipografía
- **Display/UI:** Space Grotesk (Google Fonts) — sans-serif moderno
- **Datos/código:** JetBrains Mono — para frecuencias, RPM, timestamps

### Decisión de diseño
La paleta oscura con acento cian refleja el entorno industrial (plantas con poca luz, pantallas de control), diferenciándose de los dashboards claros de competidores como Tractian. El semáforo de 3 estados es el elemento firma del producto, siempre visible y de lectura instantánea.

---

## 🧩 Arquitectura del Código

### `index.html`
Contiene la estructura de las 5 vistas como secciones `<section class="view">`. Solo una tiene la clase `active` a la vez. Sistema de navegación SPA sin router externo.

```html
<section class="view active" id="view-dashboard"> ... </section>
<section class="view"        id="view-scanner">   ... </section>
<section class="view"        id="view-machines">  ... </section>
<section class="view"        id="view-history">   ... </section>
<section class="view"        id="view-alerts">    ... </section>
```

### `css/styles.css`
Sistema de variables CSS con tokens de diseño. Estructura por secciones:
```
:root → Variables globales
Sidebar → Navegación lateral
Topbar → Barra superior
Cards → Contenedores de contenido
KPI Row → Métricas principales
Machine Grid/Table → Catálogo de activos
Scanner → Flujo de escaneo acústico
Semáforo → Indicador de salud
History → Timeline cronológico
Alerts → Centro de notificaciones
Modals → Add Machine + Reporte PDF
Buttons, Toast → Componentes UI
Responsive → Mobile breakpoints
```

### `js/app.js`
Sin frameworks ni librerías externas. Vanilla JS puro con:

```javascript
// Datos mock que simulan la base de datos
const MACHINES = [ ... ]   // 8 activos con estado y métricas
const HISTORY  = [ ... ]   // 8 registros históricos de escaneos
const ALERTS   = [ ... ]   // 3 alertas activas
const SCAN_RESULTS = { ... } // Resultados por activo (green/yellow/red)

// Funciones principales
switchView(id)        // Navegación SPA
startScan()           // Inicia grabación + animación 5s
runAnalysis()         // Simula pasos de análisis IA
showResult(r, id)     // Renderiza semáforo + datos técnicos
generateReport()      // Modal de reporte PDF
renderMachinesTable() // Tabla con búsqueda en tiempo real
renderHistory()       // Timeline filtrable
animateWaveform()     // Oscilograma animado (canvas)
drawResultSpectrum()  // Espectro de frecuencias (canvas)
```

---

## 📊 Historias de Usuario implementadas

| ID | Historia | Vista | Estado |
|---|---|---|---|
| US005 | Captura Acústica | Escáner | ✅ Simulada con animación |
| US007 | Calendario Predictivo | Dashboard | ✅ Implementado |
| US008 | Alertas Preventivas | Alertas | ✅ Implementado |
| US009 | Semáforo de Salud | Escáner | ✅ Implementado |
| US011 | Reporte PDF | Escáner → Modal | ✅ Implementado |
| US012 | Dashboard KPIs | Dashboard | ✅ Implementado |
| US013 | Filtro de Ruido IA | Escáner (paso 2) | ✅ Simulado |
| US021 | Catálogo de Máquinas | Máquinas → Modal | ✅ Implementado |
| US022 | Historial Acústico | Historial | ✅ Implementado |

---

## 👥 Equipo

| Integrante | Código |
|---|---|
| Marquez Huancausi, Gino Paolo | U20251G069 |
| Goicochea Loza, Jonny Gabriel | U20251A107 |
| Huanca Vilca, Carlos Daniel | U20251C915 |
| Ponce Galarza, Joseph Smith | U202516816 |

**Curso:** 1ASI0786 – Ingeniería de Requisitos · NRC 15799  
**Startup:** MachinaSense · **Universidad:** UPC · **Ciclo:** 202610

---

## 🔗 Recursos del proyecto

- 🎥 Entrevistas: https://www.youtube.com/watch?v=QIszblKFmzc
- 🎨 Canva: https://www.canva.com/design/DAHJgyZ8XOM/
- 📋 Miro: https://miro.com/welcomeonboard/...
