= Definición del problema

En este capítulo se formaliza el problema que resuelve _FinancialPulse_, se
identifican los stakeholders y usuarios, se definen las historias de usuario y
los requisitos, y se presentan diagramas de secuencia para los flujos más
importantes.

== Stakeholders y usuarios

A continuación se describen las personas (perfiles de usuario) representativas y
los escenarios de uso de la aplicación.

=== Personas

La técnica de personas permite entender las necesidades, objetivos y
comportamientos de los distintos tipos de usuarios. Para _FinancialPulse_ se han
definido tres perfiles principales. Cada persona se acompaña de una imagen
ilustrativa generada por inteligencia artificial.

==== Persona 1: Alberto Gutiérrez (Inversor tecnológico)

#figure(
  image("../Figures/Template/Chapter3/persona_alberto.png", width: 70%),
  caption: [Alberto Gutiérrez, inversor tecnológico.],
) <fig:alberto>

#figure(
  table(
    columns: (1fr, 3fr),
    // stroke: none,
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

Alberto busca herramientas que le permitan probar sus hipótesis de inversión sin
arriesgar dinero real. Valora la velocidad de los datos en tiempo real y la
posibilidad de recibir alertas personalizadas (aunque en la versión actual se
implementarán en el futuro). Quiere integrar _FinancialPulse_ en su rutina de
análisis diario.

==== Persona 2: Carmen Ruiz (Profesora de economía jubilada)

#figure(
  image("../Figures/Template/Chapter3/persona_carmen.png", width: 70%),
  caption: [Carmen Ruiz, profesora de economía jubilada.],
) <fig:carmen>

#figure(
  table(
    columns: (1fr, 3fr),
    // stroke: none,
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

Carmen no confía en las aplicaciones complejas. Quiere una herramienta educativa
que le explique los conceptos (tooltips, páginas de ayuda) y que le permita
simular sin miedo a perder dinero real. Le gusta la idea de que la app esté en
español y tenga gráficos claros.

==== Persona 3: Diego Martínez (Estudiante de finanzas)

#figure(
  image("../Figures/Template/Chapter3/persona_diego.png", width: 70%),
  caption: [Diego Martínez, estudiante de finanzas.],
) <fig:diego>

#figure(
  table(
    columns: (1fr, 3fr),
    // stroke: none,
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

Diego necesita una plataforma que le permita *exportar datos* para analizarlos
con sus propias herramientas (Python, Excel). Valora el backtesting de
estrategias (como el cruce de medias) y la posibilidad de obtener predicciones
con Prophet. Usa la aplicación para preparar trabajos académicos y su propio
porfolio virtual.

=== Escenarios

Los escenarios describen situaciones concretas en las que los usuarios
interactúan con el sistema. Se presentan tres escenarios originales.

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

== Backlogs y requisitos

=== Historias de usuario

Se han definido las siguientes historias de usuario (HU) con su estimación en
puntos de historia (PH) y prioridad. Cada punto de historia corresponde a una
hora ideal de trabajo.

#set table(stroke: 1pt, align: center + horizon, inset: 4pt)
#set text(size: 9pt) // Opcional: reducir tamaño para toda la tabla

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

=== Product Backlog

El product backlog contiene todas las historias de usuario priorizadas. Para
este proyecto se han estimado 5 sprints de 4 semanas cada uno. La velocidad del
equipo (único desarrollador) es de 30 puntos de historia por sprint.

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

=== Sprint Backlog (ejemplo del sprint 1)

El primer sprint se centró en las funcionalidades base: autenticación, búsqueda
de activos, gráficos históricos e indicadores básicos.

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

Por último, para finalizar con la parte de definición del problema, se presentan
los diagramas de secuencia. Estas herramientas visuales, derivadas de UML,
ilustran cómo los distintos componentes del sistema (frontend, backend, base de
datos y APIs externas) interactúan entre sí para llevar a cabo las operaciones
más importantes. Los diagramas se centran en el orden temporal de los mensajes
intercambiados, mostrando cómo se ejecutan las funcionalidades a lo largo del
tiempo. A continuación se describen los flujos críticos de _FinancialPulse_.

=== Diagrama de secuencia: Registro de usuario

El primer diagrama representa el proceso de creación de una nueva cuenta. El
usuario envía sus datos (nombre, email y contraseña) a través del formulario de
registro. El backend verifica que el email no esté duplicado y, si es válido,
crea un nuevo registro en la tabla `usuario`, genera automáticamente una cartera
virtual asociada con un saldo inicial de 10.000 USD, y devuelve una
confirmación.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia1.png", width: 100%),
  caption: [Diagrama de secuencia para el registro de usuario.],
) <fig:seq_registro_img>

=== Diagrama de secuencia: Inicio de sesión de un usuario

Una vez registrado, el usuario inicia sesión proporcionando email y contraseña.
El backend consulta la base de datos para verificar las credenciales. Si son
correctas, se crea una sesión (almacenando el `user_id` en la cookie de sesión)
y se devuelve la información básica del usuario. En caso contrario, se responde
con un error 401.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia2.png", width: 100%),
  caption: [Diagrama de secuencia para el inicio de sesión de un usuario.],
) <fig:seq_login_img>

=== Diagrama de secuencia: Recuperación de contraseña

Cuando el usuario olvida su contraseña, solicita un código de verificación
introduciendo su email. El backend genera un token numérico de 6 dígitos, lo
almacena en la tabla `reset_token` con una validez de una hora y lo muestra por
consola (simulando el envío por correo). Posteriormente, el usuario introduce el
código junto con la nueva contraseña; el backend valida el token y actualiza el
`password_hash` en la base de datos.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia3.png", width: 100%),
  caption: [Diagrama de secuencia para la recuperación de contraseña.],
) <fig:seq_recovery_img>

=== Diagrama de secuencia: Obtener datos de una acción (dashboard)

Para mostrar el dashboard de un activo, el frontend solicita al backend los
datos históricos, la información fundamental, la predicción de precios con
Prophet y las noticias relevantes. El backend consulta Yahoo Finance (datos
históricos e info), ejecuta el modelo de predicción y llama a NewsAPI para
obtener artículos. Cada noticia se analiza con el modelo de sentimiento
correspondiente (FinBERT para inglés o `finance-sentiment-es-base` para
español). Finalmente, se devuelve un JSON con todos los datos agregados.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia4.png", width: 100%),
  caption: [Diagrama de secuencia para obtener datos de una acción.],
) <fig:seq_dashboard_img>

=== Diagrama de secuencia: Comprar una acción en la cartera virtual

Desde el dashboard, el usuario puede comprar acciones de un activo. El backend
verifica el saldo disponible en la cartera del usuario. Si hay fondos
suficientes, resta el coste total, incrementa el contador de transacciones y
registra una operación de compra en la tabla `transaccion`. El nuevo saldo se
devuelve al frontend para actualizar la interfaz.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia5.png", width: 100%),
  caption: [Diagrama de secuencia para comprar una acción en la cartera
    virtual.],
) <fig:seq_compra_img>

=== Diagrama de secuencia: Vender una acción (cartera virtual)

De forma análoga a la compra, el usuario puede vender acciones que posea. El
backend calcula la posición actual del usuario para ese símbolo (sumando las
cantidades de las transacciones previas). Si la cantidad a vender no supera la
disponible, se actualiza el saldo (sumando el ingreso), se registra una
transacción de tipo `venta` y se devuelve el nuevo saldo.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia6.png", width: 100%),
  caption: [Diagrama de secuencia para vender una acción en la cartera
    virtual.],
) <fig:seq_venta_img>

=== Diagrama de secuencia: Obtener noticias

El usuario puede buscar noticias financieras por palabra clave e idioma. El
backend consulta NewsAPI y, para cada artículo, analiza el sentimiento del
título y la descripción utilizando el modelo correspondiente. Finalmente, se
devuelve un resumen con la distribución de sentimientos (positivo, neutral,
negativo) y la lista de noticias enriquecidas con la etiqueta de sentimiento.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia7.png", width: 100%),
  caption: [Diagrama de secuencia para obtener noticias financieras.],
) <fig:seq_noticias_img>

=== Diagrama de secuencia: Editar perfil de un usuario

El usuario puede modificar su nombre, email o contraseña desde la página de
perfil. El backend requiere que se proporcione la contraseña actual para cambiar
la contraseña. Además, si se desea modificar el email, se verifica que el nuevo
email no esté ya registrado por otro usuario. Tras las validaciones
correspondientes, se actualizan los campos en la tabla `usuario` y se confirma
la operación.

#figure(
  image("../Figures/Template/Chapter3/diagrama_secuencia8.png", width: 100%),
  caption: [Diagrama de secuencia para editar el perfil de un usuario.],
) <fig:seq_perfil_img>

Estos diagramas permiten visualizar de forma clara la interacción entre los
componentes del sistema, sirviendo como base para la implementación detallada
que se presenta en capítulos posteriores.


== Conclusiones

El análisis de stakeholders, las historias de usuario y los diagramas de
secuencia sientan las bases para el diseño detallado. En el siguiente capítulo
se presentan la planificación temporal, el diseño de la base de datos, la
arquitectura del software y la interfaz de usuario.
