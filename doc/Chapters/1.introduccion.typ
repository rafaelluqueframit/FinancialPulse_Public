= Introducción

== Contexto y motivación

El mundo de las finanzas y la inversión en bolsa ha sido tradicionalmente percibido como complejo y reservado a profesionales con amplios conocimientos. Sin embargo, en la última década, la democratización del acceso a la información financiera a través de Internet y la aparición de plataformas de inversión de bajo coste han despertado el interés de un número creciente de personas no especializadas. A pesar de ello, la mayoría de las herramientas disponibles en el mercado (Yahoo Finance, Investing.com, Bloomberg Terminal, etc.) presentan barreras significativas: o bien son de pago, o bien ofrecen una interfaz abrumadora para el usuario novel, o carecen de funcionalidades educativas como la simulación sin riesgo.

Esta situación afecta especialmente a estudiantes, pequeños inversores y personas que desean aprender a invertir sin arriesgar dinero real. Como señala el reconocido inversor George Soros: "El problema no es lo que uno no sabe, sino lo que uno cree que sabe estando equivocado" @soros. Por tanto, existe una necesidad clara de herramientas que no solo muestren datos, sino que también eduquen, expliquen y permitan experimentar de forma segura.

La tecnología actual, con frameworks modernos de desarrollo web (Angular, React), microframeworks de backend (Flask) y técnicas de inteligencia artificial (modelos de lenguaje para análisis de sentimiento, modelos de series temporales para predicción), permite construir aplicaciones completas, interactivas y accesibles. Este trabajo surge de la motivación personal por combinar los conocimientos adquiridos durante el Doble Grado en Ingeniería Informática y Administración y Dirección de Empresas, para desarrollar una plataforma que reduzca la brecha entre la teoría financiera y la práctica inversora.

== Objetivos del proyecto

El objetivo principal de FinancialPulse es #strong[diseñar e implementar una plataforma web integral que permita a los usuarios analizar activos financieros en tiempo real, obtener recomendaciones de inversión basadas en indicadores técnicos y análisis de sentimiento, y simular operaciones en un entorno virtual sin riesgo].

Para alcanzar este objetivo principal, se definen los siguientes objetivos específicos:

+ OB-1: Implementar un sistema de autenticación y gestión de usuarios (registro, inicio de sesión, recuperación de contraseña, perfil, exportación de datos y eliminación de cuenta) que cumpla con la normativa RGPD.
+ OB-2: Integrar la API de Yahoo Finance para obtener datos en tiempo real e históricos de acciones, criptomonedas, índices y divisas.
+ OB-3: Desarrollar un módulo de análisis técnico que calcule y visualice indicadores clave (RSI, MACD, SMA, Bandas de Bollinger, estocástico) y realice backtesting de estrategias sencillas (cruce de medias móviles).
+ OB-4: Incorporar un modelo de predicción de precios (Prophet) que genere proyecciones a 30 días con intervalos de confianza y métrica de precisión (MAPE).
+ OB-5: Implementar un análisis de sentimiento de noticias financieras utilizando modelos de lenguaje preentrenados (FinBERT para inglés y `bardsai/finance-sentiment-es-base` para español).
+ OB-6: Diseñar una cartera virtual que permita comprar/vender activos con saldo simulado, mostrar la evolución del balance mediante gráficos y calcular el rendimiento no realizado.
+ OB-7: Crear un sistema de favoritos y noticias personalizadas, con resumen de sentimiento y gráficos circulares.
+ OB-8: Asegurar la internacionalización completa de la aplicación (español/inglés) mediante un pipe de traducción personalizado y tooltips informativos.
+ OB-9: Desplegar la aplicación utilizando contenedores Docker para facilitar su replicabilidad y despliegue en entornos de producción.

== Estructura de la memoria

La presente memoria se estructura en los siguientes capítulos:

- #strong[Capítulo 2: Conceptos preliminares]. Se introducen los conceptos financieros (activos, indicadores técnicos) y tecnológicos (SPA, APIs REST, Prophet, Transformers, etc.) necesarios para entender el resto del trabajo.
- #strong[Capítulo 3: Definición del problema]. Se formaliza el problema que resuelve FinancialPulse y se presentan los requisitos de alto nivel.
- #strong[Capítulo 4: Estado del arte]. Se analizan las plataformas financieras existentes (Yahoo Finance, TradingView, Investing.com, etc.), comparando sus funcionalidades y limitaciones, y se justifica la aportación de este TFG.
- #strong[Capítulo 5: Planificación y diseño]. Se describe la metodología ágil (Scrum) adaptada a un solo desarrollador, se muestra el diagrama de Gantt (planificación temporal), el presupuesto, el análisis de requisitos (funcionales y no funcionales), los diagramas de casos de uso, el diseño de la base de datos (entidad-relación), la arquitectura del software (Angular + Flask + PostgreSQL) y los mockups de la interfaz.
- #strong[Capítulo 6: Herramientas y datos]. Se detallan las tecnologías empleadas (Angular, Tailwind, ngx-echarts, Flask, SQLAlchemy, yfinance, transformers, prophet, Docker, etc.) y las fuentes de datos (Yahoo Finance, NewsAPI).
- #strong[Capítulo 7: Software desarrollado]. Se explica cada módulo del sistema (autenticación, dashboard, predicción, sentimiento, cartera, favoritos, internacionalización, RGPD) sin incluir código extenso, pero destacando las decisiones de implementación.
- #strong[Capítulo 8: Evaluación y pruebas]. Se presentan el plan de pruebas (unitarias, integración, aceptación), los resultados obtenidos y una evaluación del cumplimiento de requisitos.
- #strong[Capítulo 9: Conclusiones y trabajo futuro]. Se resumen los logros, se analiza el cumplimiento de objetivos, se extraen lecciones aprendidas y se proponen líneas de mejora (modo oscuro, notificaciones push, aplicación móvil, etc.).
- #strong[Bibliografía]. Se listan las referencias en formato IEEE.
- #strong[Apéndices] (opcional). Se incluyen el manual de usuario, el manual técnico de despliegue con Docker, y fragmentos de código relevantes.
