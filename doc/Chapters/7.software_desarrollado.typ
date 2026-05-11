= Software desarrollado

En este capítulo se describe la implementación de los principales módulos de
_FinancialPulse_. No se incluye todo el código fuente (disponible en GitHub),
pero se explican los algoritmos y las decisiones más relevantes. La aplicación
se ha estructurado en capas (frontend Angular, backend Flask, base de datos
PostgreSQL) y los módulos se han desarrollado de forma incremental siguiendo la
metodología Scrum.

== Implementación de la base de datos

La capa de datos se ha implementado con *SQLAlchemy* como ORM sobre
*PostgreSQL*. Los modelos definen la estructura de las tablas y las relaciones.
A continuación se muestran los modelos principales extraídos del archivo
`app.py`:

#figure(
  ```python
  class Usuario(db.Model):
      __tablename__ = 'usuario'
      id = db.Column(db.Integer, primary_key=True)
      nombre = db.Column(db.String(100), nullable=False)
      email = db.Column(db.String(100), unique=True, nullable=False)
      password_hash = db.Column(db.String(200), nullable=False)
      fecha_registro = db.Column(db.DateTime, server_default=db.funct.now())

  class Cartera(db.Model):
      __tablename__ = 'cartera'
      id = db.Column(db.Integer, primary_key=True)
      usuario_id = db.Column(db.Integer, db.ForeignKey('usuario.id'), unique=True)
      saldo = db.Column(db.Float, default=10000.0)
      total_depositado = db.Column(db.Float, default=0.0)
      total_retirado = db.Column(db.Float, default=0.0)
      total_transacciones = db.Column(db.Integer, default=0)

  class Transaccion(db.Model):
      __tablename__ = 'transaccion'
      id = db.Column(db.Integer, primary_key=True)
      cartera_id = db.Column(db.Integer, db.ForeignKey('cartera.id'))
      accion_simbolo = db.Column(db.String(20), nullable=False)
      tipo = db.Column(db.String(10), nullable=False)  # 'compra' o 'venta'
      cantidad = db.Column(db.Integer, nullable=False)
      precio = db.Column(db.Float, nullable=False)
      fecha = db.Column(db.DateTime, default=datetime.utcnow)

  class Favorito(db.Model):
      __tablename__ = 'favorito'
      id = db.Column(db.Integer, primary_key=True)
      usuario_id = db.Column(db.Integer, db.ForeignKey('usuario.id'))
      simbolo = db.Column(db.String(20), nullable=False)
      creado_en = db.Column(db.DateTime, default=datetime.utcnow)
      __table_args__ = (db.UniqueConstraint('usuario_id', 'simbolo'),)

  class ResetToken(db.Model):
      __tablename__ = 'reset_token'
      id = db.Column(db.Integer, primary_key=True)
      usuario_id = db.Column(db.Integer, db.ForeignKey('usuario.id'))
      token = db.Column(db.String(6), nullable=False)
      created_at = db.Column(db.DateTime, default=datetime.utcnow)
  ```,
  caption: [Modelos SQLAlchemy para la base de datos.],
) <code:modelos>

La creación de las tablas se realiza automáticamente al iniciar la aplicación
mediante `db.create_all()`. No se ha utilizado Alembic por simplicidad, aunque
es una mejora posible para el futuro.

== API REST: Endpoints principales

El backend expone una API RESTful en el puerto 5000. A continuación se listan
los endpoints más relevantes:

#figure(
  table(
    columns: (1.8fr, 1.2fr, 2.5fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Endpoint*], [*Método*], [*Descripción*],
    [/api/register], [POST], [Registro de nuevo usuario y creación de cartera.],
    [/api/login], [POST], [Inicio de sesión, devuelve cookie de sesión.],
    [/api/me], [GET], [Obtener perfil del usuario autenticado.],
    [/api/actualizar-perfil], [PUT], [Actualizar nombre, email o contraseña.],
    [/api/forgot-password], [POST], [Solicitar código de recuperación.],
    [/api/reset-password], [POST], [Restablecer contraseña con código.],
    [/api/export-data], [GET], [Exportar datos personales (JSON).],
    [/api/delete-account], [DELETE], [Eliminar cuenta y datos en cascada.],
    [/api/search/<query>], [GET], [Búsqueda de activos por nombre o símbolo.],
    [/api/dashboard/<simbolo>],
    [GET],
    [Obtener histórico, predicción, noticias y sentimiento.],

    [/api/recommendation/<simbolo>],
    [GET],
    [Recomendación de compra/venta con indicadores.],

    [/api/prediccion/<simbolo>], [GET], [Predicción Prophet (30 días).],
    [/api/noticias], [GET], [Búsqueda de noticias con análisis de sentimiento.],
    [/api/cartera], [GET], [Obtener saldo y estadísticas de la cartera.],
    [/api/comprar], [POST], [Comprar acciones (cartera virtual).],
    [/api/vender], [POST], [Vender acciones (cartera virtual).],
    [/api/transacciones], [GET], [Listado de transacciones del usuario.],
    [/api/posicion], [GET], [Posición actual (acciones en cartera).],
    [/api/favoritos], [GET, POST, DELETE], [Gestionar lista de favoritos.],
    [/api/market-summary], [GET], [Resumen de índices (S&P500, IBEX35, etc.).],
  ),
  caption: [Endpoints de la API REST de FinancialPulse.],
) <tabla:endpoints>

Desde el frontend Angular, los servicios (por ejemplo `AuthService`) utilizan
`HttpClient` para realizar estas peticiones. A modo de ejemplo, el método de
login en el servicio sería:

#figure(
  ```typescript
  login(email: string, password: string): Observable<any> {
    return this.http.post(`${this.apiUrl}/login`, { email, password });
  }
  ```,
  caption: [Ejemplo de llamada a la API desde Angular.],
) <code:angular_api>

== Desarrollo por módulos

A continuación se detalla la implementación de cada módulo funcional, incluyendo
fragmentos de código reales extraídos del backend y explicaciones de los
algoritmos empleados.

=== Módulo de autenticación y gestión de usuarios

Este módulo permite el registro, inicio de sesión, cierre de sesión,
recuperación de contraseña, edición del perfil, exportación de datos (RGPD) y
eliminación de la cuenta. Se utiliza la extensión `flask_login` (aunque en el
código real se gestiona la sesión manualmente con `session['user_id']`) y
`werkzeug.security` para el hash de contraseñas.

==== Registro e inicio de sesión

El registro se realiza mediante una petición POST a `/api/register`. El endpoint
valida que el email no exista, aplica un hash a la contraseña y crea un nuevo
usuario junto con una cartera virtual con saldo inicial de 10.000 USD. El inicio
de sesión (`/api/login`) verifica las credenciales y almacena el `user_id` en la
sesión.

#figure(
  ```python
  @app.route('/api/register', methods=['POST'])
  def register():
      data = request.get_json()
      nombre = data.get('nombre')
      email = data.get('email')
      password = data.get('password')
      if Usuario.query.filter_by(email=email).first():
          return jsonify({'error': 'El email ya está registrado'}), 409
      hashed = generate_password_hash(password)
      usuario = Usuario(nombre=nombre, email=email, password_hash=hashed)
      db.session.add(usuario)
      db.session.flush()
      cartera = Cartera(usuario_id=usuario.id)
      db.session.add(cartera)
      db.session.commit()
      return jsonify({'message': 'Usuario registrado con éxito'}), 201
  ```,
  caption: [Endpoint de registro en Flask.],
) <code:registro>

==== Recuperación de contraseña

Cuando el usuario solicita recuperar su contraseña (`/api/forgot-password`), se
genera un token numérico de 6 dígitos aleatorios, se almacena en la tabla
`reset_token` (con expiración implícita de 1 hora) y se muestra por consola
(simulando el envío por correo). Posteriormente, el endpoint
`/api/reset-password` valida el token y actualiza la contraseña.

#figure(
  ```python
  @app.route('/api/forgot-password', methods=['POST'])
  def forgot_password():
      data = request.get_json()
      email = data.get('email')
      usuario = Usuario.query.filter_by(email=email).first()
      if not usuario:
          return jsonify({'message': 'Si el email está registrado, recibirás un código'}), 200
      token = str(random.randint(100000, 999999))
      ResetToken.query.filter_by(usuario_id=usuario.id).delete()
      new_token = ResetToken(usuario_id=usuario.id, token=token)
      db.session.add(new_token)
      db.session.commit()
      print(f"Código de verificación para {email}: {token}")
      return jsonify({'message': 'Código enviado'}), 200
  ```,
  caption: [Generación de código de recuperación.],
) <code:forgot>

==== Exportación de datos y eliminación de cuenta (RGPD)

Se han implementado dos endpoints protegidos:

- `GET /api/export-data`: devuelve un JSON con todos los datos del usuario
  (perfil, cartera, transacciones, favoritos).
- `DELETE /api/delete-account`: elimina al usuario y, mediante borrado manual en
  cascada, su cartera, transacciones, favoritos y tokens.

=== Módulo de búsqueda de activos y datos en tiempo real

Se integra con la librería `yfinance` para obtener datos de cualquier activo
(acción, criptomoneda, índice, divisa). El frontend incluye un buscador con
autocompletado que llama a `/api/search/<query>`. Este endpoint utiliza
`yfinance.Search` para obtener sugerencias de símbolos y nombres.

#figure(
  ```python
  @app.route('/api/search/<query>', methods=['GET'])
  def buscar(query):
      if len(query) < 2:
          return jsonify({'error': 'La búsqueda debe tener al menos 2 caracteres'}), 400
      resultados_raw = Search(query, max_results=10)
      resultados = []
      if resultados_raw.quotes:
          for quote in resultados_raw.quotes:
              resultados.append({
                  'simbolo': quote.get('symbol'),
                  'nombre': quote.get('shortname') or quote.get('longname'),
                  'tipo': quote.get('quoteType'),
                  'exchange': quote.get('exchange')
              })
      return jsonify({'query': query, 'resultados': resultados})
  ```,
  caption: [Endpoint de búsqueda de activos.],
) <code:buscar>

El dashboard de un activo se obtiene mediante `GET /api/dashboard/<simbolo>`,
que devuelve datos históricos (con período configurable), información
fundamental, predicciones Prophet y noticias con análisis de sentimiento.

=== Módulo de análisis técnico y recomendación

Se han implementado manualmente los siguientes indicadores técnicos en Python
(ver funciones auxiliares en `app.py`): SMA (20 y 50), RSI (14), MACD (12,26,9),
Bandas de Bollinger (20, 2σ), estocástico (%K), cálculo de soportes y
resistencias mediante máximos/mínimos locales, y backtesting de cruce SMA 20/50.

El endpoint `/api/recommendation/<simbolo>` agrega todos estos indicadores y
aplica un sistema de puntuación para decidir entre *COMPRAR*, *VENDER* o
*MANTENER*. Cada condición (RSI sobrecomprado/sobrevendido, MACD, posición
respecto a medias, cercanía a soporte/resistencia, rendimiento del backtest,
bandas de Bollinger, estocástico) suma puntos a favor de compra o venta.
Finalmente se calcula una confianza porcentual.

#figure(
  ```python
  @app.route('/api/recommendation/<simbolo>', methods=['GET'])
  def recommendation(simbolo):
      # ... obtención de datos e indicadores ...
      puntos_compra = 0
      puntos_venta = 0
      # RSI
      if rsi < 30: puntos_compra += 2
      elif rsi > 70: puntos_venta += 2
      # MACD
      if macd_line.iloc[-1] > macd_signal.iloc[-1]: puntos_compra += 1
      else: puntos_venta += 1
      # ... resto de condiciones ...
      if puntos_compra > puntos_venta:
          recomendacion = "COMPRAR"
          confianza = min(100, int(puntos_compra / max_puntos * 100))
      elif puntos_venta > puntos_compra:
          recomendacion = "VENDER"
          confianza = min(100, int(puntos_venta / max_puntos * 100))
      else:
          recomendacion = "MANTENER"
          confianza = 50
      return jsonify({...})
  ```,
  caption: [Sistema de recomendación basado en indicadores técnicos.],
) <code:recomendacion>

=== Módulo de predicción de precios con Prophet

Se utiliza el modelo *Prophet* de Facebook para generar predicciones a 30 días.
La función `predecir_con_prophet` (definida en `app.py`) prepara los datos
históricos (columna `ds` con fechas y `y` con precios de cierre), entrena el
modelo (con estacionalidad anual) y realiza el forecast. Adicionalmente calcula
el error MAPE mediante validación cruzada, siempre que haya suficientes datos.

#figure(
  ```python
  def predecir_con_prophet(precios_historicos, dias_a_predecir=30):
      df = pd.DataFrame(precios_historicos)
      df.columns = ['ds', 'y']
      df['ds'] = pd.to_datetime(df['ds'])
      modelo = Prophet(yearly_seasonality=True, weekly_seasonality=False,
                       daily_seasonality=False, changepoint_prior_scale=0.05)
      modelo.fit(df)
      futuro = modelo.make_future_dataframe(periods=dias_a_predecir)
      prediccion = modelo.predict(futuro)
      # Extraer solo las fechas futuras y los intervalos
      # ...
      return resultados, mape
  ```,
  caption: [Función de predicción con Prophet.],
) <code:prophet>

El endpoint `/api/dashboard/<simbolo>` incluye la predicción en la respuesta,
junto con el resto de información del activo.

=== Módulo de análisis de sentimiento de noticias

La función `analizar_sentimiento` carga dos modelos de *transformers*: *FinBERT*
para inglés y `bardsai/finance-sentiment-es-base` para español. Ambos se
almacenan en variables globales al iniciar el servidor para evitar recargas
innecesarias. Para cada noticia obtenida de NewsAPI, se evalúa el título y
descripción, y se devuelve una etiqueta (*positivo*, *neutral*, *negativo*) y
las probabilidades. Además, se aplica un umbral de negatividad más estricto para
el modelo español (0.20) para reducir falsos positivos.

#figure(
  ```python
  def analizar_sentimiento(texto, idioma='en', umbral_negativo=0.25):
      if not texto or len(texto.strip()) < 10:
          return {'sentimiento': 'neutral', 'confianza': 1.0, ...}
      # seleccionar tokenizer y modelo según idioma
      inputs = tokenizer(texto, return_tensors="pt", truncation=True, max_length=512)
      with torch.no_grad():
          outputs = model(**inputs)
      scores = torch.nn.functional.softmax(outputs.logits, dim=-1)
      score_positive = scores[0][2].item()
      score_negative = scores[0][0].item()
      score_neutral = scores[0][1].item()
      # Lógica de decisión con umbral
      # ...
  ```,
  caption: [Función de análisis de sentimiento con transformers.],
) <code:sentimiento>

El endpoint `/api/noticias?q=<query>` permite buscar noticias genéricas y
obtener el resumen de sentimiento, mientras que `/api/dashboard/<simbolo>` ya
incluye las noticias relacionadas con el activo.

=== Módulo de cartera virtual

La cartera virtual se implementa mediante los modelos `Cartera` y `Transaccion`.
Cada usuario tiene una única cartera con un saldo inicial de 10.000 USD. Las
operaciones de compra y venta se ejecutan en los endpoints `/api/comprar` y
`/api/vender`. Antes de ejecutar la compra, se verifica que el saldo sea
suficiente; para la venta, se calcula la posición actual del usuario mediante la
función `calcular_posicion_actual`, que suma las cantidades de todas las
transacciones de tipo 'compra' y 'venta'.

#figure(
  ```python
  @app.route('/api/comprar', methods=['POST'])
  def comprar_accion():
      data = request.get_json()
      simbolo = data.get('simbolo')
      cantidad = data.get('cantidad')
      precio = data.get('precio')
      cartera = Cartera.query.filter_by(usuario_id=user_id).first()
      costo_total = cantidad * precio
      if cartera.saldo < costo_total:
          return jsonify({'error': 'Saldo insuficiente'}), 400
      cartera.saldo -= costo_total
      cartera.total_transacciones += 1
      transaccion = Transaccion(cartera_id=cartera.id, accion_simbolo=simbolo,
                                tipo='compra', cantidad=cantidad, precio=precio)
      db.session.add(transaccion)
      db.session.commit()
      return jsonify({'message': 'Compra realizada con éxito', 'nuevo_saldo': cartera.saldo}), 200
  ```,
  caption: [Endpoint de compra de acciones.],
) <code:comprar>

El frontend muestra el saldo actual, la evolución mediante gráficos
(ngx-echarts) y las transacciones recientes. La composición de la cartera se
calcula consultando los precios actuales de los activos en Yahoo Finance.

=== Módulo de favoritos

Los usuarios autenticados pueden añadir o eliminar activos como favoritos
mediante los endpoints `/api/favoritos` (GET, POST, DELETE). La tabla `Favorito`
guarda la relación entre `usuario_id` y `simbolo`, con una restricción de
unicidad para evitar duplicados. El endpoint GET devuelve la lista de símbolos
favoritos del usuario.

#figure(
  ```python
  @app.route('/api/favoritos', methods=['POST'])
  def add_favorito():
      user_id = session.get('user_id')
      data = request.get_json()
      simbolo = data.get('simbolo')
      existing = Favorito.query.filter_by(usuario_id=user_id, simbolo=simbolo).first()
      if existing:
          return jsonify({'message': 'Ya está en favoritos'}), 200
      fav = Favorito(usuario_id=user_id, simbolo=simbolo)
      db.session.add(fav)
      db.session.commit()
      return jsonify({'message': 'Añadido a favoritos'}), 201
  ```,
  caption: [Añadir un activo a favoritos.],
) <code:favoritos>

=== Módulo de internacionalización y tooltips

La internacionalización (i18n) se ha implementado completamente en el frontend
Angular sin librerías externas. Se creó un servicio `LanguageService` que
mantiene el idioma actual (español/inglés) en `localStorage`. Un `TranslatePipe`
recibe una clave (ej. `'login.title'`) y devuelve la cadena traducida desde un
diccionario JSON embebido. Todas las plantillas HTML utilizan este pipe.

Para los tooltips, se desarrolló una directiva `TooltipDirective` que, al hacer
hover, muestra un div flotante con el texto traducido (también usando el pipe).
La directiva calcula automáticamente la posición para que no se salga de la
pantalla. Esto mejora la experiencia de usuario al proporcionar explicaciones
instantáneas sobre indicadores técnicos, gráficos y botones.

=== Módulo de ayuda

Se han añadido tres páginas de ayuda estáticas (Análisis técnico, Cartera
virtual, Noticias) accesibles desde el menú principal. Explican con texto e
imágenes cómo utilizar cada sección, el significado de los indicadores técnicos,
cómo interpretar las predicciones y el análisis de sentimiento. Las páginas
están implementadas como componentes Angular independientes y utilizan el
`TranslatePipe` para estar disponibles en ambos idiomas.

== Diagramas de clases

Para comprender la estructura del software, se presentan dos niveles de
diagramas de clases. Por un lado, se muestran diagramas *detallados* que
desglosan por capas (modelos, controladores, servicios y vistas) tanto del
backend como del frontend. Por otro lado, se incluyen diagramas *globales* que
ofrecen una visión de conjunto de las principales entidades y sus relaciones.

=== Backend

==== Modelos del backend

El siguiente diagrama muestra los modelos SQLAlchemy que representan las tablas
de la base de datos: `Usuario`, `Cartera`, `Transaccion`, `Favorito` y
`ResetToken`. Se indican sus atributos principales y las relaciones de clave
foránea (1:1 entre `Usuario` y `Cartera`, 1:N con `Favorito` y `ResetToken`, y
1:N entre `Cartera` y `Transaccion`). Estos modelos son la base del
almacenamiento persistente de la aplicación.

#figure(
  image(
    "../Figures/Template/Chapter7/diagrama_clases_backend_modelos.drawio.png",
    width: 120%,
  ),
  caption: [Diagrama de clases detallado de los modelos del backend.],
) <fig:backend_modelos>

==== Controladores (endpoints) del backend

Los controladores agrupan las rutas de la API por responsabilidad funcional.
`AuthController` gestiona la autenticación y el perfil de usuario;
`AssetController` se encarga de la búsqueda y obtención de datos de activos;
`TechnicalController` provee los indicadores técnicos, la recomendación y la
predicción con Prophet; `NewsController` integra NewsAPI y el análisis de
sentimiento; `PortfolioController` implementa la cartera virtual; y
`FavoritesController` administra los favoritos. Cada controlador utiliza los
modelos correspondientes y servicios externos (Yahoo Finance, NewsAPI, modelos
de transformers).

#figure(
  image(
    "../Figures/Template/Chapter7/diagrama_clases_backend_controladores.drawio.png",
    width: 120%,
  ),
  caption: [Diagrama de clases detallado de los controladores del backend.],
) <fig:backend_controladores>

==== Visión global del backend

El diagrama global del backend integra los modelos y los controladores más
relevantes, mostrando las dependencias entre ellos. Se aprecia cómo los
controladores acceden a los modelos para leer o modificar datos, y cómo algunos
controladores se apoyan en APIs externas (Yahoo Finance, NewsAPI) y en librerías
de IA (Prophet, Transformers). Este diagrama ofrece una perspectiva completa de
la arquitectura del lado del servidor.

#figure(
  image(
    "../Figures/Template/Chapter7/diagrama_clases_backend.png",
    width: 100%,
  ),
  caption: [Diagrama de clases global del backend.],
) <fig:backend_global>

=== Frontend

==== Modelos del frontend

En el frontend Angular, los modelos se definen como interfaces TypeScript que
reflejan la estructura de los datos intercambiados con la API. Los principales
modelos son `Usuario`, `Cartera`, `Transaccion`, `Accion` y `Noticia`. Todos
ellos incluyen un método `fromJson` para construir instancias a partir de las
respuestas JSON del backend. Estos modelos garantizan la coherencia tipada en
toda la aplicación.

#figure(
  image(
    "../Figures/Template/Chapter7/diagrama_clases_frontend_modelos.drawio.png",
    width: 120%,
  ),
  caption: [Diagrama de clases detallado de los modelos del frontend.],
) <fig:frontend_modelos>

==== Servicios del frontend

Los servicios Angular actúan como controladores en el lado del cliente.
Encapsulan la lógica de comunicación con la API a través de `HttpClient` y
gestionan el estado de la aplicación. `AuthService` maneja la autenticación;
`AssetService` obtiene datos de activos y predicciones; `PortfolioService`
gestiona la cartera virtual; `FavoritesService` administra los favoritos;
`NewsService` recupera noticias con análisis de sentimiento; y `LanguageService`
proporciona la internacionalización. Cada servicio expone métodos observables
que los componentes consumen.

#figure(
  image(
    "../Figures/Template/Chapter7/diagrama_clases_frontend_servicios.drawio.png",
    width: 120%,
  ),
  caption: [Diagrama de clases detallado de los servicios del frontend.],
) <fig:frontend_servicios>

==== Vistas principales del frontend

Las vistas son componentes Angular que se corresponden con las rutas de la
aplicación: `LoginComponent`, `RegisterComponent`, `HomeComponent`,
`DashboardComponent`, `PortfolioComponent`, `FavoritesComponent`,
`NewsComponent`, `ProfileComponent` y las páginas de ayuda. Cada vista inyecta
los servicios que necesita y se suscribe a sus observables para actualizar la
interfaz. Por ejemplo, `DashboardComponent` usa `AssetService` y
`PortfolioService`, mientras que `ProfileComponent` utiliza `AuthService`. El
siguiente diagrama resume estas dependencias.

#figure(
  image(
    "../Figures/Template/Chapter7/diagrama_clases_frontend_vistas.drawio.png",
    width: 120%,
  ),
  caption: [Diagrama de clases detallado de las vistas principales del
    frontend.],
) <fig:frontend_vistas>

==== Visión global del frontend

El diagrama global del frontend integra los modelos, los servicios y las vistas
más significativos. Se observa cómo los servicios dependen de los modelos para
tipar los datos, y cómo las vistas se apoyan en los servicios para obtener
información y ejecutar acciones. Además, se muestra que `AssetService` y
`NewsService` utilizan `LanguageService` para adaptar los textos al idioma
seleccionado. Esta visión global ayuda a entender la organización general del
código Angular.

#figure(
  image(
    "../Figures/Template/Chapter7/diagrama_clases_frontend.png",
    width: 100%,
  ),
  caption: [Diagrama de clases global del frontend.],
) <fig:frontend_global>

Los diagramas presentados han sido simplificados para reflejar las clases y
relaciones más importantes, omitiendo algunos atributos y métodos secundarios
por claridad. No obstante, constituyen una representación fiel de la
arquitectura orientada a objetos de _FinancialPulse_ y sirven como guía para el
mantenimiento y la evolución del código.

== Resumen de módulos implementados

La siguiente tabla resume los módulos, su estado y las tecnologías asociadas.
Todos los módulos planificados se han completado satisfactoriamente.

#figure(
  table(
    columns: (2fr, 1fr, 2fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [Módulo], [Estado], [Tecnologías clave],
    [Autenticación y usuarios],
    [Completo],
    [Flask, sesiones, bcrypt, PostgreSQL],

    [Datos en tiempo real], [Completo], [yfinance, Flask, Angular],
    [Indicadores técnicos], [Completo], [Pandas, NumPy, cálculo manual],
    [Predicción Prophet], [Completo], [Prophet, pandas, Flask],
    [Análisis de sentimiento],
    [Completo],
    [Transformers (FinBERT, modelo español), Torch],

    [Cartera virtual], [Completo], [SQLAlchemy, yfinance, Angular],
    [Favoritos], [Completo], [PostgreSQL, Angular],
    [Internacionalización], [Completo], [Angular pipe, servicio, diccionarios],
    [Tooltips], [Completo], [Angular directiva, CSS],
    [Ayuda], [Completo], [Componentes Angular estáticos],
    [RGPD (export/delete)], [Completo], [Flask, JSON, SQLAlchemy],
  ),
  caption: [Resumen de módulos implementados en FinancialPulse.],
) <tabla:modulos>

Todo el código fuente está disponible en el repositorio de GitHub (enlace en
anexos). En el siguiente capítulo se describen las pruebas realizadas y la
validación del software.

Una vez descrita la implementación de todos los módulos, el siguiente capítulo
presenta las pruebas realizadas para validar el correcto funcionamiento del
sistema.
