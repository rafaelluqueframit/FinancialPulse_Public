= Planificación y diseño

En este capítulo se describe la metodología de desarrollo seguida, la
planificación temporal, el presupuesto estimado, así como el análisis de
requisitos, el diseño de la base de datos, la arquitectura del software y el
diseño de la interfaz de usuario de _FinancialPulse_.

== Metodología de desarrollo

Para la realización de este proyecto se ha seleccionado una metodología ágil,
concretamente *Scrum*, adaptada al contexto de un único desarrollador. Scrum es
ideal por su naturaleza iterativa e incremental, lo que permite adaptarse a
cambios en los requisitos y ajustar el alcance del proyecto a lo largo del
tiempo.

Dado que el equipo de desarrollo está formado por una sola persona (el
estudiante), los roles se han simplificado: el estudiante actúa como *equipo de
desarrollo* y también como *Product Owner* (definiendo y priorizando las
historias de usuario). El tutor del proyecto ejerce como #strong[Stakeholder] y
supervisor. Los eventos de Scrum se han ajustado de la siguiente manera:

- *Sprints*: de 4 semanas de duración, totalizando 5 sprints.
- *Sprint Planning*: al inicio de cada sprint, planificando las tareas a
  realizar.
- *Daily*: reuniones diarias (cortas) con uno mismo para revisar avances y
  obstáculos.
- *Sprint Review*: al final de cada sprint, mostrando el incremento funcional al
  tutor.
- *Sprint Retrospective*: reflexión al final de cada sprint para mejorar el
  proceso.

Los sprints definidos han sido:

#figure(
  table(
    columns: (1.5fr, 6fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Sprint*], [*Objetivo*],
    [Sprint 1],
    [Configuración del entorno, estructura base del proyecto, implementación de
      autenticación y gestión de usuarios (registro, login, recuperación de
      contraseña).],

    [Sprint 2],
    [Integración con Yahoo Finance, búsqueda de activos, gráficos históricos y
      primeros indicadores técnicos (SMA, RSI).],

    [Sprint 3],
    [Implementación de módulo de predicción (Prophet), análisis de sentimiento
      de noticias (FinBERT y modelo español), y sistema de favoritos.],

    [Sprint 4],
    [Desarrollo de la cartera virtual (compra/venta, historial, gráfico de
      evolución) y backtesting de estrategia SMA.],

    [Sprint 5],
    [Internacionalización (español/inglés), tooltips, páginas de ayuda,
      cumplimiento RGPD (exportación y eliminación de cuenta), pruebas y
      documentación.],
  ),
  caption: [Descripción de los sprints del proyecto.],
) <tabla:sprints>

== Planificación temporal

La planificación inicial del proyecto se ha representado mediante un diagrama de
Gantt, que muestra la secuencia y duración estimada de cada tarea a lo largo de
los sprints. El desarrollo comenzó en febrero de 2025 y finalizó en junio
de 2025.

#figure(
  image("../Figures/Template/Chapter5/gantt_inicial.png", width: 100%),
  caption: [Diagrama de Gantt inicial (planificación temporal).],
) <fig:gantt_inicial>

Las principales tareas planificadas fueron:

- Análisis de requisitos y definición del alcance.
- Diseño de la base de datos y arquitectura.
- Configuración del entorno de desarrollo (Angular, Flask, PostgreSQL, Docker).
- Implementación de módulos (autenticación, datos en tiempo real, indicadores,
  predicción, sentimiento, cartera, favoritos, noticias, internacionalización,
  RGPD).
- Pruebas unitarias, de integración y de aceptación.
- Redacción de la memoria y preparación de la defensa.

La planificación real sufrió algunos ajustes menores (retrasos en el aprendizaje
de Prophet y en la integración del modelo de sentimiento en español), pero en
general se cumplieron los hitos principales. El diagrama de Gantt final se
incluye en el apéndice.

== Presupuesto

Para estimar el coste del proyecto se han considerado los gastos de personal
(horas de trabajo del estudiante y del tutor), así como los costes de ejecución
(hardware, software, servidores, etc.). Se ha tomado como referencia un salario
bruto mensual de 1.400 € para un ingeniero junior (estudiante) y 2.000 € para un
analista senior (tutor), basado en datos de portales como Glassdoor.

A continuación se detalla el coste mensual para la empresa, los gastos de
ejecución y el resumen final del presupuesto para los 9 meses de duración del
proyecto.

=== Coste mensual para la empresa

#figure(
  table(
    columns: (2fr, 1fr, 1.5fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Concepto*], [*Porcentaje (%)*], [*Cantidad (€)*],
    [Total Mensual para la Empresa], [], [#strong[1.867,60 €]],
    [Seguridad Social a cargo de la empresa], [23,60 %], [330,40 €],
    [Prestaciones por Desempleo], [5,50 %], [77,00 €],
    [IT/IMS (Incapacidad Temporal / IMS)], [3,50 %], [49,00 €],
    [Formación Profesional], [0,60 %], [8,40 €],
    [FOGASA (Fondo de Garantía Salarial)], [0,20 %], [2,80 €],
    [Total deducciones], [], [467,60 €],
    [Salario Bruto Mensual], [], [1.400,00 €],
    [IRPF (estimación 16,88 %)], [16,88 %], [236,32 €],
    [Contingencias Comunes (a cargo del empleado)], [4,70 %], [65,80 €],
    [Desempleo (a cargo del empleado)], [1,55 %], [21,70 €],
    [Formación Profesional (a cargo del empleado)], [0,10 %], [1,40 €],
    [Total deducciones empleado], [], [325,22 €],
    [Salario Neto Mensual], [], [1.074,78 €],
  ),
  caption: [Coste mensual para la empresa y salario neto del trabajador.],
) <tabla:coste_empresa>

=== Gastos de ejecución

Los gastos de ejecución se dividen en material inventariable (amortizable),
material fungible, alquileres y contratos, y otros gastos directos.

==== Material inventariable

Se consideran los equipos informáticos utilizados durante el desarrollo,
amortizados según su vida útil estimada (4 años para el portátil, 3 años para el
monitor y periféricos). El coste imputado se calcula prorrateando la
amortización anual por los 9 meses de uso del proyecto.

#figure(
  table(
    columns: (1.8fr, 1fr, 1fr, 1.2fr, 1.2fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Descripción*],
    [*Costo (€)*],
    [*Vida útil (años)*],
    [*Amortización anual (€)*],
    [*Coste imputado (9 meses)*],

    [Ordenador portátil], [1.200 €], [4], [300 €], [225 €],
    [Monitor 24 pulgadas], [150 €], [3], [50 €], [37,50 €],
    [Periféricos (ratón, teclado)], [50 €], [3], [16,67 €], [12,50 €],
    [Teléfono fijo (amortizado)], [40 €], [5], [8 €], [6 €],
    [Total], [], [], [], [#strong[281 €]],
  ),
  caption: [Material inventariable amortizado durante el proyecto.],
) <tabla:material_inventariable>

==== Material fungible

Son materiales de oficina de corta duración que se amortizan en el propio
ejercicio.

#figure(
  table(
    columns: (1.8fr, 1fr, 1fr, 1fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Descripción*], [*Cantidad*], [*Precio (€)*], [*Coste (€)*],
    [Bolígrafos], [6], [1,00 €], [6,00 €],
    [Paquete de grapas], [1], [1,20 €], [1,20 €],
    [Paquete de folios A4 (500)], [2], [5,00 €], [10,00 €],
    [Total], [], [], [#strong[17,20 €]],
  ),
  caption: [Material fungible.],
) <tabla:material_fungible>

==== Alquileres y contratos

Se incluyen los gastos derivados del alquiler de un espacio de trabajo
(opcional, se podría usar espacio doméstico), suministros, línea de teléfono,
conexión a Internet y el dominio web para el despliegue. Estos gastos se
prorratean a los 9 meses de duración del proyecto.

#figure(
  table(
    columns: (2fr, 1fr, 1fr, 1.2fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Descripción*], [*Precio mensual (€)*], [*Meses*], [*Coste (€)*],
    [Alquiler local (opcional)], [300,00 €], [9], [2.700,00 €],
    [Agua], [30,00 €], [9], [270,00 €],
    [Electricidad], [60,00 €], [9], [540,00 €],
    [Línea telefónica fija], [19,99 €], [9], [179,91 €],
    [Internet (fibra 300 MB)], [29,99 €], [9], [269,91 €],
    [Dominio web (duckdns.org gratis, o .com opcional)],
    [12,50 €],
    [9],
    [112,50 €],

    [Total], [], [], [#strong[4.072,32 €]],
  ),
  caption: [Gastos de alquiler y contratos.],
) <tabla:alquileres_contratos>

==== Otros gastos directos

En este apartado se incluye el coste del servidor en la nube (opcional, si se
desea desplegar en producción sin usar hardware local) y posibles licencias de
software. En este proyecto no se han utilizado licencias de pago, todo es código
abierto.

#figure(
  table(
    columns: (2fr, 1fr, 1fr, 1.2fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Descripción*], [*Precio mensual (€)*], [*Meses*], [*Coste (€)*],
    [Servidor en la nube (opcional, ej. AWS t2.micro)],
    [10,00 €],
    [9],
    [90,00 €],

    [Software y licencias], [0 €], [9], [0,00 €],
    [Total], [], [], [#strong[90 €]],
  ),
  caption: [Otros gastos directos.],
) <tabla:otros_gastos>

=== Gastos indirectos

Se incluyen gastos administrativos (gestoría, contabilidad, etc.) que se
comparten con otros proyectos. Se estima un 5% sobre los costes directos
totales, aunque en un proyecto académico pueden ser simbólicos.

#figure(
  table(
    columns: (1.5fr, 1fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Concepto*], [*Coste (€)*],
    [Gastos administrativos (estimación 5 % sobre costes directos)], [270 €],
  ),
  caption: [Gastos indirectos.],
) <tabla:gastos_indirectos>

=== Gastos de personal (9 meses)

#figure(
  table(
    columns: (2.5fr, 1fr, 1fr, 1fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Descripción*], [*Unidades*], [*Precio mensual (€)*], [*Coste (€)*],
    [Sueldo bruto estudiante], [9 meses], [1.400,00 €], [12.600,00 €],
    [Sueldo bruto tutor], [9 meses], [2.000,00 €], [18.000,00 €],
    [Total personal], [], [], [#strong[30.600,00 €]],
  ),
  caption: [Gastos de personal.],
) <tabla:gastos_personal>

=== Resumen del presupuesto (9 meses)

#figure(
  table(
    columns: (2.2fr, 1.2fr, 1fr, 1.2fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Concepto*], [*Coste (€)*], [*I.V.A. (21%)*], [*Total con IVA (€)*],
    [*Material inventariable*], [], [], [],
    [Ordenador portátil], [225,00 €], [47,25 €], [272,25 €],
    [Monitor 24 pulgadas], [37,50 €], [7,88 €], [45,38 €],
    [Periféricos], [12,50 €], [2,63 €], [15,13 €],
    [Teléfono fijo], [6,00 €], [1,26 €], [7,26 €],
    [*Material fungible*], [17,20 €], [3,61 €], [20,81 €],
    [*Alquileres y contratos*], [], [], [],
    [Alquiler local], [2.700,00 €], [567,00 €], [3.267,00 €],
    [Agua], [270,00 €], [56,70 €], [326,70 €],
    [Electricidad], [540,00 €], [113,40 €], [653,40 €],
    [Línea telefónica fija], [179,91 €], [37,78 €], [217,69 €],
    [Internet], [269,91 €], [56,68 €], [326,59 €],
    [Dominio web], [112,50 €], [23,63 €], [136,13 €],
    [*Otros gastos directos*], [], [], [],
    [Servidor en la nube], [90,00 €], [18,90 €], [108,90 €],
    [*Gastos indirectos*], [270,00 €], [56,70 €], [326,70 €],
    [*Gastos de personal*], [], [], [],
    [Sueldo estudiante (9 meses)],
    [12.600,00 €],
    [0,00 € (IRPF aparte)],
    [12.600,00 €],

    [Sueldo tutor (9 meses)], [18.000,00 €], [0,00 €], [18.000,00 €],
    [*Totales*], [], [], [],
    [Total sin IVA], [35.430,02 €], [], [],
    [IVA (21%)], [], [7.440,30 €], [],
    [Total con IVA], [], [], [#strong[42.870,32 €]],
  ),
  caption: [Resumen del presupuesto total del proyecto (9 meses, incluyendo
    sueldo de tutor).],
) <tabla:presupuesto_final>

El coste total estimado del proyecto asciende a *42.870,32 €* (IVA incluido). Si
no se considera el sueldo del tutor (por tratarse de un trabajo académico) y se
eliminan los gastos opcionales de alquiler local y servidor en la nube, el coste
se reduciría a unos *15.000 € - 18.000 €*, en línea con lo esperado para un TFG
de estas características.

En cualquier caso, el proyecto es viable económicamente porque los únicos costes
inevitables son el hardware (ya amortizado) y la electricidad/Internet (gastos
domésticos). El software es completamente gratuito y de código abierto.

== Análisis de requisitos

A continuación se definen los requisitos funcionales y no funcionales del
sistema.

=== Requisitos funcionales (RF)

- *RF-01*: Gestión de usuarios: registro, inicio de sesión, cierre de sesión,
  recuperación de contraseña mediante enlace/código, edición del perfil.
- *RF-02*: Búsqueda de activos financieros (acciones, criptomonedas, índices,
  divisas) con autocompletado.
- *RF-03*: Visualización de datos históricos en gráficos de líneas y velas, con
  selección de período (1 semana, 1 mes, 3 meses, 1 año, 5 años, máximo).
- *RF-04*: Cálculo y visualización de indicadores técnicos (RSI, MACD, SMA,
  Bandas de Bollinger, estocástico).
- *RF-05*: Backtesting de la estrategia de cruce de medias móviles (SMA 20/50)
  sobre datos históricos.
- *RF-06*: Predicción de precios futuros (30 días) utilizando el modelo Prophet,
  mostrando intervalo de confianza y error MAPE.
- *RF-07*: Análisis de sentimiento de noticias financieras (positivo, neutral,
  negativo) mediante modelos FinBERT (inglés) y
  `bardsai/finance-sentiment-es-base` (español).
- *RF-08*: Gestión de cartera virtual: saldo inicial de 10.000 USD, compra/venta
  de activos, historial de transacciones, valoración en tiempo real, gráfico de
  evolución del balance y composición de la cartera (gráfico de tarta).
- *RF-09*: Marcado de activos como favoritos y sección dedicada de favoritos.
- *RF-10*: Búsqueda y filtrado de noticias financieras por palabra clave,
  ordenación por fecha o sentimiento, resumen de sentimiento con gráfico
  circular.
- *RF-11*: Internacionalización completa (español/inglés) mediante pipe de
  traducción propio y selector de idioma.
- *RF-12*: Tooltips explicativos en elementos clave (indicadores, gráficos,
  etc.) que se traducen automáticamente.
- *RF-13*: Exportación de todos los datos personales del usuario en formato JSON
  (cumplimiento RGPD).
- *RF-14*: Eliminación completa de la cuenta de usuario (borrado en cascada de
  cartera, transacciones, favoritos).
- *RF-15*: Ayuda integrada mediante páginas estáticas (Análisis, Cartera,
  Noticias).

=== Requisitos no funcionales (RNF)

- *RNF-01*: El frontend debe ser una SPA responsive que funcione en navegadores
  modernos (Chrome, Firefox, Edge).
- *RNF-02*: El tiempo de respuesta de la API para consultas de datos en tiempo
  real no debe superar los 3 segundos en condiciones normales.
- *RNF-03*: La aplicación debe ser desplegable mediante contenedores Docker
  (docker-compose up).
- *RNF-04*: Las contraseñas de los usuarios deben almacenarse cifradas (bcrypt).
- *RNF-05*: La comunicación entre frontend y backend debe realizarse mediante
  API REST con autenticación por sesión (cookies).
- *RNF-06*: El código fuente debe estar versionado en un repositorio público
  (GitHub) y licenciado bajo una licencia de código abierto (MIT).
- *RNF-07*: La interfaz debe ser intuitiva, con ayuda integrada y tooltips.

== Casos de uso

Los actores del sistema son: *Usuario no registrado* (invitado), *Usuario
registrado* (medio o inversor) y *Administrador* (aunque en esta versión el
administrador no tiene interfaz específica, puede acceder a la base de datos
directamente). A continuación se describen los casos de uso principales.

#figure(
  image("../Figures/Template/Chapter5/diagrama_caso_uso.png", width: 70%),
  caption: [Diagrama de casos de uso del sistema.],
)

=== Descripción de casos de uso principales

- *CU-01: Registrarse*: El usuario no registrado introduce email, contraseña y
  otros datos. El sistema valida y crea la cuenta.
- *CU-02: Iniciar sesión*: El usuario introduce credenciales; el sistema
  verifica y crea la sesión.
- *CU-03: Recuperar contraseña*: El usuario solicita recuperación; el sistema
  envía un código numérico por correo y permite cambiarla.
- *CU-04: Buscar activo*: El usuario escribe parcialmente el nombre o símbolo;
  el sistema muestra opciones de autocompletado.
- *CU-05: Ver dashboard del activo*: El usuario selecciona un activo y visualiza
  gráfico histórico, indicadores técnicos, predicción y análisis de sentimiento
  (si está autenticado).
- *CU-06: Comprar activo (cartera virtual)*: El usuario autenticado introduce
  cantidad y confirma; el sistema verifica saldo, actualiza cartera y registra
  transacción.
- *CU-07: Vender activo*: Similar a compra, pero verificando que tenga
  suficientes acciones.
- *CU-08: Marcar/desmarcar favorito*: El usuario autenticado puede añadir o
  quitar un activo de su lista de favoritos.
- *CU-09: Ver noticias financieras*: El usuario introduce una palabra clave o
  selecciona una categoría; el sistema obtiene noticias de NewsAPI y aplica
  análisis de sentimiento.
- *CU-10: Exportar datos personales*: El usuario autenticado solicita
  exportación; el sistema genera un JSON con sus datos y lo descarga.
- *CU-11: Eliminar cuenta*: El usuario autenticado confirma la eliminación; el
  sistema borra todos sus datos (cartera, transacciones, favoritos, perfil).

== Diseño de la base de datos

La base de datos de _FinancialPulse_ almacena la información de usuarios,
carteras, transacciones, favoritos y tokens de recuperación de contraseña. Se ha
utilizado PostgreSQL 15 como sistema gestor y SQLAlchemy como ORM para la
interacción desde el backend.

#figure(
  image("../Figures/Template/Chapter5/diagrama_ER.png", width: 100%),
  caption: [Diagrama entidad-relación (ER) de la base de datos.],
) <fig:er_diagram>

=== Paso a tablas y fusión

A partir del diagrama entidad-relación, se realiza la transformación a un modelo
físico de tablas. A continuación se detalla el proceso:

- La entidad `Usuario` se convierte directamente en la tabla `usuario` con sus
  atributos `id`, `nombre`, `email`, `password_hash` y `fecha_registro`.
- La entidad `Cartera` tiene una relación 1:1 con `Usuario`, por lo que se
  incorpora la clave foránea `usuario_id` en la tabla `cartera`. No es necesaria
  una tabla intermedia.
- La relación 1:N entre `Cartera` y `Transaccion` se resuelve añadiendo
  `cartera_id` como clave foránea en la tabla `transaccion`. Además, se incluye
  `accion_simbolo` directamente (no se crea una tabla separada de acciones,
  porque los datos se obtienen de Yahoo Finance bajo demanda).
- La relación 1:N entre `Usuario` y `Favorito` se resuelve con `usuario_id` como
  clave foránea en `favorito`, junto con el `simbolo` del activo.
- La relación 1:N entre `Usuario` y `ResetToken` se resuelve con `usuario_id`
  como clave foránea en `reset_token`.

No se han fusionado tablas adicionales, ya que cada una representa un concepto
independiente y se evita la redundancia.

=== Normalización de la base de datos

La normalización es un proceso que elimina redundancias y garantiza la
integridad de los datos. El diseño de _FinancialPulse_ cumple con las tres
primeras formas normales (1FN, 2FN, 3FN).

- *Primera forma normal (1FN)*: Todos los atributos contienen valores atómicos.
  Por ejemplo, en `transaccion`, `cantidad` es un número entero y `precio` un
  decimal; no hay listas ni grupos repetitivos. Cada registro es único gracias a
  la clave primaria.
- *Segunda forma normal (2FN)*: La tabla está en 1FN y todos los atributos no
  clave dependen por completo de la clave primaria. En `transaccion`, la clave
  primaria es `id_transaccion` y los demás campos (`cartera_id`, `simbolo`,
  `tipo`, `cantidad`, `precio`, `fecha`) dependen únicamente de ella, no de
  parte de ella.
- *Tercera forma normal (3FN)*: No existen dependencias transitivas. Por
  ejemplo, en `usuario`, `nombre` y `email` dependen directamente de `id`, no de
  otro atributo no clave. En `cartera`, el `saldo` depende de `id_cartera`, no
  de `usuario_id` (aunque exista la relación, esta no crea una dependencia
  transitiva porque `usuario_id` es clave foránea, no candidata).

De esta forma, el modelo evita anomalías de inserción, actualización y borrado,
y garantiza la integridad referencial.

=== Tablas de la base de datos

A continuación se muestran las tablas que componen el esquema, con sus campos,
tipos de datos y restricciones. La nomenclatura sigue los estándares de SQL y
las convenciones de SQLAlchemy.

#figure(
  table(
    columns: (1.8fr, 1.2fr, 3fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Campo*], [*Tipo*], [*Descripción*],
    [id], [INTEGER], [Identificador único del usuario (autoincremental).],
    [nombre], [VARCHAR(100)], [Nombre completo del usuario.],
    [email],
    [VARCHAR(100)],
    [Correo electrónico (único) para inicio de sesión.],

    [password_hash], [VARCHAR(200)], [Hash de la contraseña con bcrypt.],
    [fecha_registro],
    [TIMESTAMP],
    [Fecha y hora de creación de la cuenta (por defecto ahora).],
  ),
  caption: [Tabla 5.1: Estructura de la tabla `usuario`.],
) <tabla:usuario>

#figure(
  table(
    columns: (1.8fr, 1.2fr, 3fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Campo*], [*Tipo*], [*Descripción*],
    [id_cartera],
    [INTEGER],
    [Identificador único de la cartera (autoincremental).],

    [usuario_id],
    [INTEGER],
    [Referencia al usuario propietario (relación 1:1).],

    [saldo],
    [DECIMAL(12,2)],
    [Saldo disponible en USD (valor inicial 10.000,00).],

    [total_depositado],
    [DECIMAL(12,2)],
    [Suma de todas las compras (efectivo invertido).],

    [total_retirado],
    [DECIMAL(12,2)],
    [Suma de todas las ventas (efectivo retirado).],

    [total_transacciones], [INTEGER], [Número total de operaciones realizadas.],
  ),
  caption: [Tabla 5.2: Estructura de la tabla `cartera`.],
) <tabla:cartera>

#figure(
  table(
    columns: (1.8fr, 1.2fr, 3fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Campo*], [*Tipo*], [*Descripción*],
    [id_transaccion],
    [INTEGER],
    [Identificador único de la transacción (autoincremental).],

    [cartera_id], [INTEGER], [Cartera asociada a la transacción.],
    [accion_simbolo], [VARCHAR(20)], [Símbolo del activo (ej. AAPL, BTC-USD).],
    [tipo], [VARCHAR(10)], [Tipo de operación: `compra` o `venta`.],
    [cantidad], [INTEGER], [Número de unidades (mayor que 0).],
    [precio],
    [DECIMAL(12,4)],
    [Precio unitario en el momento de la transacción (USD).],

    [fecha], [TIMESTAMP], [Fecha y hora de la transacción (por defecto ahora).],
  ),
  caption: [Tabla 5.3: Estructura de la tabla `transaccion`.],
) <tabla:transaccion>

#figure(
  table(
    columns: (1fr, 2fr, 3fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Campo*], [*Tipo*], [*Descripción*],
    [id_favorito],
    [INTEGER],
    [Identificador único del favorito (autoincremental).],

    [usuario_id], [INTEGER], [Usuario que ha marcado el favorito.],
    [simbolo], [VARCHAR(20)], [Símbolo del activo favorito.],
    [creado_en], [TIMESTAMP], [Fecha en que se marcó (por defecto ahora).],
  ),
  caption: [Tabla 5.4: Estructura de la tabla `favorito`. La combinación
    `(usuario_id, simbolo)` es única para evitar duplicados.],
) <tabla:favorito>

#figure(
  table(
    columns: (1fr, 2fr, 3fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Campo*], [*Tipo*], [*Descripción*],
    [id_token], [INTEGER], [Identificador único del token (autoincremental).],
    [usuario_id],
    [INTEGER],
    [Usuario que solicita la recuperación de contraseña.],

    [token], [VARCHAR(6)], [Código numérico de 6 dígitos.],
    [created_at],
    [TIMESTAMP],
    [Momento de creación del token (por defecto ahora).],
  ),
  caption: [Tabla 5.5: Estructura de la tabla `reset_token`.],
) <tabla:reset_token>

=== Relaciones de la base de datos

Las relaciones entre tablas se definen mediante claves foráneas, con borrado en
cascada configurado en los modelos de SQLAlchemy para mantener la integridad
referencial:

- `usuario` (1) ←→ (1) `cartera`: un usuario tiene una única cartera y una
  cartera pertenece a un solo usuario.
- `usuario` (1) ←→ (N) `favorito`: un usuario puede tener muchos favoritos, cada
  favorito pertenece a un usuario.
- `usuario` (1) ←→ (N) `reset_token`: un usuario puede tener múltiples tokens de
  recuperación (aunque solo uno activo a la vez).
- `cartera` (1) ←→ (N) `transaccion`: una cartera puede tener múltiples
  transacciones, cada transacción pertenece a una cartera.

Además, se han definido índices en los campos de búsqueda más frecuentes:
`email` en `usuario`, `simbolo` en `transaccion` y `favorito`, y `usuario_id` en
`cartera`, para mejorar el rendimiento de las consultas.

== Arquitectura del software

_FinancialPulse_ sigue una arquitectura cliente-servidor de tres capas, lo que
permite una separación clara de responsabilidades y facilita el mantenimiento y
la escalabilidad.

#figure(
  image("../Figures/Template/Chapter5/diagrama_arquitectura.png", width: 100%),
  caption: [Diagrama de arquitectura cliente-servidor mostrando los componentes
    Angular (frontend), Flask (backend), PostgreSQL y las APIs externas (Yahoo
    Finance, NewsAPI), así como el flujo de peticiones.],
) <fig:arquitectura>

=== Capas del sistema

- *Capa de presentación (cliente)*: Aplicación SPA desarrollada con Angular 21.
  Se ejecuta en el navegador del usuario y se comunica con el backend mediante
  peticiones HTTP asíncronas (servicios Angular). Utiliza Tailwind CSS para los
  estilos y ngx-echarts para la visualización de gráficos.
- *Capa de lógica de negocio (servidor)*: API REST construida con Flask
  (Python). Contiene la lógica de autenticación (sesiones), obtención de datos
  financieros de Yahoo Finance, cálculo de indicadores técnicos, predicción con
  Prophet, análisis de sentimiento con modelos de transformers (FinBERT y modelo
  español), y gestión de la cartera virtual y favoritos.
- *Capa de datos*: PostgreSQL 15. Almacena usuarios, carteras, transacciones,
  favoritos y tokens de recuperación. El acceso se realiza a través de
  SQLAlchemy (ORM).

=== Patrón Modelo-Vista-Controlador (MVC)

De forma implícita, se aplica el patrón MVC en el sistema:

- *Modelo*: En el backend, las clases de SQLAlchemy (`Usuario`, `Cartera`,
  `Transaccion`, `Favorito`, `ResetToken`) representan las entidades de la base
  de datos. En el frontend, se definen interfaces TypeScript (modelos) que
  reflejan la estructura de los datos intercambiados con la API.
- *Vista*: Los componentes de Angular (HTML + CSS) constituyen las vistas. Se
  utiliza Tailwind CSS para los estilos y ngx-echarts para los gráficos.
- *Controlador*: En el frontend, los servicios Angular (`AuthService`,
  `AssetService`, `PortfolioService`, `NewsService`, etc.) actúan como
  controladores que invocan a la API. En el backend, las rutas de Flask
  (decoradores `@app.route`) reciben las peticiones, orquestan la lógica y
  devuelven respuestas JSON.

== Diseño de la interfaz de usuario

El diseño de la interfaz se ha centrado en la *usabilidad*, la *accesibilidad* y
la *experiencia de usuario*, con especial atención a los inversores noveles. Se
ha utilizado Tailwind CSS para los estilos (diseño responsive) y ngx-echarts
para los gráficos interactivos. A continuación se describen las pantallas
principales, cada una acompañada de su correspondiente mockup.

=== Pantalla de inicio de sesión (`/login`)

El usuario introduce su email y contraseña. Dispone de una casilla *Recordarme*
para mantener la sesión activa, un enlace para recuperar la contraseña olvidada
y un enlace a la pantalla de registro. Los campos tienen validación en tiempo
real.

#figure(
  image("../Figures/Template/Chapter5/mockup_login.png", width: 80%),
  caption: [Mockup de la pantalla de inicio de sesión.],
) <fig:mockup_login>

=== Pantalla de registro (`/register`)

Formulario con campos para nombre, email, contraseña y confirmación de
contraseña. Se valida que el email no esté ya registrado (comprobación
asíncrona) y que la contraseña cumpla una longitud mínima. Tras el registro
exitoso, se crea automáticamente una cartera virtual con saldo 10.000 USD y se
redirige al login.

#figure(
  image("../Figures/Template/Chapter5/mockup_register.png", width: 80%),
  caption: [Mockup de la pantalla de registro.],
) <fig:mockup_registro>

=== Pantalla de recuperación de contraseña (`/forgot-password`)

Permite al usuario solicitar un código de verificación de 6 dígitos asociado a
su email. Dicho código se muestra por consola (simulando el envío por correo) y
debe ser introducido junto con la nueva contraseña para completar el cambio.

#figure(
  image("../Figures/Template/Chapter5/mockup_forgot.png", width: 70%),
  caption: [Mockup de la pantalla de recuperación de contraseña.],
) <fig:mockup_forgot>

=== Página de inicio (Home) (`/`)

Es el punto de entrada tras el login. Incluye:
- Barra de navegación superior con enlaces a las secciones principales y
  selector de idioma (español/inglés).
- Resumen de índices bursátiles (S&P 500, IBEX 35, Dow Jones, Nasdaq) obtenidos
  de Yahoo Finance, con precio actual y cambio porcentual.
- Últimas noticias financieras destacadas.
- Balance resumido de la cartera virtual (saldo, beneficio no realizado) y
  enlace a la página de cartera.
- Lista de las últimas transacciones realizadas.

#figure(
  image("../Figures/Template/Chapter5/mockup_home.png", width: 100%),
  caption: [Mockup de la página de inicio (home).],
) <fig:mockup_home>

=== Dashboard de un activo (`/asset/:symbol`)

Es la pantalla más compleja. Muestra:
- Cabecera con nombre del activo, símbolo, precio actual, cambio diario y
  moneda.
- Gráfico interactivo (ngx-echarts) que puede mostrar velas japonesas o líneas.
  Selector de períodos (1d, 5d, 1m, 3m, 6m, 1y, 5y, max).
- Pestañas:
  - *Indicadores técnicos*: Visualización de SMA20, SMA50, RSI, MACD, Bandas de
    Bollinger y estocástico.
  - *Predicción (Prophet)*: Gráfico de forecast a 30 días con intervalos de
    confianza y métrica MAPE.
  - *Sentimiento*: Noticias relacionadas con el activo, cada una con su etiqueta
    de sentimiento y gráfico circular resumen.
  - *Fundamentos*: Datos de la empresa (marketCap, PER, beneficio por acción,
    dividendos, etc.).
- Botones *Comprar* y *Vender* que abren un modal para simular operaciones en la
  cartera virtual.
- Icono de estrella para marcar/desmarcar el activo como favorito.

#figure(
  image("../Figures/Template/Chapter5/mockup_dashboard.png", width: 100%),
  caption: [Mockup del dashboard de un activo (ejemplo: Apple Inc.).],
) <fig:mockup_dashboard>

=== Página de cartera virtual (`/portfolio`)

Muestra el estado de la simulación financiera del usuario:
- Tarjeta de resumen: saldo actual, total depositado, total retirado, beneficio
  no realizado.
- Gráfico de evolución del balance en el tiempo (línea), con selectores de
  período.
- Gráfico de tarta con la composición de la cartera.
- Tabla de transacciones recientes con paginación.

#figure(
  image("../Figures/Template/Chapter5/mockup_portfolio.png", width: 90%),
  caption: [Mockup de la página de cartera virtual.],
) <fig:mockup_cartera>

=== Página de favoritos (`/favorites`)

Lista de todos los activos que el usuario ha marcado como favoritos. Cada
elemento muestra el símbolo, el nombre, el precio actual, el cambio diario y un
botón para ir al dashboard. Permite eliminar favoritos directamente desde la
lista.

#figure(
  image("../Figures/Template/Chapter5/mockup_favorites.png", width: 80%),
  caption: [Mockup de la página de favoritos.],
) <fig:mockup_favoritos>

=== Página de noticias (`/news`)

Incluye una barra de búsqueda por palabra clave o símbolo, junto con sugerencias
rápidas. Los resultados se muestran como tarjetas con título, fecha, fuente,
breve descripción y un indicador de sentimiento. Un gráfico circular resume la
proporción de noticias positivas, neutrales y negativas.

#figure(
  image("../Figures/Template/Chapter5/mockup_news.png", width: 100%),
  caption: [Mockup de la página de noticias con análisis de sentimiento.],
) <fig:mockup_noticias>

=== Página de perfil de usuario (`/profile`)

Muestra los datos personales del usuario (nombre y email). Permite:
- Cambiar la contraseña (requiere la contraseña actual).
- Exportar todos los datos personales en formato JSON (derecho de portabilidad
  del RGPD).
- Eliminar la cuenta de forma permanente (botón con doble confirmación).

#figure(
  image("../Figures/Template/Chapter5/mockup_profile.png", width: 70%),
  caption: [Mockup de la página de perfil de usuario.],
) <fig:mockup_perfil>

=== Páginas de ayuda (`/help`)

Tres subpáginas (Análisis técnico, Cartera virtual, Noticias) que explican con
texto e imágenes cómo utilizar cada módulo, el significado de los indicadores
técnicos, cómo interpretar las predicciones y el análisis de sentimiento.

#figure(
  image("../Figures/Template/Chapter5/mockup_help1.png", width: 90%),
  caption: [Mockup de una página de ayuda (Ayuda de análisis).],
) <fig:mockup_ayuda>

#figure(
  image("../Figures/Template/Chapter5/mockup_help2.png", width: 90%),
  caption: [Mockup de una página de ayuda (ejemplo: Ayuda de cartera).],
) <fig:mockup_ayuda>

#figure(
  image("../Figures/Template/Chapter5/mockup_help3.png", width: 90%),
  caption: [Mockup de una página de ayuda (ejemplo: Ayuda de noticias).],
) <fig:mockup_ayuda>

=== Componentes reutilizables

Para mantener la coherencia y facilitar el desarrollo, se han creado varios
componentes Angular y directivas personalizadas:
- `AssetSearchComponent`: buscador con autocompletado que obtiene sugerencias
  del backend (`/api/search/{query}`).
- `PriceChartComponent`: componente de gráfico genérico (línea/velas).
- `TransactionModalComponent`: modal para compra/venta con validación de saldo.
- `LanguageSwitcherComponent`: selector de idioma (español/inglés) que cambia
  dinámicamente los textos mediante un `TranslatePipe`.
- `TooltipDirective`: directiva que añade tooltips informativos al hacer hover,
  con traducción automática.

La estructura de carpetas del frontend Angular se organiza de la siguiente
manera: `pages/` contiene cada vista principal (login, register, home,
dashboard, portfolio, favorites, news, profile), `components/` agrupa los
elementos reutilizables, `services/` contiene los controladores que comunican
con la API, `pipes/` alberga el `TranslatePipe`, `directives/` la
`TooltipDirective`, `guards/` los guardianes de rutas y `models/` las interfaces
TypeScript.

Todas las pantallas son responsive, adaptándose a dispositivos móviles, tabletas
y ordenadores de escritorio gracias a Tailwind CSS.

Una vez definida la planificación y el diseño, en el siguiente capítulo se
detallan las herramientas utilizadas y las fuentes de datos.
