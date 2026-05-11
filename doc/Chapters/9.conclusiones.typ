= Conclusiones y trabajo futuro

En este último capítulo se resumen los logros del proyecto, se analiza el
cumplimiento de los objetivos, se extraen lecciones aprendidas y se proponen
líneas de mejora para versiones futuras de _FinancialPulse_.

== Cumplimiento de objetivos

El objetivo principal de este Trabajo Fin de Grado era diseñar e implementar una
plataforma web integral para el análisis financiero bursátil que permitiera a
los usuarios consultar datos en tiempo real, obtener recomendaciones basadas en
indicadores técnicos y análisis de sentimiento, y simular inversiones mediante
una cartera virtual sin riesgo.

A continuación se desglosa el estado de los objetivos específicos definidos en
el capítulo 1:

#figure(
  table(
    columns: (3.5fr, 1fr, 2fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Objetivo específico*], [*Estado*], [*Comentarios*],
    [OB-1: Sistema de autenticación y gestión de usuarios (RGPD)],
    [Completo],
    [Registro, login, recuperación, exportación JSON y eliminación de cuenta
      implementados.],

    [OB-2: Integración con Yahoo Finance],
    [Completo],
    [Datos en tiempo real e históricos de acciones, criptomonedas, índices y
      divisas.],

    [OB-3: Módulo de análisis técnico],
    [Completo],
    [RSI, MACD, SMA, Bollinger, estocástico y backtesting de cruce SMA.],

    [OB-4: Predicción de precios con Prophet],
    [Completo],
    [Predicción a 30 días con intervalos de confianza y MAPE.],

    [OB-5: Análisis de sentimiento de noticias],
    [Completo],
    [FinBERT para inglés y modelo específico para español.],

    [OB-6: Cartera virtual],
    [Completo],
    [Saldo inicial 10k USD, compra/venta, historial, gráfico de evolución,
      composición con gráfico de tarta.],

    [OB-7: Sistema de favoritos y noticias personalizadas],
    [Completo],
    [Marcar activos favoritos, resumen de sentimiento con gráfico circular.],

    [OB-8: Internacionalización completa],
    [Completo],
    [Español/inglés con pipe de traducción y tooltips dinámicos.],

    [OB-9: Despliegue con contenedores Docker],
    [Completo],
    [docker-compose.yml funcional para desarrollo y producción.],
  ),
  caption: [Estado de cumplimiento de los objetivos específicos.],
) <tabla:objetivos>

Por tanto, se puede concluir que #strong[todos los objetivos planificados se han
  alcanzado satisfactoriamente].

== Lecciones aprendidas

A lo largo del desarrollo del proyecto se han adquirido importantes
conocimientos tanto técnicos como de gestión:

- *Técnicos*: Uso avanzado de Angular (standalone components, pipes
  personalizados, directivas), integración con Flask, manejo de sesiones,
  consumo de APIs externas (yfinance, NewsAPI), implementación de modelos de
  machine learning (Prophet, Transformers) y despliegue con Docker.
- *Metodológicos*: Aplicación de Scrum adaptado a un solo desarrollador resultó
  eficaz para mantener el ritmo y priorizar tareas. La planificación con
  diagramas de Gantt ayudó a visualizar el progreso.
- *Dificultades encontradas*: La integración del modelo de sentimiento en
  español (bardsai/finance-sentiment-es-base) fue más lenta de lo esperado
  debido al tamaño del modelo y a la falta de aceleración GPU en el entorno de
  desarrollo. Se resolvió cacheando los resultados. También se detectó un
  problema de concurrencia en las compras rápidas, solucionado con bloqueo
  pesimista en la base de datos.
- *Importancia de la documentación*: Escribir la memoria en paralelo al
  desarrollo ha facilitado recordar decisiones y justificarlas adecuadamente.

== Trabajo futuro

A pesar de que la aplicación es funcional y cumple los objetivos, existen
numerosas líneas de mejora y ampliación:

- #strong[Mejora del modelo de predicción]: Integrar modelos más avanzados
  (LSTM, Transformer) o permitir al usuario seleccionar el horizonte de
  predicción.
- #strong[Ampliación del análisis de sentimiento]: Incluir análisis de
  sentimiento de redes sociales (Twitter, Reddit) y agregar fuentes de noticias
  adicionales (p.ej., RSS de bancos centrales).
- #strong[Más indicadores técnicos]: Añadir indicadores como ATR, Ichimoku,
  Fibonacci, etc., y permitir la personalización de parámetros.
- #strong[Modo oscuro]: Implementar un tema oscuro completo para mejorar la
  experiencia de usuario en condiciones de poca luz.
- #strong[Notificaciones push]: Configurar notificaciones en tiempo real cuando
  un activo favorito supere un umbral de precio o cuando haya noticias
  relevantes.
- #strong[Aplicación móvil]: Desarrollar una versión nativa para Android/iOS
  usando Ionic o Flutter, reutilizando el backend existente.
- #strong[Pruebas automáticas completas]: Ampliar la cobertura de pruebas
  unitarias (frontend y backend) e implementar pruebas end-to-end con Cypress o
  Playwright.
- #strong[Seguridad]: Añadir protección CSRF, rate limiting y un cortafuegos de
  aplicaciones web (WAF) si se despliega en producción.
- *Mejora del rendimiento*: Cachear respuestas de yfinance y Prophet para
  reducir tiempos de carga.
- *Foro de usuarios*: Incorporar un sistema de comentarios o foro para que los
  inversores compartan estrategias y dudas.

== Reflexión personal

La realización de este Trabajo Fin de Grado ha sido una experiencia muy
enriquecedora. Me ha permitido aplicar los conocimientos adquiridos durante el
Doble Grado en Ingeniería Informática y Administración de Empresas a un proyecto
real, combinando tecnologías web modernas, inteligencia artificial y finanzas.
El resultado es una herramienta educativa y útil que puede ayudar a personas sin
experiencia a iniciarse en el mundo de la inversión de forma segura y guiada.

Agradezco a mi tutor por su orientación y a mi familia por su apoyo
incondicional. Espero que #emph[FinancialPulse] continúe evolucionando y sea de
utilidad para la comunidad.
