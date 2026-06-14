= Planificación y diseño

#import "../landscape_helpers.typ": landscape_page

En este capítulo se muestra la planificación temporal, el presupuesto estimado y
la metodología de desarrollo (Scrum adaptado a un desarrollador único). Además,
se describen los perfiles de usuario (personas) y escenarios de uso que me
ayudaron a definir las funcionalidades prioritarias y a diseñar una interfaz más
intuitiva y agradable para el usuario final. Finalmente, se presentan varios
diagramas de secuencia para visualizar cómo se comunican los distintos
componentes del sistema.

== Metodología de desarrollo

Para el desarrollo se eligió Scrum, una metodología ágil que ya se había visto,
en la asignatura Dirección Estratégica de la Empresa I, y que resultó adecuada
porque encajaba bien con un proyecto de este tipo: iterativo, con requisitos que
iban afinándose a medida que avanzaba el desarrollo y con necesidad de recibir
retroalimentación frecuente. Scrum es un marco de trabajo ágil basado en
entregas cortas e incrementales, revisión continua y adaptación del plan según
los resultados obtenidos. En lugar de intentar cerrar todo el alcance desde el
principio, permite priorizar lo más importante primero y ajustar el resto con
mayor flexibilidad.

Aunque Scrum está pensado para equipos, se adaptó a la situación de
desarrollador único. Los roles se simplificaron bastante: yo hacía de equipo de
desarrollo y también de Product Owner, decidiendo qué funcionalidades eran más
urgentes en cada momento. Mi tutor actuó como stakeholder y supervisor,
ofreciendo revisión y validación al final de cada iteración.

Su elección se justifica sobre todo por tres motivos: permitía dividir el TFG en
objetivos asumibles, facilitaba corregir desviaciones sin esperar al final del
proyecto y hacía más sencillo integrar el feedback del tutor conforme se iban
completando funcionalidades.

Los eventos de Scrum se ajustaron de la siguiente manera:

- *Sprints*: de 4 semanas, totalizando 5 sprints.
- *Sprint Planning*: al comienzo de cada sprint, planificaba las tareas con
  cierto detalle.
- *Daily*: una breve reunión conmigo mismo cada día para revisar avances y
  obstáculos (suena raro, pero la verdad es que me ayudaba a mantener el foco).
- *Sprint Review*: al final de cada sprint, mostraba al tutor lo que había
  conseguido.
- *Sprint Retrospective*: una reflexión sobre lo que podía mejorar en el
  siguiente sprint.

En la siguiente Tabla 4.1 se muestran cuales fueron los sprints con sus
objetivos:

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

Para el seguimiento diario de tareas se usó Trello con tableros Kanban. Esta
herramienta permitía ver de un vistazo qué tareas estaban pendientes, en curso o
terminadas, sin necesidad de herramientas más complejas.

== Planificación temporal

La siguiente Figura 4.1 muestra el diagrama de Gantt que refleja la secuencia y
duración prevista de cada tarea, permitiendo que algunas se superpongan en el
tiempo (por ejemplo, la redacción de la memoria se realizó de forma paralela al
resto del desarrollo). La estimación inicial del proyecto, realizada en febrero
de 2026, contemplaba un desarrollo de aproximadamente 4 meses, con finalización
prevista para junio de 2026.

#landscape_page[
  #figure(
    image("../Figures/Template/Chapter5/gantt_inicial.png", width: 100%),
    caption: [Diagrama de Gantt inicial (planificación temporal).],
  ) <fig:gantt_inicial>
]

Las tareas principales que se planificaron fueron:

- Análisis de requisitos y definición del alcance.
- Estudio del estado del arte y análisis de soluciones existentes.
- Aprendizaje de Prophet, modelos de sentimiento y librerías asociadas.
- Diseño de la base de datos y la arquitectura.
- Configuración del entorno (Angular, Flask, PostgreSQL, Docker).
- Implementación de los módulos (autenticación, datos en tiempo real,
  indicadores, predicción, sentimiento, cartera, favoritos, noticias, i18n,
  RGPD).
- Pruebas unitarias, de integración y de aceptación.
- Redacción de la memoria y preparación de la defensa.

En la práctica hubo algún retraso menor (aprender Prophet y ajustar el modelo de
sentimiento en español me llevó más tiempo del que había calculado), pero en
líneas generales cumplí los hitos. El diagrama de Gantt final está en el
apéndice, por si alguien quiere comparar.

== Presupuesto

Aunque es un proyecto académico, se realizó una estimación de costes como si
fuera real. Se consideraron los gastos de personal (mi sueldo y el del tutor) y
los gastos de ejecución (hardware, software, servidores, etc.). Para el sueldo
se realizó una estimación en base a datos de Glassdoor: unos 1.400 € brutos al
mes para un ingeniero junior, y 2.000 € para un analista senior.

=== Coste mensual para la empresa

En la siguiente Tabla 4.2 se muestra el desglose del coste mensual para la
empresa, incluyendo las cotizaciones a la Seguridad Social y otras deducciones.
El salario bruto mensual del trabajador es de 1.400 €, lo que se traduce en un
coste total para la empresa de 1.867,60 € al mes, teniendo en cuenta las
contribuciones patronales y las deducciones correspondientes. El salario neto
mensual que recibe el trabajador, después de aplicar el IRPF y las cotizaciones
a cargo del empleado, es de 1.074,78 €. Estos cálculos son aproximados y pueden
variar según la legislación vigente y otros factores específicos del contrato
laboral.

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

Los siguientes gastos se consideran en material inventariable (amortizable),
material fungible, alquileres y contratos, y otros gastos directos.

==== Material inventariable

En la siguiente Tabla 4.3 se consideran los equipos informáticos utilizados
durante el desarrollo, amortizados según su vida útil (4 años para el portátil,
3 años para el monitor y periféricos). El coste imputado se calcula prorrateando
la amortización anual por los 4 meses de uso del proyecto.

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
    [*Coste imputado (4 meses)*],

    [Ordenador portátil], [1.200 €], [4], [300 €], [100 €],
    [Monitor 24 pulgadas], [150 €], [3], [50 €], [16,67 €],
    [Periféricos (ratón, teclado)], [50 €], [3], [16,67 €], [5,56 €],
    [Teléfono fijo (amortizado)], [40 €], [5], [8 €], [2,67 €],
    [Total], [], [], [], [#strong[124,90 €]],
  ),
  caption: [Material inventariable amortizado durante el proyecto.],
) <tabla:material_inventariable>

==== Material fungible

En la siguiente Tabla 4.4 se consideran las cosas de oficina que se gastan
rápido: bolígrafos, grapas, folios. Aunque el coste es bajo, se incluye para
tener una visión completa del presupuesto.

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

En la siguiente Tabla 4.5 se incluyen los gastos derivados del alquiler de un
espacio de trabajo (opcional), suministros, línea de teléfono, conexión a
Internet y el dominio web. Estos gastos se prorratean a los 4 meses de duración
del proyecto. El alquiler de un local es opcional porque el desarrollo se puede
hacer perfectamente desde casa, pero se incluye para tener una referencia de lo
que costaría si se quisiera un espacio dedicado. En este caso, el coste total de
alquileres y contratos asciende a 1.809,92 € para los 4 meses, siendo el
alquiler del local el gasto más significativo.

#figure(
  table(
    columns: (2fr, 1fr, 1fr, 1.2fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Descripción*], [*Precio mensual (€)*], [*Meses*], [*Coste (€)*],
    [Alquiler local (opcional)], [300,00 €], [4], [1.200,00 €],
    [Agua], [30,00 €], [4], [120,00 €],
    [Electricidad], [60,00 €], [4], [240,00 €],
    [Línea telefónica fija], [19,99 €], [4], [79,96 €],
    [Internet (fibra 300 MB)], [29,99 €], [4], [119,96 €],
    [Dominio web (duckdns.org gratis, o .com opcional)],
    [12,50 €],
    [4],
    [50,00 €],

    [Total], [], [], [#strong[1.809,92 €]],
  ),
  caption: [Gastos de alquiler y contratos.],
) <tabla:alquileres_contratos>

==== Otros gastos directos

En la siguiente Tabla 4.6 se incluye el coste del servidor en la nube (opcional)
y posibles licencias de software. En este proyecto no se han utilizado licencias
de pago, todo es código abierto.

#figure(
  table(
    columns: (2fr, 1fr, 1fr, 1.2fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Descripción*], [*Precio mensual (€)*], [*Meses*], [*Coste (€)*],
    [Servidor en la nube (opcional, ej. AWS t2.micro)],
    [10,00 €],
    [4],
    [40,00 €],

    [Software y licencias], [0 €], [4], [0,00 €],
    [Total], [], [], [#strong[40 €]],
  ),
  caption: [Otros gastos directos.],
) <tabla:otros_gastos>

=== Gastos indirectos

En la siguiente Tabla 4.7 se incluyen gastos administrativos (gestoría,
contabilidad, etc.) que se comparten con otros proyectos. Se estima un 5% sobre
los costes directos totales.

#figure(
  table(
    columns: (1.5fr, 1fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Concepto*], [*Coste (€)*],
    [Gastos administrativos (estimación 5 % sobre costes directos)], [100 €],
  ),
  caption: [Gastos indirectos.],
) <tabla:gastos_indirectos>

=== Gastos de personal (4 meses)

En la siguiente Tabla 4.8 se muestra el coste total de personal para los 4 meses
de duración del proyecto, incluyendo el sueldo bruto del estudiante y del tutor.
El coste total de personal asciende a 13.600 € para los 4 meses, siendo el
sueldo del tutor el gasto más significativo. Es importante destacar que el
sueldo del tutor se incluye aquí como un coste académico, pero en un contexto
empresarial real podría no ser un gasto directo.

#figure(
  table(
    columns: (2.5fr, 1fr, 1fr, 1fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Descripción*], [*Unidades*], [*Precio mensual (€)*], [*Coste (€)*],
    [Sueldo bruto estudiante], [4 meses], [1.400,00 €], [5.600,00 €],
    [Sueldo bruto tutor], [4 meses], [2.000,00 €], [8.000,00 €],
    [Total personal], [], [], [#strong[13.600,00 €]],
  ),
  caption: [Gastos de personal.],
) <tabla:gastos_personal>

=== Resumen del presupuesto (4 meses)

Sumando todos los conceptos para los 4 meses de duración estimada del proyecto,
el coste total asciende a 21.435,16 € (IVA incluido). Si se excluye el sueldo
del tutor (por tratarse de un trabajo académico) y los gastos opcionales
(alquiler local, servidor en la nube), la cifra se reduce a unos 8.000‑9.000 €,
más acorde con un TFG. El software es gratuito y de código abierto, y los únicos
costes inevitables son el hardware (ya amortizado) y los gastos de electricidad
e Internet (domésticos). Por lo que en la siguiente Tabla 4.9 se muestra un
resumen del presupuesto total del proyecto, incluyendo el sueldo del tutor y los
gastos opcionales, para tener una visión completa de lo que costaría si se
quisiera llevar a cabo en un entorno real.

#figure(
  table(
    columns: (2.2fr, 1.2fr, 1fr, 1.2fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Concepto*], [*Coste (€)*], [*I.V.A. (21%)*], [*Total con IVA (€)*],
    [*Material inventariable*], [], [], [],
    [Ordenador portátil], [100,00 €], [21,00 €], [121,00 €],
    [Monitor 24 pulgadas], [16,67 €], [3,50 €], [20,17 €],
    [Periféricos], [5,56 €], [1,17 €], [6,73 €],
    [Teléfono fijo], [2,67 €], [0,56 €], [3,23 €],
    [*Material fungible*], [17,20 €], [3,61 €], [20,81 €],
    [*Alquileres y contratos*], [], [], [],
    [Alquiler local], [1.200,00 €], [252,00 €], [1.452,00 €],
    [Agua], [120,00 €], [25,20 €], [145,20 €],
    [Electricidad], [240,00 €], [50,40 €], [290,40 €],
    [Línea telefónica fija], [79,96 €], [16,79 €], [96,75 €],
    [Internet], [119,96 €], [25,19 €], [145,15 €],
    [Dominio web], [50,00 €], [10,50 €], [60,50 €],
    [*Otros gastos directos*], [], [], [],
    [Servidor en la nube], [40,00 €], [8,40 €], [48,40 €],
    [*Gastos indirectos*], [120,00 €], [25,20 €], [145,20 €],
    [*Gastos de personal*], [], [], [],
    [Sueldo estudiante (4 meses)],
    [5.600,00 €],
    [0,00 € (IRPF aparte)],
    [5.600,00 €],

    [Sueldo tutor (4 meses)], [8.000,00 €], [0,00 €], [8.000,00 €],
    [*Totales*], [], [], [],
    [Total sin IVA], [15.712,02 €], [], [],
    [IVA (21%)], [], [3.299,52 €], [],
    [Total con IVA], [], [], [#strong[19.011,54 €]],
  ),
  caption: [Resumen del presupuesto total del proyecto (4 meses, incluyendo
    sueldo de tutor).],
) <tabla:presupuesto_final>

== Stakeholders y usuarios

Como ya he comentado en capítulos anteriores, se dedicó un tiempo a analizar el
estado del arte y a definir el problema, pero no se hizo un estudio de usuarios
formal. Sin embargo, sí que se pensó en los posibles perfiles de usuario que
podrían beneficiarse de la aplicación, y se definieron varias "personas" para
guiar el diseño y desarrollo. Estas personas representan a diferentes tipos de
usuarios potenciales, con distintos niveles de experiencia financiera y
necesidades específicas. Además, se imaginaron escenarios de uso concretos para
cada persona, lo que ayudó a priorizar funcionalidades y a diseñar una interfaz
más intuitiva y adaptada a sus necesidades. En este sentido, aunque no se hizo
un estudio de usuarios tradicional, sí que se tuvo en cuenta la perspectiva del
usuario final a lo largo de todo el proceso de desarrollo.

=== Personas

La técnica de personas consiste en crear perfiles ficticios, pero con suficiente
realismo como para representar a diferentes tipos de usuarios potenciales.
Aunque no deja de ser una herramienta de diseño, la verdad es que ayuda bastante
a tomar decisiones pensando en necesidades concretas y no solo desde un punto de
vista técnico. Para FinancialPulse se definieron tres perfiles que cubren rangos
de edad, niveles de experiencia financiera y contextos de uso bastante
distintos.

==== Persona 1: Alberto Gutiérrez (Inversor tecnológico)

#figure(
  image("../Figures/Template/Chapter3/persona_alberto.png", width: 70%),
  caption: [Alberto Gutiérrez, inversor tecnológico.],
) <fig:alberto>

#figure(
  table(
    columns: (1fr, 3fr),
    align: (left, left),
    inset: 4pt,
    [*Edad*:], [35 años],
    [*Profesión*:], [Desarrollador de software freelance],
    [*Nivel financiero*:], [Intermedio (invierte desde hace 3 años)],
    [*Objetivo*:],
    [Maximizar rendimientos mediante análisis técnico y automatización],

    [*Contexto*:],
    [Utiliza la aplicación a diario desde su portátil y móvil. Le gusta
      experimentar con estrategias y backtesting.],
  ),
  caption: [Datos de Alberto Gutiérrez.],
) <tabla:alberto>

En la Figura 4.2 se muestra a Alberto Gutiérrez, quien representa a un usuario
con cierta experiencia, tanto técnica como financiera. Además, en la Tabla 4.10
se presentan sus datos personales y de inversión. Trabaja como desarrollador
freelance, así que está acostumbrado a manejar herramientas digitales. Invierte
desde hace unos años y busca formas de maximizar sus rendimientos usando
análisis técnico. Una de las cosas que más valora es poder probar estrategias de
inversión sin arriesgar capital real, por eso el backtesting y la cartera
virtual le resultan especialmente atractivos. En una versión futura le gustaría
recibir alertas automáticas, pero mientras tanto usa la plataforma de forma
manual. Su idea es integrar FinancialPulse en su rutina diaria de análisis.

==== Persona 2: Carmen Ruiz (Profesora de economía jubilada)

#figure(
  image("../Figures/Template/Chapter3/persona_carmen.png", width: 70%),
  caption: [Carmen Ruiz, profesora de economía jubilada.],
) <fig:carmen>

#figure(
  table(
    columns: (1fr, 3fr),
    align: (left, left),
    inset: 4pt,
    [*Edad*:], [62 años],
    [*Profesión*:], [Exprofesora de economía (jubilada)],
    [*Nivel financiero*:],
    [Básico (nunca ha invertido en bolsa, pero conoce la teoría)],

    [*Objetivo*:], [Aprender a invertir de forma segura y didáctica],
    [*Contexto*:],
    [Usa la aplicación por las tardes desde su tableta. Le interesan los
      tutoriales y el análisis de sentimiento de noticias.],
  ),
  caption: [Datos de Carmen Ruiz.],
) <tabla:carmen>

En la Figura 4.3 se muestra a Carmen Ruiz, quien representa a un usuario con
cierta experiencia, tanto técnica como financiera. Además, en la Tabla 4.11 se
presentan sus datos personales y de inversión. Tiene buenos conocimientos
teóricos (fue profesora de economía), pero nunca se ha atrevido a invertir en
bolsa. Ahora, jubilada, quiere aprender de forma práctica sin miedo a perder
dinero. Las plataformas demasiado técnicas o con gráficos muy densos la abruman.
Por eso valora mucho los tooltips explicativos, las páginas de ayuda y poder
cambiar el idioma a español. El análisis de sentimiento de noticias también le
parece una funcionalidad interesante para hacerse una idea del estado de ánimo
del mercado sin tener que interpretar datos complejos.

==== Persona 3: Diego Martínez (Estudiante de finanzas)

#figure(
  image("../Figures/Template/Chapter3/persona_diego.png", width: 70%),
  caption: [Diego Martínez, estudiante de finanzas.],
) <fig:diego>

#figure(
  table(
    columns: (1fr, 3fr),
    align: (left, left),
    inset: 4pt,
    [*Edad*:], [22 años],
    [*Profesión*:], [Estudiante de máster en finanzas],
    [*Nivel financiero*:],
    [Avanzado (conoce indicadores y modelos de predicción teóricos)],

    [*Objetivo*:],
    [Validar en la práctica estrategias cuantitativas y comparar resultados],

    [*Contexto*:],
    [Trabaja con la aplicación desde su portátil y también desde el laboratorio
      de la universidad.],
  ),
  caption: [Datos de Diego Martínez.],
) <tabla:diego>

En la Figura 4.4 se representa el perfil de Diego Martínez. Diego es el usuario
más avanzado desde el punto de vista financiero. Además, en la Tabla 4.12 se
presentan sus datos personales y de inversión. Está haciendo un máster y quiere
validar con datos reales algunas de las estrategias que estudia en clase. Las
funcionalidades que más le interesan son el backtesting, las predicciones de
Prophet y, sobre todo, la posibilidad de exportar datos a JSON para luego
analizarlos con Python o Excel. Usa la aplicación tanto en su portátil personal
como en los ordenadores de la universidad.

=== Escenarios

Para hacer más tangible el uso de la plataforma, se describen tres escenarios
concretos basados en las personas anteriores. Cada escenario refleja una
situación realista en la que un usuario interactúa con FinancialPulse para
conseguir un objetivo determinado.

#figure(
  table(
    columns: (1.5fr, 3fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Persona*], [Alberto Gutiérrez],
    [*Objetivo*],
    [Probar una estrategia de cruce de medias móviles antes de invertir real.],

    [*Escenario*],
    [Alberto selecciona el activo TSLA en el buscador. En el dashboard, activa
      los indicadores SMA20 y SMA50 y el backtesting. Observa que en los últimos
      6 meses la estrategia habría dado un rendimiento del 15%. Decide comprar
      10 acciones virtuales desde la cartera. Días después, ve que la SMA20 ha
      superado a la SMA50 y recibe una recomendación de compra (aunque en la
      versión actual es bajo demanda). Exporta los resultados de su simulación
      en JSON para compartirlos con su grupo de Telegram.],
  ),
  caption: [Escenario 1: Alberto prueba y ejecuta una estrategia de trading.],
) <fig:escenario1>

La Tabla 4.11 presenta el perfil de Alberto Gutiérrez, un usuario que busca
validar estrategias de trading con datos históricos. Este escenario refleja el
uso de la plataforma desde una perspectiva más analítica. Alberto no confía
ciegamente en ninguna estrategia, sino que quiere comprobar con datos históricos
si el cruce de medias funciona en el caso de Tesla. Al ver que en los últimos
seis meses la estrategia habría dado un rendimiento positivo del 15%, se anima a
simular una compra en la cartera virtual. Días después, cuando la SMA20 supera a
la SMA50 en tiempo real, la aplicación le sugiere una recomendación de compra
(aunque en la versión actual esa recomendación se genera bajo demanda, no
automáticamente). El escenario termina con Alberto exportando los datos para
compartirlos con sus contactos.

#figure(
  table(
    columns: (1.5fr, 3fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Persona*], [Carmen Ruiz],
    [*Objetivo*],
    [Aprender qué es el RSI y cómo interpretarlo antes de simular una compra.],

    [*Escenario*],
    [Carmen entra en el dashboard de AAPL. Al hacer hover sobre el nombre del
      indicador RSI, aparece un tooltip que explica su significado
      (sobrecompra/sobreventa). Lee la página de ayuda del módulo de análisis.
      Después, cambia el idioma a español y consulta noticias sobre Apple. El
      análisis de sentimiento muestra un 70% de noticias positivas. Carmen,
      animada, compra 5 acciones virtuales y ve cómo su saldo se actualiza en el
      gráfico de cartera.],
  ),
  caption: [Escenario 2: Carmen aprende con tooltips y noticias.],
) <fig:escenario2>

Esta Tabla 4.14 presenta el perfil de Carmen Ruiz, un usuario que busca aprender
sobre indicadores técnicos antes de utilizarlos. El tooltip del RSI le explica
de forma sencilla los conceptos de sobrecompra y sobreventa. Además, consulta la
página de ayuda para profundizar un poco más. Al ver que la mayoría de las
noticias sobre Apple son positivas (70%), se siente con la confianza suficiente
para comprar 5 acciones virtuales. El gráfico de la cartera se actualiza
inmediatamente, lo que le permite ver el impacto de su decisión.

#figure(
  table(
    columns: (1.5fr, 3fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Persona*], [Diego Martínez],
    [*Objetivo*],
    [Obtener una predicción de precios para Bitcoin y usarla en su trabajo de
      fin de máster.],

    [*Escenario*],
    [Diego busca el activo BTC-USD. En la pestaña de predicción, Prophet genera
      una proyección a 30 días con intervalos de confianza y MAPE del 8%. Diego
      descarga los datos históricos en JSON (aunque no hay botón de descarga,
      los datos ya están disponibles en el frontend). También marca Bitcoin como
      favorito para seguir su evolución. Posteriormente, exporta todos sus datos
      personales (perfil, transacciones, favoritos) para incluirlos en el anexo
      de su trabajo académico.],
  ),
  caption: [Escenario 3: Diego utiliza predicciones y exporta datos.],
) <fig:escenario3>

Esta Tabla 4.15 presenta el escenario de Diego, quien aprovecha la funcionalidad
de predicción de Prophet para su trabajo de fin de máster. La proyección a 30
días con intervalos de confianza y un MAPE del 8% le ofrece una base
cuantitativa para sus análisis. Además, marca Bitcoin como favorito para seguir
su evolución sin tener que buscarlo cada vez. Finalmente, exporta todos sus
datos (perfil, transacciones, favoritos) en formato JSON, tal como requiere el
RGPD, para incluirlos como anexo en su memoria académica.

== Backlogs y requisitos

=== Historias de usuario

A partir de las personas y los escenarios anteriores, se definen una serie de
historias de usuario. Cada historia incluye una estimación en puntos de historia
(PH) y una prioridad. En este proyecto, un punto de historia se ha considerado
equivalente aproximadamente a una hora ideal de trabajo. La prioridad se
estableció pensando en qué funcionalidades eran más críticas para que la
aplicación tuviera sentido.

#set table(stroke: 1pt, align: center + horizon, inset: 4pt)
#set text(size: 9pt)

#figure(
  table(
    columns: (1.5fr, 4.5fr, 1fr, 1fr),
    [*ID*], [*Historia de usuario*], [*PH*], [*Prioridad*],
    [HU-1],
    [Como usuario, quiero registrarme e iniciar sesión para acceder a mis
      funciones.],
    [3],
    [1],

    [HU-2],
    [Como usuario, quiero recuperar mi contraseña mediante un código de
      verificación por correo.],
    [5],
    [2],

    [HU-3],
    [Como usuario, quiero buscar activos (acciones, criptomonedas, índices) por
      nombre o símbolo.],
    [5],
    [1],

    [HU-4],
    [Como usuario, quiero ver un gráfico histórico (velas o líneas) de un activo
      con selección de período.],
    [5],
    [1],

    [HU-5],
    [Como usuario, quiero calcular indicadores técnicos (RSI, MACD, SMA,
      Bollinger, estocástico) y verlos en el gráfico.],
    [8],
    [1],

    [HU-6],
    [Como usuario, quiero ejecutar un backtesting de la estrategia de cruce SMA
      20/50 y ver el rendimiento simulado.],
    [5],
    [2],

    [HU-7],
    [Como usuario, quiero obtener una predicción de precios a 30 días usando
      Prophet.],
    [8],
    [1],

    [HU-8],
    [Como usuario, quiero analizar el sentimiento de noticias financieras
      (positivo/neutral/negativo) para un tema o activo.],
    [8],
    [1],

    [HU-9],
    [Como usuario, quiero gestionar una cartera virtual con saldo inicial de
      10.000 USD, comprar y vender activos.],
    [8],
    [1],

    [HU-10],
    [Como usuario, quiero ver la evolución de mi balance y la composición de mi
      cartera en gráficos.],
    [5],
    [2],

    [HU-11],
    [Como usuario, quiero marcar activos como favoritos y ver su precio actual
      en una página dedicada.],
    [5],
    [2],

    [HU-12],
    [Como usuario, quiero buscar noticias financieras por palabra clave y
      ordenarlas por fecha o sentimiento.],
    [3],
    [3],

    [HU-13],
    [Como usuario, quiero que la interfaz esté disponible en español e inglés,
      con tooltips explicativos.],
    [5],
    [2],

    [HU-14],
    [Como usuario, quiero exportar todos mis datos personales en formato JSON
      (RGPD).],
    [3],
    [2],

    [HU-15],
    [Como usuario, quiero eliminar mi cuenta y que se borren todos mis datos en
      cascada.],
    [3],
    [2],

    [HU-16],
    [Como usuario, quiero acceder a páginas de ayuda que expliquen cómo usar
      cada sección.],
    [3],
    [3],
  ),
  caption: [Historias de usuario del proyecto.],
) <tabla:historias_usuario>

La anterior Tabla 4.16 presenta las historias de usuario definidas para el
proyecto. Estas historias sirven como punto de partida para organizar el
desarrollo y priorizar las funcionalidades más importantes. Algunas, como el
registro, la búsqueda de activos o los gráficos, tienen prioridad máxima porque
sin ellas la aplicación no tendría sentido. Otras, como la ayuda integrada o la
ordenación de noticias, podían dejarse para más adelante.

=== Product Backlog

El product backlog agrupa las historias de usuario priorizadas y organizadas por
sprints. Se planificaron cinco sprints de cuatro semanas cada uno, con una
velocidad estimada de 30 puntos de historia por sprint. La velocidad se calculó
en base a lo que se podría abarcar trabajando unas horas diarias, considerando
que no era un proyecto a tiempo completo. La siguiente Tabla 4.17 muestra cómo
se distribuyeron las historias de usuario a lo largo de los sprints, junto con
los puntos de historia y la prioridad de cada una.

#figure(
  table(
    columns: (1fr, 4fr, 1fr, 1fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Sprint*], [*Historias incluidas*], [*PH*], [*Prioridad*],
    [1], [HU-1, HU-3, HU-4, HU-5], [21], [Alta],
    [2], [HU-9, HU-7, HU-8, HU-2], [29], [Alta],
    [3], [HU-11, HU-13, HU-10, HU-6], [23], [Media],
    [4], [HU-14, HU-15, HU-12], [9], [Media],
    [5], [HU-16, pruebas, documentación, despliegue], [~15], [Baja],
  ),
  caption: [Product backlog y asignación a sprints.],
) <tabla:product_backlog>

En el primer sprint me centré en las bases: autenticación y primeros
indicadores. En el segundo, añadí la cartera virtual y la predicción, que eran
funcionalidades pesadas. El tercer sprint lo dediqué a favoritos,
internacionalización y gráficos de la cartera. Los sprints cuarto y quinto
fueron más ligeros: RGPD, noticias, ayuda, pruebas y documentación. Esta
distribución me permitió tener una versión funcional desde bastante pronto,
aunque limitada.

=== Sprint Backlog (ejemplo del sprint 1)

Para que se entienda mejor cómo se lleva a la práctica esta planificación, la
Tabla 4.18 muestra el sprint backlog del primer sprint. Contiene las tareas
concretas que se realizaron durante esas cuatro semanas.

#figure(
  table(
    columns: (1fr, 4fr, 1fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*ID*], [*Tarea*], [*Horas estimadas*],
    [T1], [Configurar proyecto Angular y Flask], [8],
    [T2], [Diseñar base de datos (Usuario, Cartera)], [4],
    [T3], [Implementar registro y login (frontend y backend)], [16],
    [T4], [Integrar Yahoo Finance y búsqueda de activos], [12],
    [T5], [Crear gráfico de velas con ngx-echarts], [8],
    [T6], [Calcular SMA y RSI en backend y mostrar], [10],
    [T7], [Pruebas unitarias y de integración del sprint], [8],
  ),
  caption: [Sprint backlog del sprint 1.],
) <tabla:sprint_backlog>

== Diagramas de secuencia

Para terminar el capítulo, a continuación se incluyen varios diagramas de
secuencia. Son una forma visual de entender cómo interactúan el frontend, el
backend, la base de datos y las APIs externas durante las operaciones más
importantes. Cada diagrama se centra en un flujo concreto.

=== Diagrama de secuencia: Registro de usuario

La siguiente Figura 4.5 muestra el diagrama de secuencia para el registro de
usuario. Este diagrama representa el proceso de creación de una cuenta nueva. El
usuario rellena el formulario con nombre, email y contraseña, y envía los datos.
El backend comprueba que el email no esté ya registrado. Si la validación es
correcta, se crea un nuevo registro en la tabla `usuario`, se genera
automáticamente una cartera asociada con saldo inicial de 10.000 USD y se
devuelve una confirmación al frontend. Si el email ya existe, se devuelve un
error.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia1.png", width: 100%),
  caption: [Diagrama de secuencia para el registro de usuario.],
) <fig:seq_registro_img>

=== Diagrama de secuencia: Inicio de sesión de un usuario

Una vez registrado, el usuario inicia sesión con su email y contraseña. El
backend consulta la base de datos y, si las credenciales son correctas, crea una
sesión almacenando el `user_id` en una cookie. Si no lo son, responde con un
error HTTP 401. A partir de ese momento, cada petición del frontend incluirá la
cookie y el backend podrá identificar al usuario sin necesidad de volver a
autenticarse. La siguiente Figura 4.6 muestra el diagrama de secuencia para este
proceso.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia2.png", width: 100%),
  caption: [Diagrama de secuencia para el inicio de sesión de un usuario.],
) <fig:seq_login_img>

=== Diagrama de secuencia: Recuperación de contraseña

Cuando un usuario olvida su contraseña, puede solicitar un código de
verificación introduciendo su email. El backend genera un token numérico
aleatorio de seis dígitos, lo almacena en la tabla `reset_token` con una validez
de una hora, y lo muestra por consola (en una versión real se enviaría por
correo electrónico). Después, el usuario introduce el código y la nueva
contraseña. El backend valida que el token sea correcto y no haya expirado, y
actualiza el campo `password_hash`. Si el token es inválido o ha caducado, se
devuelve un error. La Figura 4.7 muestra el diagrama de secuencia para este
proceso de recuperación

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia3.png", width: 100%),
  caption: [Diagrama de secuencia para la recuperación de contraseña.],
) <fig:seq_recovery_img>

=== Diagrama de secuencia: Obtener datos de una acción (dashboard)

La siguiente Figura 4.8 muestra el diagrama de secuencia para obtener datos de
una acción. Este diagrama es uno de los más complejos, porque el dashboard
agrupa mucha información. El frontend pide al backend los datos históricos (con
un período configurable, por ejemplo 6 meses), la información general del activo
(nombre, sector, etc.), la predicción de Prophet y las noticias relacionadas. El
backend consulta Yahoo Finance, ejecuta el modelo de predicción (entrenándolo
bajo demanda), llama a NewsAPI y analiza el sentimiento de cada noticia con el
modelo correspondiente (FinBERT para inglés o el modelo español). Finalmente,
devuelve un único JSON con todos los datos agregados. El frontend se encarga de
mostrarlos en las diferentes pestañas del dashboard.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia4.png", width: 100%),
  caption: [Diagrama de secuencia para obtener datos de una acción.],
) <fig:seq_dashboard_img>

=== Diagrama de secuencia: Comprar una acción en la cartera virtual

Cuando el usuario decide comprar acciones desde el dashboard, el frontend envía
al backend el símbolo del activo, la cantidad deseada y el precio actual. El
backend localiza la cartera del usuario y comprueba si el saldo es suficiente.
Si lo es, resta el importe total, incrementa el contador de transacciones y
registra la operación en la tabla `transaccion` con tipo `compra`. Después,
devuelve el nuevo saldo al frontend, que actualiza la interfaz. Si el saldo no
es suficiente, se devuelve un error. La Figura 4.9 muestra el diagrama de
secuencia para este proceso de compra en la cartera virtual.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia5.png", width: 100%),
  caption: [Diagrama de secuencia para comprar una acción en la cartera
    virtual.],
) <fig:seq_compra_img>

=== Diagrama de secuencia: Vender una acción (cartera virtual)

El proceso de venta es simétrico al de compra, pero con una comprobación
adicional: el usuario solo puede vender acciones que realmente posea. El backend
calcula primero la posición actual del usuario para ese activo, sumando todas
las compras y restando las ventas previas. Si la cantidad que se quiere vender
no supera la disponible, se actualiza el saldo (sumando el ingreso), se
incrementa el contador de transacciones y se registra una transacción de tipo
`venta`. Si el usuario intenta vender más acciones de las que tiene, se devuelve
un error. La Figura 4.10 muestra el diagrama de secuencia para este proceso de
venta en la cartera virtual.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia6.png", width: 100%),
  caption: [Diagrama de secuencia para vender una acción en la cartera
    virtual.],
) <fig:seq_venta_img>

=== Diagrama de secuencia: Obtener noticias

La aplicación permite buscar noticias financieras por palabra clave e idioma. El
backend llama a NewsAPI con los parámetros adecuados, recibe una lista de
artículos y, para cada uno, analiza el sentimiento del título y la descripción
usando el modelo correspondiente según el idioma detectado. Luego agrupa los
resultados por sentimiento y calcula porcentajes. Finalmente, devuelve al
frontend tanto las noticias enriquecidas con su etiqueta de sentimiento como un
resumen visual (porcentajes) que se muestra en un gráfico circular. La Figura
4.11 muestra el diagrama de secuencia para este proceso de obtención y análisis
de noticias financieras.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia7.png", width: 100%),
  caption: [Diagrama de secuencia para obtener noticias financieras.],
) <fig:seq_noticias_img>

=== Diagrama de secuencia: Editar perfil de un usuario

El usuario puede modificar su nombre, email o contraseña desde la página de
perfil. Para cambiar la contraseña, es obligatorio introducir primero la actual.
Si el usuario cambia el email, el backend comprueba que el nuevo email no
pertenezca ya a otra cuenta. Tras pasar las validaciones, se actualizan los
campos en la tabla `usuario` y se confirma la operación. En caso de error
(contraseña actual incorrecta, email duplicado, etc.), se devuelve el mensaje
correspondiente. La Figura 4.12 muestra el diagrama de secuencia para este
proceso de edición del perfil de usuario.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia8.png", width: 100%),
  caption: [Diagrama de secuencia para editar el perfil de un usuario.],
) <fig:seq_perfil_img>

Estos diagramas permiten visualizar de manera más clara la interacción entre los
distintos componentes del sistema y sirven como base para la implementación
descrita en los capítulos posteriores. Aunque el diseño preliminar siempre varía
un poco al llevarlo a la práctica, tenerlos fue de gran ayuda para no perderme
en la comunicación entre partes.

== Análisis de requisitos

A continuación, se realiza un análisis de requisitos para definir claramente qué
funcionalidades debe tener la aplicación y qué características no funcionales se
deben cumplir. Este análisis es fundamental para guiar el desarrollo y
asegurarse de que el producto final cumpla con las expectativas de los usuarios
y los objetivos del proyecto.

=== Requisitos funcionales (RF)

- *RF-01*: Gestión de usuarios: registro, inicio de sesión, cierre de sesión,
  recuperación de contraseña, edición del perfil.
- *RF-02*: Búsqueda de activos financieros (acciones, criptomonedas, índices,
  divisas) con autocompletado.
- *RF-03*: Visualización de datos históricos en gráficos de líneas y velas, con
  selección de período (1 semana, 1 mes, 3 meses, 1 año, 5 años, máximo).
- *RF-04*: Cálculo y visualización de indicadores técnicos (RSI, MACD, SMA,
  Bandas de Bollinger, estocástico).
- *RF-05*: Backtesting de la estrategia de cruce de medias móviles (SMA 20/50)
  sobre datos históricos.
- *RF-06*: Predicción de precios futuros (30 días) usando Prophet, con
  intervalos de confianza y error MAPE.
- *RF-07*: Análisis de sentimiento de noticias financieras (positivo, neutral,
  negativo) mediante FinBERT (inglés) y `bardsai/finance-sentiment-es-base`
  (español).
- *RF-08*: Cartera virtual: saldo inicial 10.000 USD, compra/venta, historial,
  valoración en tiempo real, gráfico de evolución y composición (tarta).
- *RF-09*: Favoritos: marcar activos y una página dedicada.
- *RF-10*: Noticias: búsqueda por palabra clave, ordenación por fecha o
  sentimiento, resumen con gráfico circular.
- *RF-11*: Internacionalización completa (español/inglés) con pipe de traducción
  propio y selector de idioma.
- *RF-12*: Tooltips explicativos en elementos clave, traducidos automáticamente.
- *RF-13*: Exportación de datos personales en JSON (RGPD).
- *RF-14*: Eliminación de la cuenta en cascada (cartera, transacciones,
  favoritos).
- *RF-15*: Ayuda integrada con páginas estáticas (Análisis, Cartera, Noticias).

=== Requisitos no funcionales (RNF)

- *RNF-01*: El frontend debe ser una SPA responsive, funcional en navegadores
  modernos (Chrome, Firefox, Edge).
- *RNF-02*: El tiempo de respuesta de la API no debe superar los 3 segundos en
  condiciones normales.
- *RNF-03*: La aplicación debe poder desplegarse con Docker (docker-compose up).
- *RNF-04*: Las contraseñas se almacenarán cifradas (bcrypt).
- *RNF-05*: La comunicación frontend-backend será mediante API REST con
  autenticación por sesión (cookies).
- *RNF-06*: El código fuente estará en GitHub con licencia de código abierto
  (MIT).
- *RNF-07*: La interfaz debe ser intuitiva, con ayuda integrada y tooltips.

== Casos de uso

Los casos de uso son una herramienta de modelado que describe las interacciones
entre los usuarios y el sistema para lograr un objetivo específico. Permiten
visualizar de manera clara y estructurada las funcionalidades que el sistema
debe ofrecer y cómo los usuarios las utilizarán. En este proyecto, se
identificaron varios casos de uso clave que cubren desde la gestión de usuarios
hasta la interacción con los datos financieros.

Los actores del sistema son: *Usuario no registrado* (invitado), *Usuario
registrado* y *Administrador* (aunque no tiene interfaz específica, puede
acceder directamente a la base de datos). A continuación, en la Figura 4.13 se
muestra el diagrama de casos de uso.

#figure(
  image("../Figures/Template/Chapter5/diagrama_caso_uso.png", width: 60%),
  caption: [Diagrama de casos de uso del sistema.],
)

=== Descripción de casos de uso principales

- *CU-01: Registrarse*: El usuario no registrado introduce email, contraseña y
  demás datos; el sistema valida y crea la cuenta.
- *CU-02: Iniciar sesión*: El usuario introduce credenciales; el sistema
  verifica y crea la sesión.
- *CU-03: Recuperar contraseña*: El usuario solicita recuperación; el sistema
  envía un código numérico por correo y permite cambiarla.
- *CU-04: Buscar activo*: El usuario escribe un nombre o símbolo; el sistema
  muestra sugerencias.
- *CU-05: Ver dashboard del activo*: El usuario selecciona un activo y ve
  gráfico histórico, indicadores, predicción y sentimiento (si está
  autenticado).
- *CU-06: Comprar activo (cartera virtual)*: El usuario autenticado introduce
  cantidad y confirma; el sistema verifica saldo, actualiza cartera y registra
  la transacción.
- *CU-07: Vender activo*: Similar a compra, pero comprueba que tenga suficientes
  acciones.
- *CU-08: Marcar/desmarcar favorito*: El usuario autenticado puede añadir o
  quitar un activo de favoritos.
- *CU-09: Ver noticias financieras*: El usuario introduce una palabra clave; el
  sistema obtiene noticias de NewsAPI y aplica análisis de sentimiento.
- *CU-10: Exportar datos personales*: El usuario autenticado solicita
  exportación; el sistema genera un JSON con sus datos y lo descarga.
- *CU-11: Eliminar cuenta*: El usuario autenticado confirma la eliminación; el
  sistema borra todos sus datos en cascada.

== Diseño de la base de datos

En cuanto al diseño de la base de datos, se optó por un modelo relacional que
reflejara las entidades principales del sistema y sus relaciones. El diagrama
entidad-relación (ER) se muestra en la Figura 4.14. Las entidades principales
son `Usuario`, `Cartera`, `Transaccion`, `Favorito` y `ResetToken`. Cada una
tiene sus atributos y relaciones claramente definidas.

Se optó por usar PostgreSQL como sistema de gestión de bases de datos relacional
(RDBMS) debido a su robustez, escalabilidad y amplia adopción en la industria.
Además, SQLAlchemy se utilizó como ORM (Object-Relational Mapping) para
facilitar la interacción con la base de datos desde el código Python. Esto
permite trabajar con objetos en lugar de escribir SQL manualmente, lo que mejora
la legibilidad y mantenibilidad del código.

#figure(
  image("../Figures/Template/Chapter5/diagrama_ER.png", width: 100%),
  caption: [Diagrama entidad-relación (ER) de la base de datos.],
) <fig:er_diagram>

=== Paso a tablas y fusión

Del diagrama ER al modelo físico se siguieron los siguientes pasos:

- La entidad `Usuario` se convierte en la tabla `usuario` con sus atributos.
- La entidad `Cartera` tiene relación 1:1 con `Usuario`, así que se añadió
  `usuario_id` como clave foránea.
- La relación 1:N entre `Cartera` y `Transaccion` se resuelve con `cartera_id`
  en `transaccion`. Como no se guarda una tabla separada de acciones, se pone el
  símbolo del activo directamente `accion_simbolo`.
- La relación 1:N entre `Usuario` y `Favorito` se resuelve con `usuario_id` en
  `favorito`.
- La relación 1:N entre `Usuario` y `ResetToken` se resuelve con `usuario_id` en
  `reset_token`.

No se fusionaron más tablas para evitar redundancias.

=== Normalización de la base de datos

El diseño de la base de datos cumple las tres primeras formas normales:

- *1FN*: todos los atributos son atómicos. Por ejemplo, en `transaccion` no hay
  listas ni grupos repetidos.
- *2FN*: los atributos no clave dependen por completo de la clave primaria. En
  `transaccion`, todos dependen de `id_transaccion`.
- *3FN*: no hay dependencias transitivas. Por ejemplo, en `usuario`, `nombre`
  depende directamente de `id`, no de otro atributo no clave.

En la práctica, esto significa que no hay redundancias innecesarias y que las
actualizaciones no deberían generar inconsistencias.

=== Tablas de la base de datos

A continuación, en la Tabla 4.19, Tabla 4.20, Tabla 4.21, Tabla 4.22 y Tabla
4.23, se muestran las tablas con sus campos, tipos y restricciones principales.
Estas tablas reflejan el diseño final de la base de datos relacional para la
aplicación.

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
  caption: [Estructura de la tabla `usuario`.],
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
  caption: [Estructura de la tabla `cartera`.],
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
  caption: [Estructura de la tabla `transaccion`.],
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
  caption: [Estructura de la tabla `favorito`. La combinación
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
  caption: [Estructura de la tabla `reset_token`.],
) <tabla:reset_token>

=== Relaciones de la base de datos

Las claves foráneas mantienen la integridad referencial. Se han definido índices
en `email` (usuario), `simbolo` (transaccion y favorito) y `usuario_id`
(cartera) para acelerar las consultas más habituales. Sin estos índices, las
búsquedas serían más lentas a medida que crecieran los datos.

== Diagramas de clases

Los diagramas de clases son una herramienta fundamental para visualizar la
estructura del software, las entidades que lo componen y sus relaciones. En este
proyecto, se han creado diagramas de clases a dos niveles: unos más detallados
(por capas) y otros globales (visión de conjunto). Estos diagramas ayudan a
entender cómo se organiza el código, qué clases existen, qué atributos y métodos
tienen, y cómo se relacionan entre sí. A continuación, se presentan los
diagramas de clases para el backend y el frontend.

=== Backend

==== Modelos del backend

La siguiente Figura 4.15 se refiere al diagrama el cual muestra los modelos
SQLAlchemy (Usuario, Cartera, Transaccion, Favorito, ResetToken) con sus
atributos y relaciones (1:1, 1:N). Es la base de todo el sistema de
persistencia.

#figure(
  image(
    "../Figures/Template/Chapter7/diagrama_clases_backend_modelos.drawio.png",
    width: 120%,
  ),
  caption: [Diagrama de clases detallado de los modelos del backend.],
) <fig:backend_modelos>

==== Controladores (endpoints) del backend

Agrupo las rutas de la API por responsabilidad: `AuthController` (autenticación
y perfil), `AssetController` (búsqueda y datos de activos),
`TechnicalController` (indicadores, recomendación, predicción), `NewsController`
(noticias y sentimiento), `PortfolioController` (cartera virtual) y
`FavoritesController` (favoritos). Esta separación no es rígida, pero ayuda a
organizar mentalmente el código. La siguiente Figura 4.16 muestra el diagrama de
clases de los controladores del backend, con sus métodos y dependencias. Se ve
claramente cómo cada controlador se apoya en los modelos para acceder a la base
de datos, y cómo algunos dependen de APIs externas o librerías de IA para
cumplir su función.

#figure(
  image(
    "../Figures/Template/Chapter7/diagrama_clases_backend_controladores.drawio.png",
    width: 120%,
  ),
  caption: [Diagrama de clases detallado de los controladores del backend.],
) <fig:backend_controladores>

==== Visión global del backend

La siguiente Figura 4.17 se refiere al diagrama global del backend, que integra
modelos y controladores, mostrando las dependencias y cómo algunos controladores
se apoyan en APIs externas (Yahoo Finance, NewsAPI) o librerías de IA (Prophet,
Transformers). Es útil para tener una vista general sin perderse en detalles.

#landscape_page[
  #figure(
    image(
      "../Figures/Template/Chapter7/diagrama_clases_backend.png",
      width: 100%,
    ),
    caption: [Diagrama de clases global del backend.],
  ) <fig:backend_global>
]

=== Frontend

==== Modelos del frontend

En Angular se definió interfaces TypeScript que reflejan los datos de la API. La
siguiente Figura 4.18 muestra el diagrama de clases de los modelos del frontend,
con sus atributos y métodos. Es una parte fundamental para tipar los datos que
se manejan en la aplicación y facilitar la comunicación con el backend.

#figure(
  image(
    "../Figures/Template/Chapter7/diagrama_clases_frontend_modelos.drawio.png",
    width: 112%,
  ),
  caption: [Diagrama de clases detallado de los modelos del frontend.],
) <fig:frontend_modelos>

==== Servicios del frontend

La siguiente Figura 4.19 se refiere al diagrama de clases de los servicios
Angular del frontend. Cada servicio se encarga de una parte concreta de la
lógica de negocio y la comunicación con el backend. Esta separación es más
óptima porque mantiene los componentes más limpios. Se ve cómo `AuthService`
maneja todo lo relacionado con la autenticación, `AssetService`con la búsqueda
de activos, `DataService` con la obtención de datos para el dashboard,
`NewsService` con las noticias, `PortfolioService` con la cartera virtual y
`FavoritesService` con los favoritos. Además, `LanguageService` se encarga de
lainternacionalización y es utilizado por varios servicios para adaptar los
textos al idioma seleccionado.

#landscape_page[
  #figure(
    image(
      "../Figures/Template/Chapter7/diagrama_clases_frontend_servicios.drawio.png",
      width: 100%,
    ),
    caption: [Diagrama de clases detallado de los servicios del frontend.],
  ) <fig:frontend_servicios>
]


==== Vistas principales del frontend

La siguiente Figura 4.20 se refiere al diagrama de clases de las vistas
principales del frontend. Las vistas son componentes asociados a las rutas:
`LoginComponent`, `RegisterComponent`, `HomeComponent`, `DashboardComponent`,
`PortfolioComponent`, `FavoritesComponent`, `NewsComponent`, `ProfileComponent`
y las páginas de ayuda. Cada vista inyecta los servicios que necesita. Algunas
son muy sencillas (como la de favoritos) y otras son bastante complejas (como el
dashboard).

#figure(
  image(
    "../Figures/Template/Chapter7/diagrama_clases_frontend_vistas.drawio.png",
    width: 120%,
  ),
  caption: [Diagrama de clases detallado de las vistas principales del
    frontend.],
) <fig:frontend_vistas>

==== Visión global del frontend

La siguiente Figura 4.21 muestra el diagrama global del frontend. Integra
modelos, servicios y vistas. Se ve cómo los servicios dependen de los modelos
para tipar los datos, y cómo las vistas se apoyan en los servicios. Además,
`AssetService` y `NewsService` usan `LanguageService` para adaptar los textos al
idioma. Es una arquitectura bastante estándar en Angular.

#landscape_page[
  #figure(
    image(
      "../Figures/Template/Chapter7/diagrama_clases_frontend.png",
      width: 100%,
    ),
    caption: [Diagrama de clases global del frontend.],
  ) <fig:frontend_global>
]

Estos diagramas están simplificados para resaltar las relaciones más
importantes. Representan fielmente la arquitectura de FinancialPulse y sirven de
guía para el mantenimiento futuro o para que cualquier desarrollador lo entienda
rápidamente.

== Arquitectura del software

FinancialPulse sigue una arquitectura cliente-servidor de tres capas. La
siguiente Figura 4.22 muestra el esquema general de la arquitectura. El frontend
(cliente) se encarga de la interfaz de usuario y la interacción, mientras que el
backend (servidor) maneja la lógica de negocio, la gestión de datos y la
comunicación con APIs externas. La base de datos almacena la información
persistente de usuarios, carteras, transacciones y favoritos.

#figure(
  image("../Figures/Template/Chapter5/diagrama_arquitectura.png", width: 100%),
  caption: [Diagrama de arquitectura cliente-servidor mostrando los componentes
    Angular (frontend), Flask (backend), PostgreSQL y las APIs externas (Yahoo
    Finance, NewsAPI), así como el flujo de peticiones.],
) <fig:arquitectura>

=== Capas del sistema

- *Capa de presentación (cliente)*: SPA con Angular 21. Se comunica con el
  backend mediante HTTP y servicios Angular. Usa Tailwind CSS y ngx-echarts.
- *Capa de lógica de negocio (servidor)*: API REST con Flask. Maneja
  autenticación, consultas a Yahoo Finance, indicadores técnicos, predicción
  Prophet, análisis de sentimiento, cartera virtual y favoritos.
- *Capa de datos*: PostgreSQL 15 con SQLAlchemy.

=== Patrón Modelo-Vista-Controlador (MVC)

Aunque no se aplicó de forma explícita, la estructura se ajusta al patrón MVC.
Este patrón ayuda a separar las responsabilidades y mantener el código
organizado:

- *Modelo*: clases SQLAlchemy en backend; interfaces TypeScript en frontend.
- *Vista*: componentes Angular (HTML+CSS).
- *Controlador*: servicios Angular (frontend) y rutas Flask (backend).

Separar las responsabilidades de esta manera ayuda a no mezclar lógica de
negocio con presentación, lo que facilita el mantenimiento y la escalabilidad
del proyecto. Además, permite que diferentes desarrolladores (no en este caso)
puedan trabajar en distintas capas sin interferir entre sí.

== Diseño de la interfaz de usuario

En cuanto al diseño de la interfaz de usuario se centró en que fuera usable,
accesible y fácil de entender, sobre todo para usuarios sin experiencia. Se usó
Tailwind CSS @tailwindcss2026 para los estilos (responsive) y ngx-echarts
@ngxecharts2026 para los gráficos. A continuación se describe cada pantalla con
su correspondiente mockup.

=== Pantalla de inicio de sesión (`/login`)

El usuario introduce email y contraseña. Tiene una casilla *Recordarme*, un
enlace para recuperar la contraseña y otro para ir al registro. La Figura 4.23
muestra el mockup de esta pantalla.

#figure(
  image("../Figures/Template/Chapter5/mockup_login.png", width: 100%),
  caption: [Mockup de la pantalla de inicio de sesión.],
) <fig:mockup_login>

=== Pantalla de registro (`/register`)

Formulario con nombre, email, contraseña y confirmación. Se comprueba que el
email no esté ya registrado y que la contraseña tenga una longitud mínima. Al
registrarse, se crea automáticamente una cartera con 10.000 USD. La Figura 4.24
muestra el mockup de esta pantalla.

#figure(
  image("../Figures/Template/Chapter5/mockup_register.png", width: 100%),
  caption: [Mockup de la pantalla de registro.],
) <fig:mockup_registro>

=== Pantalla de recuperación de contraseña (`/forgot-password`)

Se pide el email, se genera un código de 6 dígitos (se muestra por consola) y
luego se ingresa junto con la nueva contraseña. La Figura 4.25 muestra el mockup
de esta pantalla.

#figure(
  image("../Figures/Template/Chapter5/mockup_forgot.png", width: 100%),
  caption: [Mockup de la pantalla de recuperación de contraseña.],
) <fig:mockup_forgot>

=== Página de inicio (Home) (`/`)

La Figura 4.26 muestra el mockup de esta pantalla. Es la primera pantalla tras
el login. Muestra:

- Barra de navegación superior con enlaces y selector de idioma.
- Resumen de índices bursátiles (S&P 500, IBEX 35, etc.) con precio y cambio.
- Últimas noticias destacadas.
- Balance resumido de la cartera y acceso directo.
- Lista de las últimas transacciones.

#figure(
  image("../Figures/Template/Chapter5/mockup_home.png", width: 100%),
  caption: [Mockup de la página de inicio (home).],
) <fig:mockup_home>

=== Dashboard de un activo (`/asset/:symbol`)

Es la pantalla más completa. Incluye:

- Cabecera con nombre, símbolo, precio, cambio y moneda.
- Gráfico interactivo (velas o líneas) con selector de período.
- Pestañas:
  - *Indicadores técnicos*: SMA20, SMA50, RSI, MACD, Bollinger, estocástico.
  - *Predicción (Prophet)*: forecast a 30 días con intervalos y MAPE.
  - *Sentimiento*: noticias del activo con etiquetas y gráfico circular.
  - *Fundamentos*: datos de la empresa (marketCap, PER, etc.).
- Botones *Comprar* y *Vender* (solo si está autenticado).
- Icono de estrella para favoritos.
La Figura 4.27 muestra el mockup de esta pantalla.

#figure(
  image("../Figures/Template/Chapter5/mockup_dashboard.png", width: 100%),
  caption: [Mockup del dashboard de un activo (ejemplo: Apple Inc.).],
) <fig:mockup_dashboard>

=== Página de cartera virtual (`/portfolio`)

Resume la simulación financiera del usuario:

- Tarjeta con saldo, total depositado/retirado y beneficio no realizado.
- Gráfico de evolución del balance.
- Gráfico de tarta con la composición de la cartera.
- Tabla de transacciones recientes con paginación.
La Figura 4.28 muestra el mockup de esta pantalla.

#figure(
  image("../Figures/Template/Chapter5/mockup_portfolio.png", width: 100%),
  caption: [Mockup de la página de cartera virtual.],
) <fig:mockup_cartera>

=== Página de favoritos (`/favorites`)

Lista todos los activos favoritos con su precio actual, cambio y un botón para
ir al dashboard. La Figura 4.29 muestra el mockup de esta pantalla.

#figure(
  image("../Figures/Template/Chapter5/mockup_favorites.png", width: 100%),
  caption: [Mockup de la página de favoritos.],
) <fig:mockup_favoritos>

=== Página de noticias (`/news`)

Barra de búsqueda por palabra clave o símbolo. Los resultados se muestran con
título, fecha, fuente y un indicador de sentimiento. Un gráfico circular resume
el porcentaje de noticias positivas, neutrales y negativas. La Figura 4.30
muestra el mockup de esta pantalla.

#figure(
  image("../Figures/Template/Chapter5/mockup_news.png", width: 100%),
  caption: [Mockup de la página de noticias con análisis de sentimiento.],
) <fig:mockup_noticias>

=== Página de perfil de usuario (`/profile`)

Permite cambiar nombre, email y contraseña (esta última pide la actual). También
exportar datos en JSON y eliminar la cuenta (con doble confirmación). La Figura
4.31 muestra el mockup de esta pantalla.

#figure(
  image("../Figures/Template/Chapter5/mockup_profile.png", width: 100%),
  caption: [Mockup de la página de perfil de usuario.],
) <fig:mockup_perfil>

=== Páginas de ayuda (`/help`)

Tres páginas estáticas (Análisis técnico, Cartera virtual, Noticias) con
explicaciones y ejemplos. Estas páginas son importantes para que los usuarios
sin experiencia puedan entender los conceptos y funcionalidades. La Figura 4.32
muestra el mockup de una de estas páginas de ayuda, y las siguientes figuras,
Figura 4.33 y Figura 4.34, muestran ejemplos de las otras dos páginas de ayuda.

#figure(
  image("../Figures/Template/Chapter5/mockup_help1.png", width: 100%),
  caption: [Mockup de una página de ayuda (Ayuda de análisis).],
) <fig:mockup_ayuda>

#figure(
  image("../Figures/Template/Chapter5/mockup_help2.png", width: 100%),
  caption: [Mockup de una página de ayuda (ejemplo: Ayuda de cartera).],
) <fig:mockup_ayuda>

#figure(
  image("../Figures/Template/Chapter5/mockup_help3.png", width: 100%),
  caption: [Mockup de una página de ayuda (ejemplo: Ayuda de noticias).],
) <fig:mockup_ayuda>

=== Componentes reutilizables

Para no repetir código, se crearon varios componentes Angular y directivas:

- `AssetSearchComponent`: buscador con autocompletado (usa
  `/api/search/{query}`).
- `PriceChartComponent`: componente de gráfico genérico (línea/velas).
- `TransactionModalComponent`: modal para compra/venta con validación de saldo.
- `LanguageSwitcherComponent`: selector de idioma que cambia los textos mediante
  un `TranslatePipe`.
- `TooltipDirective`: añade tooltips traducidos al hacer hover.

La estructura de carpetas del frontend es la siguiente:

- `pages/`: vistas principales.
- `components/`: elementos reutilizables.
- `services/`: controladores que llaman a la API.
- `pipes/`: `TranslatePipe`.
- `directives/`: `TooltipDirective`.
- `guards/`: guardianes de rutas.
- `models/`: interfaces TypeScript.

Todo el diseño es responsive, adaptándose a móviles, tabletas y escritorio
gracias a Tailwind CSS.

Una vez definida la planificación y el diseño, el siguiente capítulo detalla las
herramientas utilizadas y las fuentes de datos.
