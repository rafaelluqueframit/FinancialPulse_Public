= Estado del arte

En este capítulo se analizan las principales plataformas y aplicaciones
existentes en el ámbito del análisis financiero bursátil, tanto gratuitas como
de pago, y se comparan sus funcionalidades con las que ofrece _FinancialPulse_.
El objetivo es identificar las carencias de las soluciones actuales y justificar
la necesidad de una herramienta como la desarrollada en este Trabajo Fin de
Grado.

== Aplicaciones similares

A continuación se describen brevemente las plataformas más representativas del
sector, destacando sus características principales, sus puntos fuertes y sus
limitaciones.

=== Yahoo Finance

Yahoo Finance es uno de los portales financieros más antiguos y populares.
Proporciona datos en tiempo real de acciones, índices, divisas y criptomonedas,
así como noticias financieras, gráficos históricos básicos y algunos indicadores
técnicos (medias móviles, RSI, etc.). Está disponible de forma gratuita, aunque
cuenta con una versión de pago (Yahoo Finance Premium) que ofrece análisis más
avanzados.

#strong[Similitudes con FinancialPulse]: Ambas permiten consultar datos en
tiempo real de una amplia variedad de activos y visualizar gráficos históricos.

#strong[Carencias]: No ofrece un sistema de cartera virtual para simular
inversiones, carece de análisis de sentimiento de noticias integrado, su
predicción de precios es muy limitada (no utiliza modelos de machine learning) y
no permite la gestión de favoritos ni la internacionalización completa.

=== Investing.com

Investing.com es otra de las referencias mundiales en información financiera.
Destaca por su amplia cobertura de activos, sus gráficos interactivos avanzados
(con decenas de indicadores técnicos) y su sección de noticias y calendario
económico. Ofrece una versión gratuita con publicidad y una versión de pago
(Pro) con herramientas adicionales.

#strong[Similitudes con FinancialPulse]: Proporciona datos en tiempo real, una
amplia variedad de indicadores técnicos y noticias financieras.

#strong[Carencias]: No incluye una cartera de simulación gratuita (la función de
cartera es solo de seguimiento, no permite compras virtuales), no realiza
análisis de sentimiento de las noticias, las predicciones son básicas (basadas
en encuestas de analistas) y su interfaz es abrumadora para usuarios noveles.

=== TradingView

TradingView es una plataforma de gráficos y análisis técnico muy popular entre
traders. Su punto fuerte es la personalización de gráficos y la gran comunidad
que comparte estrategias y scripts (Pine Script). Ofrece una versión gratuita
limitada y varios planes de pago.

#strong[Similitudes con FinancialPulse]: Ofrece indicadores técnicos avanzados y
permite realizar backtesting de estrategias (aunque con limitaciones en la
versión gratuita).

#strong[Carencias]: No dispone de una cartera de simulación completa (solo
permite watchlists), carece de análisis de sentimiento de noticias, las
predicciones automáticas no están integradas, su uso es complejo para no
expertos y la versión gratuita está muy restringida.

=== Bloomberg Terminal

Bloomberg Terminal es el estándar de oro en el mundo financiero profesional.
Proporciona datos en tiempo real, análisis fundamental y técnico, noticias,
mensajería privada y un sinfín de herramientas. Su principal inconveniente es su
elevadísimo coste (miles de euros al mes), que lo hace inaccesible para
particulares o estudiantes.

#strong[Similitudes con FinancialPulse]: Ofrece análisis técnico y datos en
tiempo real.

#strong[Carencias]: Es extremadamente cara, no permite simulación con dinero
virtual (está orientada a inversores reales), su interfaz es muy compleja y no
está adaptada para aprendizaje, y no incluye análisis de sentimiento de noticias
con IA.

=== eToro

eToro es una plataforma de trading social que permite invertir en acciones,
criptomonedas y otros activos. Destaca por su funcionalidad de copia de
operadores exitosos y por ofrecer una cuenta de demostración (virtual) con
100.000 USD ficticios. Está regulada y permite invertir con dinero real, pero no
ofrece análisis técnico avanzado ni predicciones.

#strong[Similitudes con FinancialPulse]: Incluye una cartera virtual para
practicar sin riesgo.

#strong[Carencias]: No proporciona indicadores técnicos detallados, carece de
análisis de sentimiento de noticias, no permite exportar datos personales (RGPD)
y su interfaz está orientada principalmente al trading social, no al análisis.

=== Robinhood

Robinhood es una aplicación de inversión sin comisiones muy popular en Estados
Unidos. Permite comprar y vender acciones, ETFs y criptomonedas con una interfaz
muy sencilla y atractiva. Sin embargo, su disponibilidad geográfica es limitada
(principalmente EE. UU.) y carece de herramientas de análisis técnico avanzado.

#strong[Similitudes con FinancialPulse]: Interfaz limpia y sencilla, operativa
fácil.

#strong[Carencias]: No ofrece simulación virtual con dinero ficticio (solo
dinero real), no tiene análisis técnico, ni predicciones, ni análisis de
sentimiento. Además, no cumple con el RGPD al no permitir la exportación de
datos.

== Resumen comparativo

A continuación se resumen las principales funcionalidades de las plataformas
analizadas, destacando las carencias que #emph[FinancialPulse] cubre.

#grid(
  columns: 2,
  gutter: 1cm,
  [#strong[Funcionalidad / Plataforma]], [#strong[*FinancialPulse*]],
  [#strong[Datos en tiempo real]], [Sí],
  [#strong[Indicadores técnicos avanzados]],
  [RSI, MACD, SMA, Bollinger, estocástico, backtesting],

  [#strong[Predicción de precios]],
  [Prophet (30 días con intervalos de confianza)],

  [#strong[Análisis de sentimiento de noticias]],
  [FinBERT (inglés) + modelo español específico],

  [#strong[Cartera virtual]],
  [10.000 USD simulados, compra/venta, historial, gráficos],

  [#strong[Internacionalización completa]],
  [Español e inglés con tooltips traducidos],

  [#strong[Cumplimiento RGPD]],
  [Exportación de datos (JSON) y eliminación de cuenta],

  [#strong[Código abierto y gratuito]], [Sí, licencia MIT],
)

En cambio, las plataformas existentes presentan las siguientes limitaciones:

- #strong[Yahoo Finance, Investing.com, TradingView]: No tienen cartera virtual,
  análisis de sentimiento ni predicción automática.
- #strong[Bloomberg Terminal]: Es de pago y extremadamente cara, interfaz
  profesional muy compleja.
- #strong[eToro]: Ofrece demo pero sin indicadores técnicos avanzados ni
  sentimiento.
- #strong[Robinhood]: Solo disponible en EE. UU., sin herramientas de análisis.

Como se observa, #emph[FinancialPulse] es la única plataforma gratuita que
integra todas estas funcionalidades avanzadas en un solo lugar, con especial
énfasis en la educación financiera y la simulación sin riesgo.

== Conclusiones del estado del arte

Del análisis realizado se extraen las siguientes conclusiones:

+ #strong[Falta de integración]: Ninguna de las plataformas gratuitas analizadas
  integra en un solo lugar todas las funcionalidades que ofrece
  #emph[FinancialPulse].

+ #strong[Barrera económica]: Las herramientas más completas son de pago y
  resultan inaccesibles para estudiantes o pequeños inversores.

+ #strong[Complejidad de uso]: Plataformas como TradingView o Investing.com
  ofrecen una gran cantidad de datos, pero su interfaz resulta abrumadora para
  usuarios sin experiencia.

+ #strong[Falta de simulaciones sin riesgo]: La mayoría no incluye cartera
  virtual. Solo eToro lo hace, pero carece de análisis técnico y predicción.

+ #strong[Análisis de sentimiento ausente]: Ninguna de las plataformas
  analizadas incorpora análisis de sentimiento de noticias basado en modelos de
  lenguaje. Esta funcionalidad es novedosa y útil.

+ #strong[Incumplimiento del RGPD]: Muchas aplicaciones no permiten exportar
  datos personales ni eliminar la cuenta de forma completa.

+ #strong[Internacionalización limitada]: Aunque algunas plataformas están
  disponibles en varios idiomas, ninguna ofrece una traducción completa y
  dinámica con tooltips explicativos.

== Aportación de FinancialPulse

A la vista de las carencias identificadas, #emph[FinancialPulse] se posiciona
como una alternativa:

- #strong[Gratuita y de código abierto]: Todo el código fuente está disponible
  en GitHub bajo licencia MIT.
- #strong[Educativa y accesible]: Interfaz intuitiva, con ayuda integrada
  (tooltips, páginas de ayuda).
- #strong[Integral]: Reúne datos en tiempo real, indicadores técnicos,
  predicción de precios, análisis de sentimiento, cartera virtual, favoritos,
  noticias personalizables, internacionalización completa y cumplimiento RGPD.
- #strong[Desplegable fácilmente]: Mediante contenedores Docker.
- #strong[Con tecnologías de vanguardia]: Prophet, FinBERT y modelo en español
  para análisis de sentimiento.

En los siguientes capítulos se detalla la planificación, el diseño, la
implementación y la validación de esta solución.
