= Apéndices

== A. Manual de usuario

Este manual describe las principales funcionalidades de #emph[FinancialPulse] desde la perspectiva del usuario final. Se asume que el usuario tiene conocimientos básicos de navegación web.

=== A.1. Requisitos previos

- Navegador web actualizado (Chrome, Firefox, Edge).
- Conexión a Internet para obtener datos en tiempo real.
- (Opcional) Si se despliega localmente, Docker y Docker Compose.

=== A.2. Registro e inicio de sesión

1. Acceder a la página principal.
2. Hacer clic en "Registrarse" y completar el formulario (nombre, email, contraseña).
3. Una vez registrado, iniciar sesión con las credenciales.
4. Tras el inicio de sesión, se crea automáticamente una cartera virtual con 10.000 USD de saldo inicial.

> [FIGURA: Pantalla de inicio de sesión. La imagen debe mostrar el formulario con campos de email y contraseña, y el botón "Iniciar sesión".] <fig:manual_login>

> [FIGURA: Pantalla de registro. Debe verse el formulario con nombre, email, contraseña y botón "Registrarse".] <fig:manual_registro>

=== A.3. Página principal (Home)

- Muestra un resumen de índices (S&P 500, IBEX 35, etc.) y su variación diaria.
- Sección de noticias financieras destacadas (sin análisis de sentimiento, solo titulares).
- Si el usuario ha iniciado sesión, aparece el resumen de la cartera (saldo, beneficio, última transacción) y un acceso directo a la cartera virtual.

> [FIGURA: Página principal con resumen de índices y noticias.] <fig:manual_home>

=== A.4. Búsqueda y análisis de activos

- En el buscador central, escribir el nombre o símbolo de un activo (ej. "Apple", "AAPL", "Bitcoin", "EUR/USD").
- Se mostrarán sugerencias automáticas; seleccionar una para acceder al dashboard.
- El dashboard incluye:
  - Gráfico histórico (velas o líneas) con selector de período (1 semana, 1 mes, 3 meses, 1 año, 5 años, máximo).
  - Pestañas para indicadores técnicos (RSI, MACD, SMA, Bollinger, estocástico) con sus respectivos gráficos.
  - Botón "Backtesting SMA" que ejecuta la estrategia de cruce de medias móviles 20/50 y muestra el rendimiento.
  - Sección "Predicción Prophet" con gráfico de precios proyectados a 30 días e indicador MAPE.
  - Sección "Análisis de sentimiento" donde se pueden buscar noticias relacionadas con el activo y se muestra el porcentaje de positivas/negativas/neutrales.
  - Botones "Comprar" y "Vender" (solo si el usuario ha iniciado sesión) que abren un modal para introducir cantidad.

> [FIGURA: Dashboard de un activo (AAPL) mostrando gráfico de velas y pestaña de indicadores.] <fig:manual_dashboard>

=== A.5. Cartera virtual

- Accesible desde el menú superior (icono de cartera o "Cartera").
- Muestra:
  - Tarjeta con saldo actual, total depositado/retirado y beneficio no realizado.
  - Gráfico de evolución del balance a lo largo del tiempo.
  - Lista de transacciones (compra/venta) con fecha, símbolo, cantidad, precio y total.
  - Botón "Depositar" y "Retirar" para añadir/quitar dinero virtual (útil para pruebas).
  - Gráfico de tarta con la composición de la cartera (porcentaje de cada activo).

> [FIGURA: Página de cartera virtual con tarjeta de resumen y gráfico de evolución.] <fig:manual_cartera>

=== A.6. Favoritos

- En cualquier dashboard, se puede marcar/desmarcar una estrella para añadir/quitar el activo de favoritos.
- Todos los favoritos se listan en la página "Favoritos", mostrando precio actual, cambio diario y enlace al dashboard.

> [FIGURA: Página de favoritos con lista de activos.] <fig:manual_favoritos>

=== A.7. Noticias y análisis de sentimiento

- En la página "Noticias", se puede escribir una palabra clave (ej. "tecnología", "bitcoin") y obtener noticias recientes.
- Cada noticia se muestra con su título, fuente, fecha y un icono indicando el sentimiento (positivo, neutral, negativo) basado en el análisis de FinBERT o el modelo español.
- Un gráfico circular resume el porcentaje de noticias por sentimiento.

> [FIGURA: Página de noticias con búsqueda y gráfico de sentimiento.] <fig:manual_noticias>

=== A.8. Configuración del perfil y RGPD

- En el menú de usuario, seleccionar "Perfil".
- Se pueden editar los datos personales (nombre, email) y cambiar la contraseña.
- Botón "Exportar mis datos": descarga un archivo JSON con toda la información del usuario (transacciones, favoritos, perfil).
- Botón "Eliminar mi cuenta": tras confirmar, borra permanentemente todos los datos asociados.

> [FIGURA: Página de perfil con opciones de exportación y eliminación de cuenta.] <fig:manual_perfil>

=== A.9. Ayuda

- Desde el menú "Ayuda" se accede a tres páginas estáticas: "Análisis", "Cartera" y "Noticias", que explican el funcionamiento de cada sección y algunos conceptos financieros básicos.

== B. Vista del sitio web (Back-end)

Aunque #emph[FinancialPulse] no tiene un panel de administración específico, el backend expone una API REST que puede ser consultada con herramientas como Postman. Los administradores pueden acceder directamente a la base de datos (PostgreSQL) para gestionar usuarios o transacciones si fuera necesario.

> [FIGURA: Captura de Postman mostrando una petición GET a `/api/historical/AAPL`.] <fig:backend_api>

El código fuente del backend está disponible en el repositorio de GitHub. Las principales rutas de la API son:

- `POST /api/register` - registro de usuario.
- `POST /api/login` - inicio de sesión.
- `GET /api/logout` - cierre de sesión.
- `GET /api/historical/<symbol>` - datos históricos (parametrizable por período).
- `GET /api/indicators/<symbol>` - indicadores técnicos.
- `GET /api/prediction/<symbol>` - predicción Prophet.
- `POST /api/buy` - comprar acciones (requiere autenticación).
- `POST /api/sell` - vender acciones (requiere autenticación).
- `GET /api/portfolio` - obtener cartera del usuario.
- `GET /api/favorites` - obtener favoritos del usuario.
- `POST /api/favorites` - añadir/quitar favorito.
- `GET /api/news?q=<query>` - noticias con análisis de sentimiento.
- `GET /api/export-data` - exportar datos personales (RGPD).
- `DELETE /api/delete-account` - eliminar cuenta.

== C. Tableros Scrum con Jira Software

El desarrollo se gestionó mediante Jira, utilizando tableros Kanban para cada sprint. A continuación se muestran capturas de los tableros de los 5 sprints definidos.

> [FIGURA: Tablero del Sprint 1 (configuración inicial y autenticación).] <fig:jira_sprint1>
> [FIGURA: Tablero del Sprint 2 (integración con Yahoo Finance y gráficos).] <fig:jira_sprint2>
> [FIGURA: Tablero del Sprint 3 (indicadores, predicción y sentimiento).] <fig:jira_sprint3>
> [FIGURA: Tablero del Sprint 4 (cartera virtual y backtesting).] <fig:jira_sprint4>
> [FIGURA: Tablero del Sprint 5 (internacionalización, RGPD, pruebas y documentación).] <fig:jira_sprint5>

== D. Manual técnico de despliegue

=== D.1. Requisitos

- Tener instalado Docker y Docker Compose.
- (Opcional) Git para clonar el repositorio.

=== D.2. Clonar el repositorio

```bash
git clone https://github.com/tu_usuario/FinancialPulse.git
cd FinancialPulse```

=== D.3. Configuración de variables de entorno

Crear un archivo `.env` en la raíz del proyecto (junto al `docker-compose.yml`) con el siguiente contenido:

#figure(
  ```env
  NEWS_API_KEY=tu_clave_de_newsapi
  FLASK_SECRET_KEY=clave_secreta_aleatoria
  ```,
  caption: [Archivo `.env` de ejemplo.],
) <code:env>

- #strong[NEWS_API_KEY]: Obligatoria para el módulo de noticias. Se obtiene registrándose en https://newsapi.org.
- #strong[FLASK_SECRET_KEY]: Clave secreta para las sesiones de Flask. Puede ser cualquier cadena aleatoria (ej. generada con `openssl rand -hex 32`).

Si no se proporciona `NEWS_API_KEY`, el módulo de noticias devolverá un error controlado (el resto de la aplicación funcionará).

=== D.4. Construir y ejecutar con Docker Compose

Asegúrate de estar en la carpeta raíz del proyecto (donde está el `docker-compose.yml`) y ejecuta:

#figure(
  ```bash
  docker-compose up --build
  ```,
  caption: [Comando para construir y levantar los contenedores.],
) <code:docker_build>

Este comando:
- Construye las imágenes de los tres servicios (`db`, `backend`, `frontend`).
- Levanta los contenedores y muestra los logs en la terminal.
- El frontend estará accesible en `http://localhost:4200`.
- El backend expone su API en `http://localhost:5000`.

Para ejecutar en segundo plano (modo detach):

#figure(
  ```bash
  docker-compose up --build -d
  ```,
  caption: [Comando para levantar los contenedores en segundo plano.],
) <code:docker_up_detach>

=== D.5. Detener los contenedores

Para detener los contenedores sin eliminar los datos (la base de datos persistirá):

#figure(
  ```bash
  docker-compose down
  ```,
  caption: [Detener contenedores.],
) <code:docker_down>

Para detener los contenedores y eliminar también los volúmenes (borrará todos los datos de la base de datos):

#figure(
  ```bash
  docker-compose down -v
  ```,
  caption: [Detener contenedores y eliminar volúmenes.],
) <code:docker_down_volumes>

== E. Código fuente

El código fuente completo del proyecto está disponible en el siguiente repositorio de GitHub:

#figure(
  ```bash
  https://github.com/tu_usuario/FinancialPulse
  ```,
  caption: [Repositorio del proyecto.],
) <code:github>

El repositorio contiene las siguientes carpetas principales:

- #strong[`frontend/`]: Aplicación Angular (código TypeScript, componentes, servicios, estilos).
- #strong[`backend/`]: Aplicación Flask (Python, rutas, modelos SQLAlchemy, módulos de predicción y sentimiento).
- #strong[`docker-compose.yml`]: Orquestación de contenedores para desarrollo y producción.
- #strong[`doc/`]: Código fuente de esta memoria en Typst.

Para clonar el repositorio y trabajar en local:

#figure(
  ```bash
  git clone https://github.com/tu_usuario/FinancialPulse.git
  cd FinancialPulse
  ```,
  caption: [Clonación del repositorio.],
) <code:git_clone>

Toda la implementación se ha realizado siguiendo buenas prácticas de desarrollo (código limpio, comentarios en inglés y español, commits semánticos). Se ha utilizado Git Flow como modelo de ramificación.

== F. Enlaces de interés

- #strong[Repositorio de código]: `https://github.com/tu_usuario/FinancialPulse`
- #strong[Sitio web desplegado (si aplica)]: `https://financialpulse.example.com`
- #strong[Video explicativo]: `https://youtu.be/XXXXXXXXXXX`

> El video muestra un recorrido por las principales funcionalidades de la aplicación: registro de usuario, búsqueda de activos, visualización de gráficos e indicadores técnicos, predicción de precios con Prophet, análisis de sentimiento de noticias, compra/venta en la cartera virtual, exportación de datos personales (RGPD) y cambio de idioma.

- #strong[Documentación de APIs utilizadas]:
  - Yahoo Finance (yfinance): https://pypi.org/project/yfinance/
  - NewsAPI: https://newsapi.org/
- #strong[Herramientas de desarrollo]:
  - Angular: https://angular.dev/
  - Flask: https://flask.palletsprojects.com/
  - Docker: https://www.docker.com/
  - Typst (para la memoria): https://typst.app/

Toda la documentación adicional (diagramas de Gantt, capturas de pantalla, archivos de configuración, etc.) se encuentra en la carpeta `doc/figures/` del repositorio o se puede solicitar al autor.