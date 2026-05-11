= Herramientas y datos

En este capítulo se describen las principales herramientas de software
utilizadas para el desarrollo de _FinancialPulse_, así como las fuentes de datos
empleadas (APIs externas). El objetivo es documentar el stack tecnológico y
justificar las elecciones realizadas.

== Entorno de desarrollo

El proyecto se ha desarrollado utilizando las siguientes herramientas:

- *Sistema operativo*: Windows 11 (con WSL2) y Ubuntu 22.04 para el despliegue.
- *Editor de código*: Visual Studio Code con extensiones para Angular, Python,
  Tailwind CSS y Docker.
- *Control de versiones*: Git, con repositorio remoto en GitHub.
- *Gestión de proyectos*: Jira para el seguimiento de Scrum (tableros, sprints,
  historias de usuario) y Canva para diagramas de Gantt iniciales.
- *Contenedores*: Docker y Docker Compose para el despliegue de la aplicación
  completa (frontend, backend y base de datos).

=== Control de versiones y automatización

El repositorio se aloja en GitHub y se ha configurado un flujo de trabajo básico
con *GitHub Actions* para ejecutar pruebas unitarias automáticamente en cada
`push` a la rama principal. Esto permite detectar errores de forma temprana y
mantener la calidad del código. Los workflows se describen con mayor detalle en
el capítulo de pruebas.

== Frontend

El frontend de _FinancialPulse_ se ha desarrollado con las siguientes
tecnologías:

#figure(
  table(
    columns: (1.5fr, 2.5fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Herramienta*], [*Descripción*],
    [Angular 21],
    [Framework principal para construir la SPA. Se han usado componentes
      standalone, servicios, inyección de dependencias y enrutador.],

    [TypeScript],
    [Lenguaje tipado que mejora la mantenibilidad y robustez del código.],

    [Tailwind CSS],
    [Framework de utilidades CSS para estilizar la interfaz de forma rápida,
      consistente y responsive.],

    [ngx-echarts],
    [Librería de visualización de datos basada en ECharts, utilizada para
      generar gráficos de líneas, velas, área y circulares (tarta).],

    [RxJS],
    [Para manejo de programación reactiva (Observables) en las peticiones HTTP y
      eventos.],

    [Angular CLI],
    [Para generar componentes, servicios y gestionar la compilación.],
  ),
  caption: [Herramientas del frontend.],
) <tabla:frontend>

=== Justificación de la elección del framework

Aunque existen otras alternativas populares como React o Vue, se optó por
*Angular* por las siguientes razones:

- *Estructura completa*: Angular proporciona un ecosistema integrado (enrutador,
  cliente HTTP, formularios reactivos, inyección de dependencias) que reduce la
  necesidad de librerías de terceros.
- *TypeScript nativo*: Al estar escrito en TypeScript, la integración es
  perfecta y favorece un código más robusto y mantenible.
- *Escalabilidad*: Su arquitectura basada en módulos y componentes facilita la
  organización de un proyecto con múltiples funcionalidades como el que nos
  ocupa.
- *Curva de aprendizaje asumible*: Si bien Angular tiene una curva más
  pronunciada que React, el desarrollador ya contaba con experiencia previa en
  el framework.

La siguiente tabla resume una comparativa con las alternativas más comunes:

#figure(
  table(
    columns: (1.5fr, 2.5fr, 2.5fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Característica*], [*Angular*], [*React / Vue*],
    [Ecosistema integrado],
    [Sí (router, HTTP, forms)],
    [Requiere librerías externas],

    [Lenguaje], [TypeScript], [JavaScript/TypeScript (opcional)],
    [Curva de aprendizaje], [Moderada-alta], [Baja (React) o moderada (Vue)],
    [Rendimiento], [Muy bueno], [Excelente],
    [Mantenibilidad a largo plazo], [Alta (patrón MVC)], [Variable],
  ),
  caption: [Comparativa de frameworks de frontend.],
) <tabla:comparativa_frontend>

Además, se han creado elementos personalizados:
- *TranslatePipe*: pipe de Angular que permite la internacionalización (i18n)
  mediante diccionarios embebidos (español/inglés). Detecta el idioma guardado
  en `localStorage` y traduce las claves.
- *TooltipDirective*: directiva que muestra tooltips informativos al hacer hover
  sobre elementos como indicadores técnicos, gráficos o botones. Los tooltips se
  traducen automáticamente.
- *Servicios*: varios servicios (`AuthService`, `AssetService`,
  `PortfolioService`, `NewsService`, etc.) para encapsular la comunicación con
  el backend.

== Backend

El backend se ha implementado con las siguientes tecnologías:

#figure(
  table(
    columns: (1.5fr, 2.5fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Herramienta*], [*Descripción*],
    [Flask],
    [Microframework de Python para construir la API REST. Se eligió por su
      simplicidad y flexibilidad.],

    [Flask-CORS], [Permite peticiones desde el frontend en desarrollo.],
    [Flask-Login], [Manejo de sesiones de usuario.],
    [SQLAlchemy], [ORM para la interacción con PostgreSQL.],
    [Psycopg2], [Adaptador de PostgreSQL para Python.],
    [yfinance],
    [Librería para obtener datos financieros (históricos y en tiempo real) de
      Yahoo Finance.],

    [Transformers (Hugging Face)],
    [Para cargar los modelos de análisis de sentimiento (FinBERT y
      `bardsai/finance-sentiment-es-base`).],

    [Torch], [Backend para ejecutar los modelos de transformers.],
    [Prophet],
    [Modelo de predicción de series temporales (Facebook). Se usó la versión de
      Python.],

    [NumPy y Pandas],
    [Para el procesamiento de datos históricos y cálculos de indicadores.],

    [Backtesting manual],
    [Implementación propia de la estrategia de cruce de medias móviles SMA
      20/50.],

    [Flask-Mail],
    [Opcional, para el envío de correos de recuperación de contraseña
      (estructura preparada).],
  ),
  caption: [Herramientas del backend.],
) <tabla:backend>

=== Justificación de la elección del framework web

Para el backend se barajaron varias alternativas. Finalmente se eligió *Flask*
por su ligereza, flexibilidad y la facilidad para integrar bibliotecas de
ciencia de datos como `pandas`, `numpy`, `prophet` y `transformers`. A
continuación se compara con otras opciones populares:

#figure(
  table(
    columns: (1.5fr, 2.5fr, 2.5fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Característica*], [*Flask*], [*Django*],
    [*Node.js + Express*], [Curva de aprendizaje], [Baja],
    [Moderada], [Media], [Integración con IA/Data Science],
    [Excelente (Python nativo)], [Buena], [Limitada],
    [Estructura impuesta], [Mínima (microframework)], [Alta (full-stack)],
    [Mínima], [Rendimiento], [Bueno],
    [Bueno], [Muy bueno], [Madurez / Comunidad],
    [Muy alta], [Muy alta], [Muy alta],
  ),
  caption: [Comparativa de frameworks de backend.],
) <tabla:comparativa_backend>

La posibilidad de usar Python tanto para la lógica de negocio como para los
modelos de ML fue determinante, ya que evita la necesidad de un servicio
adicional en otro lenguaje. Flask, al ser minimalista, permite añadir solo las
extensiones necesarias (SQLAlchemy, Flask-Login, etc.) y mantener el código
despejado.

== Base de datos

La base de datos elegida es *PostgreSQL 15*. Se ha utilizado en local (durante
el desarrollo) y también se puede desplegar con Docker. PostgreSQL es robusto,
de código abierto y cumple con los estándares SQL.

El esquema se ha definido mediante migraciones de SQLAlchemy (no se usó Alembic,
se crearon las tablas manualmente con los modelos). Las tablas principales son:
`usuario`, `cartera`, `transaccion`, `favorito` y `reset_token`. El diagrama
entidad-relación se mostró en el capítulo anterior.

== APIs externas

_FinancialPulse_ se apoya en dos APIs externas para obtener los datos
financieros y las noticias.

#figure(
  table(
    columns: (1.2fr, 1.5fr, 2fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*API*], [*Uso*], [*Limitaciones*],
    [Yahoo Finance (yfinance)],
    [Datos históricos y en tiempo real de #linebreak() acciones, criptomonedas,
      índices, divisas. Fundamental básica.],
    [Sin clave de API, pero con #linebreak() limitaciones de tasa (se ha
      manejado con caché).],

    [NewsAPI],
    [Obtención de noticias financieras en tiempo real.],
    [Requiere API key gratuita (100 solicitudes/día).],
  ),
  caption: [APIs externas utilizadas.],
) <tabla:apis>

No se han utilizado datasets estáticos; todos los datos son dinámicos y se
obtienen bajo demanda.

== Herramientas de pruebas

Para garantizar la calidad del software se han empleado las siguientes
herramientas:

- *Frontend*: Karma y Jasmine para pruebas unitarias de componentes y servicios.
  Se han implementado pruebas básicas de los servicios principales y de algunos
  componentes críticos (por ejemplo, el pipe de traducción y la directiva de
  tooltip). Aunque la cobertura no es completa, se ha procurado validar los
  flujos más importantes.
- *Backend*: `pytest` para pruebas unitarias de modelos y rutas principales
  (registro, login, consulta de cartera). También se ha utilizado `pytest-cov`
  para medir la cobertura, alcanzando aproximadamente un 70% en los módulos
  críticos.
- *Postman*: para pruebas manuales de la API durante el desarrollo y para
  generar documentación básica de los endpoints.
- *Integración continua*: GitHub Actions ejecuta automáticamente las pruebas del
  backend y frontend en cada `push` a la rama principal, como se mencionó
  anteriormente.

El plan de pruebas se detalla con mayor profundidad en el capítulo 8.

== Despliegue

Para facilitar el despliegue, se ha creado un archivo *docker-compose.yml* que
levanta tres servicios:

- *db*: contenedor con PostgreSQL.
- *backend*: contenedor con Flask (código montado en volumen).
- *frontend*: contenedor con Angular (construido con `ng serve` en desarrollo, o
  con servidor estático para producción).

La comunicación entre contenedores se realiza a través de una red interna de
Docker. El frontend accede al backend mediante la URL `http://backend:5000`
(aunque en desarrollo local se usa proxy de Angular).

=== Dockerfile del backend

El backend se ejecuta sobre una imagen base de Python 3.10-slim. Se instalan las
dependencias necesarias (incluyendo `gfortran` y `build-essential` para compilar
algunas librerías como TA-Lib, aunque finalmente no se usó) y se copia el código
fuente. El puerto 5000 queda expuesto.

#figure(
  ```dockerfile
  FROM python:3.10-slim

  WORKDIR /app

  RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
      gfortran \
      && rm -rf /var/lib/apt/lists/*

  COPY requirements.txt .
  RUN pip install --no-cache-dir -r requirements.txt

  COPY . .

  EXPOSE 5000

  CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
  ```,
  caption: [Dockerfile para el backend de FinancialPulse.],
) <code:dockerfile>

=== Archivo docker-compose.yml

El orquestador define tres servicios: `db` (PostgreSQL 13 con variables de
entorno y un healthcheck para asegurar que la base de datos está lista antes de
iniciar el backend), `backend` (construido a partir del Dockerfile anterior, con
el código montado en volumen para desarrollo) y `frontend` (construido a partir
de su propio Dockerfile, sirviendo la aplicación Angular en el puerto 80). Los
datos de la base de datos se persisten en un volumen llamado `pgdata`.

#figure(
  ```yaml
  services:
    db:
      image: postgres:13
      environment:
        POSTGRES_USER: postgres
        POSTGRES_PASSWORD: XXXXXXXXXXXX
        POSTGRES_DB: financial_pulse_db
      ports:
        - "5432:5432"
      volumes:
        - pgdata:/var/lib/postgresql/data
      healthcheck:
        test: ["CMD-SHELL", "pg_isready -U postgres -d financial_pulse_db"]
        interval: 5s
        timeout: 5s
        retries: 5

    backend:
      build: ./backend
      ports:
        - "5000:5000"
      environment:
        - FLASK_APP=app.py
        - FLASK_ENV=development
        - SECRET_KEY=tu_clave_secreta_aqui
        - DATABASE_URL=postgresql://postgres:Flflfv17%@db:5432/financial_pulse_db
      volumes:
        - ./backend:/app
      depends_on:
        db:
          condition: service_healthy

    frontend:
      build: ./frontend
      ports:
        - "80:80"
      depends_on:
        - backend

  volumes:
    pgdata:
  ```,
  caption: [Archivo docker-compose.yml para levantar toda la aplicación.],
) <code:dockercompose>

=== Puesta en marcha

Para desplegar la aplicación completa, el usuario debe ejecutar el siguiente
comando en el directorio raíz del proyecto (donde se encuentra el archivo
`docker-compose.yml`):
`docker-compose up --build`
en el directorio raíz. Esto levantará la base de datos, el backend y el frontend
en contenedores aislados pero conectados. El frontend estará accesible en
http://localhost, el backend en http://localhost:5000 y la base de datos en el
puerto 5432. Los volúmenes garantizan que los datos de PostgreSQL persistan
incluso después de detener los contenedores.

En el apéndice se incluye un manual de despliegue detallado.

== Conclusión

Las herramientas seleccionadas han permitido cubrir todos los requisitos del
proyecto de forma satisfactoria. La combinación de Angular y Flask proporciona
un desarrollo ágil y una separación clara de responsabilidades. El uso de
yfinance y NewsAPI como fuentes de datos externas ha resultado adecuado para un
proyecto académico, aunque con limitaciones de tasa. Los modelos de Transformers
y Prophet aportan valor añadido al análisis financiero. En el siguiente capítulo
se detalla el software desarrollado, describiendo cada módulo funcional.
