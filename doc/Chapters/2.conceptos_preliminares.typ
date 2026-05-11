= Conceptos preliminares

En este capítulo se introducen los conceptos financieros y técnicos fundamentales necesarios para comprender el desarrollo y el funcionamiento de la aplicación #emph[FinancialPulse]. El objetivo es proporcionar al lector una base sólida sobre los términos y tecnologías que se mencionarán en capítulos posteriores.

== Conceptos financieros básicos

=== Activos financieros

Un activo financiero es un instrumento que otorga a su propietario el derecho a recibir ingresos futuros o un valor económico. En el contexto de esta aplicación, se manejan principalmente cuatro tipos:

- #strong[Acciones (Stocks)]: Representan una fracción de la propiedad de una empresa. Su valor fluctúa según la oferta y la demanda en el mercado, así como por los resultados y perspectivas de la compañía.
- #strong[Criptomonedas (Cryptocurrencies)]: Monedas digitales descentralizadas que utilizan criptografía para asegurar las transacciones. Ejemplos notables son Bitcoin (BTC) y Ethereum (ETH). Su volatilidad es generalmente más alta que la de las acciones tradicionales.
- #strong[Índices bursátiles (Indices)]: Son medidas estadísticas que representan la evolución de un conjunto de acciones representativas de un mercado o sector (e.g., S&P 500, IBEX 35). No son directamente invertibles, pero sirven como referencia.
- #strong[Divisas (Currencies/Forex)]: Pares de monedas (e.g., EUR/USD) cuyo valor relativo fluctúa en el mercado de divisas, el más líquido del mundo.

=== Indicadores técnicos

El análisis técnico estudia los patrones de precios y volúmenes para predecir movimientos futuros. #emph[FinancialPulse] implementa los siguientes indicadores:

- #strong[Media Móvil Simple (SMA – Simple Moving Average)]: Calcula el precio promedio de un activo durante un número específico de períodos (e.g., 20 días). Suaviza la serie de precios para identificar tendencias. Un cruce de una SMA de corto plazo (20 períodos) sobre una de largo plazo (50 períodos) puede interpretarse como una señal de compra (cruce dorado), y viceversa como señal de venta (cruce de la muerte).
- #strong[RSI (Relative Strength Index)]: Oscilador que mide la magnitud de los cambios recientes de precios para evaluar condiciones de sobrecompra o sobreventa. Su rango típico es de 0 a 100. Valores superiores a 70 indican una posible sobrecompra (corrección a la baja), mientras que valores inferiores a 30 sugieren sobreventa (posible rebote al alza).
- #strong[MACD (Moving Average Convergence Divergence)]: Muestra la relación entre dos medias móviles (generalmente de 12 y 26 períodos). Se compone de una línea MACD, una línea de señal (SMA de 9 de la MACD) y un histograma. Las señales de compra o venta se generan cuando la línea MACD cruza la línea de señal.
- #strong[Bandas de Bollinger (Bollinger Bands)]: Consisten en una SMA central y dos bandas laterales calculadas como la SMA más/menos un número de desviaciones estándar (normalmente 2). Los precios tienden a mantenerse dentro de las bandas; cuando se tocan o rompen las bandas externas, puede indicar una continuación o reversión de la tendencia.
- #strong[Estocástico (Stochastic Oscillator)]: Compara el precio de cierre de un activo con su rango de precios durante un período determinado. Está formado por dos líneas (%K y %D). Valores por encima de 80 indican sobrecompra, por debajo de 20 sobreventa.
- #strong[Backtesting de estrategia SMA]: #emph[FinancialPulse] permite ejecutar un backtest simple de la estrategia de cruce de medias móviles (SMA 20/50) sobre datos históricos, mostrando el rendimiento que se habría obtenido (número de operaciones, ganancia/pérdida total). Esto ilustra al usuario el comportamiento potencial de una estrategia en el pasado.

// > #figure(
// >   image("Figures/Chapter2/ejemplo_indicadores.png", width: 80%),
// >   caption: [Ejemplo de gráfico de indicadores técnicos (RSI, MACD, Bandas de Bollinger) generado por FinancialPulse.],
// > ) <fig:indicadores>

== Conceptos técnicos y tecnológicos

=== Aplicaciones web de una sola página (SPA) y Angular

Una aplicación de una sola página (SPA – Single Page Application) es un tipo de aplicación web que carga una única página HTML y actualiza dinámicamente el contenido a medida que el usuario interactúa, sin necesidad de recargar la página completa. Esto proporciona una experiencia más fluida y similar a la de una aplicación de escritorio.

#strong[Angular] es un framework de código abierto mantenido por Google para construir SPAs. Utiliza TypeScript y sigue un patrón basado en componentes. Para este proyecto, se eligió Angular por su robustez, su sistema de inyección de dependencias, su enrutador, y por la facilidad para crear interfaces reactivas. Además, su estructura basada en módulos y componentes facilita la organización del código, especialmente al tener que implementar funcionalidades como la internacionalización y las directivas personalizadas.

=== APIs REST y comunicación cliente-servidor

REST (Representational State Transfer) es un estilo de arquitectura para diseñar servicios web. Las APIs RESTful se basan en el protocolo HTTP y utilizan métodos estándar (GET, POST, PUT, DELETE) para manipular recursos identificados por URLs. En #emph[FinancialPulse], el backend desarrollado en Flask expone una API REST que el frontend Angular consume mediante el módulo #emph[HttpClient]. Toda la comunicación se realiza en formato JSON.

=== Autenticación y gestión de sesiones

La aplicación utiliza un sistema de autenticación basado en sesiones gestionadas mediante cookies. Cuando el usuario inicia sesión correctamente, el backend crea una sesión (utilizando la librería #emph[flask_login]) y almacena el identificador del usuario. Las peticiones posteriores incluyen la cookie de sesión, que permite al servidor identificar al usuario autorizado. Para la recuperación de contraseña, se implementa un flujo con tokens numéricos de un solo uso, generados aleatoriamente y enviados al correo electrónico del usuario.

=== Modelos de aprendizaje automático para análisis de sentimiento

El análisis de sentimiento es una tarea de procesamiento de lenguaje natural (PLN) que consiste en determinar la polaridad (positiva, negativa, neutral) de un texto. En el ámbito financiero, el sentimiento de las noticias puede afectar los precios de los activos.

#strong[FinBERT] es un modelo de lenguaje preentrenado basado en la arquitectura BERT (Bidirectional Encoder Representations from Transformers), ajustado específicamente para el análisis de sentimiento financiero en inglés. Fue desarrollado por ProsusAI y ha demostrado un alto rendimiento en la clasificación de textos financieros.

Para el idioma español, la aplicación emplea el modelo #emph[bardsai/finance-sentiment-es-base], también basado en BERT, especializado en textos financieros en español. Ambos modelos se cargan utilizando la biblioteca #emph[transformers] de Hugging Face y se ejecutan en CPU o GPU según disponibilidad.

El proceso de análisis consiste en: (1) descargar noticias mediante la API de NewsAPI, (2) para cada noticia, determinar su idioma (inglés o español), (3) aplicar el modelo correspondiente para obtener una etiqueta de sentimiento y una puntuación de confianza, y (4) agregar los resultados (contajes, gráfico circular) para ofrecer un resumen al usuario.

=== Predicción de series temporales con Prophet

#strong[Prophet] es un modelo de predicción de series temporales desarrollado por Facebook (Meta) que se ha popularizado por su facilidad de uso y robustez ante datos atípicos y estacionalidades. Está implementado en Python. Prophet descompone la serie en tres componentes principales: tendencia, estacionalidad (anual, semanal, diaria) y días festivos. A diferencia de modelos como ARIMA, Prophet no requiere que la serie sea estacionaria ni que los datos estén completos (maneja bien valores faltantes).

En #emph[FinancialPulse], se utiliza Prophet para predecir el precio de cierre de un activo para los próximos 30 días, a partir de los datos históricos del último año. El modelo se ajusta automáticamente y la salida incluye la predicción puntual, los intervalos de confianza del 80% y del 95%, y además se calcula el error MAPE (Mean Absolute Percentage Error) sobre el período de validación para dar una métrica de precisión al usuario.

=== Bases de datos relacionales y SQLAlchemy

#strong[PostgreSQL] es un sistema gestor de bases de datos relacional de código abierto, conocido por su robustez, cumplimiento de estándares y extensibilidad. Para interactuar con la base de datos desde Python, se utiliza #strong[SQLAlchemy], un ORM (Object-Relational Mapper) que permite trabajar con objetos Python en lugar de escribir sentencias SQL directamente, lo que acelera el desarrollo y reduce errores.

El esquema de la base de datos de #emph[FinancialPulse] incluye las siguientes entidades: #emph[Usuario], #emph[Cartera], #emph[Transaccion], #emph[Favorito] y #emph[ResetToken]. Todas las relaciones se normalizan para evitar redundancias y garantizar la integridad referencial.

=== Contenedores Docker y despliegue

#strong[Docker] es una plataforma de virtualización a nivel de sistema operativo que permite empaquetar una aplicación y sus dependencias en un contenedor aislado. Esto facilita el despliegue consistente en diferentes entornos (desarrollo, pruebas, producción). El proyecto utiliza un archivo #emph[docker-compose.yml] que define tres servicios: la base de datos PostgreSQL, el backend Flask y el frontend Angular. De esta manera, cualquier desarrollador o evaluador puede levantar la aplicación completa con un solo comando (#emph[docker-compose up]), sin necesidad de instalar manualmente Python, Node.js, PostgreSQL, etc.

=== Internacionalización (i18n) y tooltips dinámicos

La internacionalización (i18n) es el proceso de diseñar una aplicación para que pueda adaptarse a diferentes idiomas y regiones sin cambios en el código fuente. En #emph[FinancialPulse], se implementó un #emph[TranslatePipe] personalizado que utiliza diccionarios embebidos (uno para inglés y otro para español). El pipe recibe una clave y devuelve la cadena traducida correspondiente al idioma seleccionado por el usuario, que se almacena en una variable de sesión (localStorage).

Además, se desarrolló una directiva #emph[TooltipDirective] que, al pasar el ratón sobre ciertos elementos (ej., nombre de un indicador técnico, ayuda de un gráfico), muestra un cuadro informativo. Los tooltips también están traducidos dinámicamente. La directiva calcula automáticamente la posición del tooltip para que no se salga de la pantalla.

=== Cumplimiento normativo (RGPD)

El Reglamento General de Protección de Datos (RGPD) de la Unión Europea establece obligaciones para las aplicaciones que tratan datos personales. #emph[FinancialPulse] implementa dos funcionalidades clave para cumplir con los derechos de los usuarios:
- #strong[Derecho de acceso y portabilidad]: El usuario puede exportar todos sus datos (perfil, transacciones, favoritos) en formato JSON mediante una llamada a la API.
- #strong[Derecho de supresión (derecho al olvido)]: El usuario puede eliminar su cuenta, lo que provoca el borrado en cascada de todos los registros asociados (cartera, transacciones, favoritos, tokens).