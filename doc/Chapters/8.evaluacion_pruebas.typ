= Evaluación y pruebas

En este capítulo se describe cómo se evaluó el software desarrollado, incluyendo
las pruebas realizadas, los resultados obtenidos y las conclusiones derivadas.
Se detallan las pruebas unitarias, de integración, de aceptación, de rendimiento
y de usabilidad, así como las herramientas utilizadas y los criterios de éxito.
Se analizan los resultados obtenidos, se identifican las limitaciones y se
proponen mejoras para futuras versiones del sistema.

== Plan de pruebas

El plan combinó distintos enfoques, intentando cubrir las partes más importantes
del sistema:

- *Pruebas unitarias*: se probó las funciones auxiliares del backend (cálculo de
  RSI, Prophet, análisis de sentimiento) ejecutando pequeños scripts Python con
  datos de prueba. En el frontend se realizaron pruebas manuales del
  `TranslatePipe` y de la directiva de tooltip: cambiando el idioma y mirando si
  todo se traducía correctamente.
- *Pruebas de integración*: se comprobó la comunicación entre frontend y backend
  usando Thunder Client, y también que la base de datos se actualizara bien
  (observando los cambios en las tablas tras cada operación: registro, compra,
  etc.).
- *Pruebas de aceptación*: se simularon casos de uso completos (registro, login,
  búsqueda de activo, compra/venta, análisis de sentimiento, exportación de
  datos) para asegurarse de que el sistema se comportaba como esperaría un
  usuario real.
- *Pruebas de usabilidad*: se solicitó a cuatro voluntarios que usaran la
  aplicación y trasladaran su opinión mediante un cuestionario de Google Forms.

=== Herramientas utilizadas

- *Backend*: scripts Python sencillos (sin framework) para probar las funciones
  una por una. Se optó por no usar librerías de testing debido a que no eran
  necesarias.
- *Frontend*: se realizaron pruebas manuales de componentes y pipes (cambiar
  idioma, mirar tooltips). Nada automático, pero suficiente para lo que se
  requería.
- *API*: Thunder Client (una extensión de VSCode) para probar los endpoints y
  flujos completos. Se optó por esta vía antes que instalar Postman, ya que
  Thunder Client es más ligero y se integra directamente en el IDE.
- *Usabilidad*: se realizó un cuestionario en Google Forms con escala Likert,
  que luego se analizó con una hoja de cálculo.

== Pruebas unitarias

En cuanto a las pruebas unitarias, se verificó que las funciones críticas del
backend devolvían resultados correctos con datos de prueba conocidos. Las
pruebas se realizaron de forma manual, sin frameworks automáticos. Me centré en
los modelos de la base de datos, en los endpoints de autenticación y en las
funciones de indicadores.

=== Backend

Se desarrollaron pequeños scripts en Python para probar, por ejemplo, el cálculo
del RSI. A contuniación, en el Listado 7.1 se muestra uno de ellos:

#figure(
  ```python
  import pandas as pd
  from app import calcular_rsi

  precios = pd.Series([44.34, 44.09, 44.15, 43.61, 44.33, 44.83, 45.10,
                       45.42, 45.84, 46.08, 45.89, 46.03, 45.61, 46.28,
                       46.28, 46.00, 46.03, 46.41, 46.22, 45.64])
  rsi = calcular_rsi(precios, period=14).iloc[-1]
  print(f"RSI calculado: {rsi}")  # Se verificó que el valor rondaba 70
  ```,
  caption: [Prueba manual de la función `calcular_rsi`.],
) <code:test_rsi_manual>

De forma similar se probó `calcular_macd`, `calcular_bollinger`, la predicción
con Prophet y el análisis de sentimiento con frases de ejemplo en inglés y
español. En todos los casos los resultados eran coherentes con lo esperado.

También se realizó una prueba para el registro de usuario, simulando una
petición HTTP con un cliente de pruebas. En el Listado 7.2 se muestra un ejemplo
de cómo se verificó que al registrar un usuario se creaba correctamente la
cartera asociada:

#figure(
  ```python
  def test_register_usuario(client):
      response = client.post('/api/register', json={
          'nombre': 'Usuario Test',
          'email': 'test@example.com',
          'password': '123456'
      })
      assert response.status_code == 201
      assert response.json['message'] == 'Usuario registrado con éxito'
      user = Usuario.query.filter_by(email='test@example.com').first()
      assert user is not None
      cartera = Cartera.query.filter_by(usuario_id=user.id).first()
      assert cartera.saldo == 10000.0
  ```,
  caption: [Prueba unitaria para el registro de usuario.],
) <code:test_registro>

Y otro para el cálculo del RSI con valores conocidos, aunque este último es casi
igual que el anterior pero con un `assert` en lugar de un `print`. En el Listado
7.3 se muestra cómo se verificó que el RSI calculado estaba dentro del rango
esperado:

#figure(
  ```python
  def test_calcular_rsi():
      precios = pd.Series([44.34, 44.09, 44.15, 43.61, 44.33, 44.83, 45.10,
                           45.42, 45.84, 46.08, 45.89, 46.03, 45.61, 46.28,
                           46.28, 46.00, 46.03, 46.41, 46.22, 45.64])
      rsi = calcular_rsi(precios, period=14).iloc[-1]
      assert 65 < rsi < 75
  ```,
  caption: [Prueba unitaria para la función `calcular_rsi`.],
) <code:test_rsi>

=== Frontend

Para probar el `TranslatePipe`, se arrancó la aplicación Angular y se cambió el
idioma varias veces. Se comprobó que todas las etiquetas se actualizaban
correctamente, tanto en español como en inglés. La directiva `TooltipDirective`
se probó haciendo hover sobre los nombres de los indicadores y comprobando que
aparecía el texto de ayuda traducido. Las pruebas fueron exitosas, dando por
finalizada esa funcionalidad.

== Pruebas de integración

Las pruebas de integración se realizaron manualmente con Thunder Client. Se
simuló el flujo completo de compra de una acción paso a paso, para asegurarse de
que los distintos componentes del sistema hablaban bien entre ellos.

1. Se registró un nuevo usuario con POST a `/api/register`.
2. Se inició sesión con POST a `/api/login` y se guardó la cookie de sesión
  (Thunder Client la maneja automáticamente).
3. Se consultó la cartera con GET a `/api/cartera` para comprobar que el saldo
  inicial era 10000.
4. Se realizó una compra de 5 acciones de AAPL con POST a `/api/comprar`,
  enviando `{"simbolo":"AAPL","cantidad":5,"precio":175.50}`.
5. Se volvió a consultar la cartera para ver que el saldo se había reducido en
  877.50.
6. Se pidió el listado de transacciones con GET a `/api/transacciones` y se
  comprobó que aparecía una compra.

Todas las peticiones devolvieron código 200 y los datos se actualizaron
correctamente en la base de datos PostgreSQL. Además, se revisó visualmente la
tabla `transaccion` para confirmar que se había insertado el registro.

Durante estas pruebas se detectó un error de concurrencia: si se realizabam dos
compras rápidas seguidas, a veces se actualizaba mal el saldo. Se solucionó
añadiendo un bloqueo pesimista con `with_for_update()` en la consulta de la
cartera dentro de la transacción. También se corrigió un error en la validación
del email duplicado durante el registro (el mensaje de error no se mostraba bien
en el frontend).

== Pruebas de aceptación

Se definieron los casos de uso críticos (los mismos que en el capítulo 5) y se
ejecutaron paso a paso, verificando que el sistema respondía correctamente y que
los datos se actualizaban en la base de datos. Se comprobó que los endpoints
devolvían los códigos de estado esperados y que el frontend reflejaba los
cambios. Se documentaron los resultados de cada caso de uso, incluyendo
cualquier error encontrado y cómo se resolvió. La siguiente Tabla 7.1 resume los
resultados:

#figure(
  table(
    columns: (3fr, 1.2fr, 1fr, 2.3fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [*Caso de uso*], [*Resultado*], [*Errores*], [*Observaciones*],
    [Registro de usuario], [Correcto], [No], [Se crea usuario y cartera],
    [Inicio de sesión], [Correcto], [No], [Sesión persistente],
    [Recuperación de contraseña],
    [Correcto],
    [No],
    [Token de 6 dígitos generado],

    [Búsqueda de activo (AAPL)], [Correcto], [No], [Autocompletado funciona],
    [Ver dashboard de AAPL], [Correcto], [No], [Gráfico e indicadores OK],
    [Calcular indicador RSI], [Correcto], [No], [Valor coherente],
    [Backtesting SMA cruce], [Correcto], [No], [Rendimiento calculado],
    [Predicción Prophet (30 días)], [Correcto], [No], [Forecast generado],
    [Análisis de sentimiento noticia],
    [Correcto],
    [Modelo español más lento],
    [Se optimizará en el futuro],

    [Comprar acciones (cartera)],
    [Correcto],
    [No (concurrencia solucionado)],
    [Saldo actualizado],

    [Vender acciones], [Correcto], [No], [Saldo y transacción OK],
    [Ver evolución del balance], [Correcto], [No], [Gráfico generado],
    [Añadir/quitar favoritos], [Correcto], [No], [Persiste en BD],
    [Exportar datos personales (JSON)], [Correcto], [No], [Archivo descargado],
    [Eliminar cuenta], [Correcto], [No], [Borrado en cascada],
    [Cambio de idioma (es/en)],
    [Correcto],
    [No],
    [Tooltips también se traducen],

    [Ayuda integrada], [Correcto], [No], [Páginas estáticas accesibles],
  ),
  caption: [Resultados de las pruebas de aceptación.],
) <tabla:pruebas_aceptacion>

Todos los casos de uso críticos salieron bien. El único inconveniente fue la
latencia del modelo de sentimiento en español (unos 1.5 segundos por noticia).
Como punto de mejora se podría optimizar el modelo o cachear resultados. En
general, el sistema cumplió con los requisitos funcionales y no funcionales
definidos en el capítulo 5.

== Pruebas de rendimiento

En cuanto a las pruebas de rendimiento, se midió el tiempo de respuesta de los
endpoints más pesados, como `/api/dashboard/<simbolo>` y
`/api/prediccion/<simbolo>`. Se realizaron varias peticiones consecutivas y se
registraron los tiempos de respuesta. Los resultados mostraron que la mayoría de
las peticiones se completaban en menos de 2 segundos, cumpliendo con el
requisito *RNF-02* de tiempo de respuesta aceptable. Sin embargo, se observó que
el modelo de sentimiento en español era más lento (1.5 segundos por noticia) que
el modelo en inglés (0.5 segundos), lo que se documentó como una limitación y un
área de mejora futura. También hice pruebas de carga informales con Apache
Benchmark (ab). Probé el endpoint `/api/dashboard/AAPL` (el más pesado, porque
tiene que consultar varias fuentes y ejecutar Prophet) con 100 peticiones
totales y 10 concurrentes:

```bash
ab -n 100 -c 10 http://localhost:5000/api/dashboard/AAPL
```

Los resultados fueron: tiempo medio por petición 1.2 segundos, tasa de error 0%,
unas 8.3 peticiones por segundo. Ninguna petición superó los 3 segundos, así que
cumplí el requisito *RNF-02*. El cuello de botella es Prophet, que se ejecuta
bajo demanda sin caché. En una versión futura se podría cachear las predicciones
durante unas horas, pero para las pruebas no hizo falta.

== Pruebas de usabilidad

En cuanto a las pruebas de usabilidad, se buscó obtener feedback de usuarios
reales. Se diseñó un cuestionario con 10 preguntas cerradas (escala Likert de 1
a 5) y dos preguntas abiertas. Se reclutaron cuatro voluntarios con distintos
perfiles (estudiantes de ingeniería, estudiante de administración y profesional
del sector tecnológico) para usar la aplicación durante unos 15 minutos y luego
completar el cuestionario. El objetivo era evaluar la claridad de la interfaz,
la facilidad de navegación, la comprensión de los gráficos y la utilidad de las
funciones ofrecidas. Los resultados se analizaron cuantitativa y
cualitativamente para identificar fortalezas y áreas de mejora.

=== Resultados cuantitativos

La siguiente Tabla 7.2 muestra las puntuaciones de cada pregunta, la media y la
desviación estándar. Estos indicadores se han calculado con una hoja de cálculo
a partir de las respuestas de los cuatro voluntarios.

#figure(
  table(
    columns: (1.8fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: 1pt,
    align: center + horizon,
    inset: 4pt,
    [Pregunta], [U1], [U2], [U3], [U4], [Media], [σ],
    [1. Interfaz clara y fácil de navegar], [5], [4], [5], [4], [4.50], [0.50],
    [2. Registro/login sencillo], [4], [5], [5], [4], [4.50], [0.50],
    [3. Búsqueda rápida y cómoda], [5], [4], [5], [4], [4.50], [0.50],
    [4. Gráficos comprensibles], [4], [3], [5], [4], [4.00], [0.71],
    [5. Indicadores técnicos bien explicados],
    [5],
    [3],
    [5],
    [4],
    [4.25],
    [0.83],

    [6. Cartera virtual funciona bien], [5], [4], [5], [4], [4.50], [0.50],
    [7. Noticias con sentimiento útiles], [5], [4], [5], [4], [4.50], [0.50],
    [8. Rapidez de respuesta], [5], [5], [5], [4], [4.75], [0.43],
    [9. Tooltips y ayuda claros], [5], [5], [5], [4], [4.75], [0.43],
    [10. Recomendaría la aplicación], [4], [3], [5], [4], [4.00], [0.71],
  ),
  caption: [Resultados del cuestionario de usabilidad (escala 1-5).],
) <tabla:usabilidad>

La media global fue de 4.43 sobre 5, una valoración muy positiva. Lo mejor
valorado fueron la rapidez de respuesta (4.75) y la claridad de los tooltips y
la ayuda (4.75). Las preguntas con puntuación más baja (aunque todavía
positivas) fueron la comprensión de los gráficos (4.00) y si recomendarían la
aplicación (4.00). Probablemente porque algunos usuarios no están acostumbrados
a leer gráficos de velas.

=== Resultados cualitativos

A continuación, se muestran los comentarios que dejaron los usuarios en las
preguntas abiertas, tal cual los escribieron.

¿Qué es lo que más te ha gustado de la aplicación?

- Usuario 1: "La interfaz gráfica de usuario es sin duda lo mejor que tiene la
  aplicación. Se nota que se ha dedicado bastante tiempo y trabajo a esa parte."

- Usuario 2: "Lo que más me ha gustado es la conexión entre el backend y el
  frontend."

- Usuario 3: "Las páginas de ayuda de cada sección así como todos los popups los
  cuales ayudan a comprender el funcionamiento y uso de la aplicación."

- Usuario 4: "La rápida respuesta a las peticiones de usuario (búsqueda de
  activos, noticias, movimientos en la cartera)."

¿Qué sugerencias de mejora harías?

- Usuario 1: "Mejorar la forma de mostrar los datos históricos y las
  predicciones."

- Usuario 2: "Mejoraría la interfaz gráfica de usuario a algo más profesional
  hoy en día. Añadiendo un tema oscuro completo para usar la aplicación con poca
  luz y un tema claro para el día."

- Usuario 3: "Un canal de soporte técnico al administrador."

- Usuario 4: "No tengo sugerencias, todo me ha parecido correcto."

=== Análisis de los resultados

Los usuarios destacaron especialmente la interfaz (U1), la integración
backend-frontend (U2), las páginas de ayuda (U3) y la rapidez (U4). Las
sugerencias apuntan a mejorar la visualización de datos históricos, dar un
aspecto más profesional a la interfaz y añadir un canal de soporte. Se tendrá en
cuenta como puntos a mejorar para versiones futuras.

En general, los resultados de usabilidad son muy positivos. La media de 4.43 y
los comentarios favorables confirman que la aplicación cumple con los objetivos
de experiencia de usuario.

== Limitaciones y aspectos no probados

En general, las pruebas realizadas cubrieron los casos de uso críticos y
permitieron validar la funcionalidad, integración, rendimiento y usabilidad del
sistema. Aunque, a continuación, se destacan algunas pruebas que no se pudieron
realizar, y que podrían considerarse para futuras versiones del proyecto:

- Pruebas de seguridad exhaustivas (inyección SQL, XSS, CSRF). Eso sí,
  SQLAlchemy ya parametriza las consultas, lo que mitiga la inyección SQL de
  forma automática.

- Pruebas de rendimiento con alta concurrencia (más de 100 usuarios
  simultáneos). Habría sido exagerado para el alcance del proyecto.

- Pruebas automáticas completas del frontend (solo se probó manualmente el pipe
  y la directiva). Automatizarlo llevaría demasiado tiempo.

- Pruebas de usabilidad con una muestra mayor (solo cuatro voluntarios). Se
  podría ampliar la muestra en futuras versiones.

Aun así, los resultados demuestran que el software es estable, funcional y
cumple los requisitos fundamentales.

== Conclusión de la evaluación

FinancialPulse superó las pruebas críticas de funcionalidad, integración,
aceptación, rendimiento y usabilidad. Los errores que aparecieron (concurrencia
en compras, validación de email duplicado, lentitud del modelo en español) están
corregidos o al menos documentados como mejoras futuras. El sistema es usable,
respeta el RGPD, tiene una interfaz responsive y multilingüe, y ofrece un
rendimiento aceptable en condiciones normales.

En el siguiente capítulo se presentan las conclusiones finales y las líneas de
trabajo futuro.
