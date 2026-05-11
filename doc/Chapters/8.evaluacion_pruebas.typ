= Evaluación y pruebas

En este capítulo se describe el proceso de verificación y validación del
software desarrollado. Se han ejecutado pruebas unitarias, de integración, de
aceptación, de rendimiento y de usabilidad para garantizar el correcto
funcionamiento de los módulos principales y el cumplimiento de los requisitos
funcionales y no funcionales. Debido a la complejidad del proyecto y las
limitaciones de tiempo, la cobertura no es exhaustiva, pero se han verificado
todos los flujos críticos.

== Plan de pruebas

El plan de pruebas se ha diseñado siguiendo una estrategia combinada:

- *Pruebas unitarias*: Se probaron aisladamente los modelos de base de datos
  (SQLAlchemy), las funciones auxiliares (cálculo de RSI, Prophet, sentimiento)
  y algunos endpoints (registro, login). En el frontend se probaron el
  `TranslatePipe` y la directiva de tooltip.
- *Pruebas de integración*: Se verificó la comunicación entre frontend y backend
  mediante peticiones reales a la API (usando Postman y `pytest` con cliente de
  pruebas) y la correcta interacción con la base de datos PostgreSQL.
- *Pruebas de aceptación*: Se simularon casos de uso completos (registro, login,
  búsqueda de activo, compra/venta, análisis de sentimiento, exportación de
  datos) para comprobar que el sistema se comporta como se espera desde la
  perspectiva del usuario.
- *Pruebas de rendimiento*: Se realizaron pruebas de carga básicas sobre el
  endpoint más crítico (`/api/dashboard`).
- *Pruebas de usabilidad*: Se solicitó feedback a tres voluntarios.

=== Herramientas utilizadas

- *Backend*: `pytest`, `pytest-cov` para cobertura, `Flask-Testing` para cliente
  de pruebas.
- *Frontend*: Karma, Jasmine y `@angular/cli` para pruebas unitarias.
- *API*: Postman para pruebas manuales y automatización de flujos.
- *Carga*: Apache Benchmark (ab) y `locust` (prueba sencilla).
- *CI/CD*: GitHub Actions (workflow básico para backend).

== Pruebas unitarias

Las pruebas unitarias se centraron en los modelos de la base de datos, en los
endpoints de autenticación y en las funciones auxiliares de indicadores.

=== Backend

A continuación se muestra una prueba unitaria para el registro de usuario:

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
      # Verificar que se creó la cartera con saldo 10000
      user = Usuario.query.filter_by(email='test@example.com').first()
      assert user is not None
      cartera = Cartera.query.filter_by(usuario_id=user.id).first()
      assert cartera.saldo == 10000.0
  ```,
  caption: [Prueba unitaria para el registro de usuario.],
) <code:test_registro>

También se probó el cálculo del RSI con una serie de precios conocida:

#figure(
  ```python
  def test_calcular_rsi():
      precios = pd.Series([44.34, 44.09, 44.15, 43.61, 44.33, 44.83, 45.10,
                           45.42, 45.84, 46.08, 45.89, 46.03, 45.61, 46.28,
                           46.28, 46.00, 46.03, 46.41, 46.22, 45.64])
      rsi = calcular_rsi(precios, period=14).iloc[-1]
      # El valor esperado aproximado es ~70.5 (depende de la implementación)
      assert 65 < rsi < 75
  ```,
  caption: [Prueba unitaria para la función `calcular_rsi`.],
) <code:test_rsi>

=== Frontend

En el frontend se probó el `TranslatePipe` con los dos idiomas disponibles:

#figure(
  ```typescript
  describe('TranslatePipe', () => {
    let pipe: TranslatePipe;
    let languageService: LanguageService;
    beforeEach(() => {
      languageService = new LanguageService();
      pipe = new TranslatePipe(languageService);
    });
    it('debe traducir "login.title" al español', () => {
      languageService.setLanguage('es');
      expect(pipe.transform('login.title')).toBe('Iniciar sesión');
    });
    it('debe traducir "login.title" al inglés', () => {
      languageService.setLanguage('en');
      expect(pipe.transform('login.title')).toBe('Login');
    });
  });
  ```,
  caption: [Prueba unitaria del pipe de traducción.],
) <code:test_pipe>

Los resultados fueron satisfactorios: todos los modelos y funciones auxiliares
superaron las pruebas, logrando una *cobertura del 78%* en el backend (medido
con `pytest-cov`) y del *65%* en el frontend.

== Pruebas de integración

Las pruebas de integración verificaron la comunicación entre el frontend
(simulado mediante cliente HTTP) y los endpoints reales del backend, incluyendo
la autenticación por sesión. A continuación se muestra una prueba que comprueba
el flujo completo de compra de una acción:

#figure(
  ```python
  def test_comprar_accion_integracion(client):
      # 1. Registrar usuario
      client.post('/api/register', json={
          'nombre': 'Inversor',
          'email': 'inversor@test.com',
          'password': 'test123'
      })
      # 2. Login para obtener sesión
      login_res = client.post('/api/login', json={
          'email': 'inversor@test.com',
          'password': 'test123'
      })
      assert login_res.status_code == 200
      # 3. Obtener cartera (saldo inicial 10000)
      cartera_res = client.get('/api/cartera')
      assert cartera_res.json['saldo'] == 10000.0
      # 4. Comprar 5 acciones de AAPL a precio simulado
      compra_res = client.post('/api/comprar', json={
          'simbolo': 'AAPL',
          'cantidad': 5,
          'precio': 175.50
      })
      assert compra_res.status_code == 200
      assert compra_res.json['nuevo_saldo'] == 10000.0 - 5 * 175.50
      # 5. Verificar transacción creada
      transacciones_res = client.get('/api/transacciones')
      assert len(transacciones_res.json) == 1
      assert transacciones_res.json[0]['tipo'] == 'compra'
  ```,
  caption: [Prueba de integración para el flujo de compra de acciones.],
) <code:test_compra_integracion>

Se detectó un error inicial de concurrencia cuando se realizaban múltiples
compras rápidas desde el mismo usuario. Se solucionó agregando un bloqueo
pesimista con `with_for_update()` en la consulta de la cartera dentro de la
transacción. También se corrigió un error en la validación del email duplicado
durante el registro.

== Pruebas de aceptación

Se definieron los casos de uso críticos (los mismos que los casos de uso del
capítulo 5) y se ejecutaron manualmente mediante un script de Postman y
verificación visual en el frontend. La siguiente tabla resume los resultados:

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

Todos los casos de uso críticos superaron las pruebas. El único inconveniente
fue la latencia del modelo de sentimiento en español (aproximadamente 1.5
segundos por noticia), que se mitigará en futuras versiones cacheando
resultados.

== Pruebas de rendimiento

Se realizaron pruebas de carga sobre el endpoint `/api/dashboard/AAPL` (el más
pesado, ya que incluye llamadas a Yahoo Finance, Prophet y NewsAPI). Se utilizó
Apache Benchmark con 100 peticiones totales y concurrencia de 10 hilos:

```bash
ab -n 100 -c 10 http://localhost:5000/api/dashboard/AAPL
```

Los resultados fueron:

- Tiempo medio por petición: 1.2 segundos.

- Tasa de error: 0% (todas las peticiones respondieron con 200 OK).

- Peticiones por segundo: ~8.3.

Ninguna petición superó los 3 segundos, cumpliendo así el requisito *RNF-02*. El
cuello de botella principal es la llamada a Prophet, que se ejecuta bajo demanda
sin caché. En una versión futura se podría cachear el resultado durante unas
horas.

== Pruebas de usabilidad

Se pidió a tres voluntarios (dos estudiantes y un profesional del sector
financiero) que utilizaran la aplicación durante 30 minutos y respondieran un
cuestionario SUS (System Usability Scale). La puntuación media fue de *82 sobre
100*, lo que se considera "excelente". Los aspectos mejor valorados fueron:

- Interfaz limpia y responsive (Tailwind CSS).

- Tooltips explicativos en cada indicador técnico.

- Facilidad para comprar/vender en la cartera virtual.

- Internacionalización completa (español/inglés).

Como sugerencias de mejora se mencionaron:

- Añadir un modo oscuro.

- Incluir más indicadores técnicos (ATR, Ichimoku).

- Mejorar la velocidad del análisis de sentimiento en español.

== Automatización con GitHub Actions

Se configuró un workflow básico de integración continua (CI) en GitHub Actions
para ejecutar las pruebas del backend automáticamente en cada push a la rama
principal. El archivo .github/workflows/backend-tests.yml contiene:

#figure(
  ```yaml
  name: Backend Tests
  on: [push]
  jobs:
    test:
      runs-on: ubuntu-latest
      services:
        postgres:
          image: postgres:15
          env:
            POSTGRES_PASSWORD: postgres
          options: >-
            --health-cmd pg_isready
            --health-interval 10s
      steps:
        - uses: actions/checkout@v4
        - name: Install dependencies
          run: pip install -r requirements.txt
        - name: Run tests
          run: pytest
  ```,
  caption: [Workflow de GitHub Actions para pruebas del backend.],
) <code:github_actions>

Este workflow asegura que los cambios no rompan las funcionalidades existentes
antes de ser fusionados.

== Limitaciones y aspectos no probados

Debido a las limitaciones de tiempo, no se realizaron:

- Pruebas de seguridad exhaustivas (inyección SQL, XSS, CSRF). No obstante, se
utiliza SQLAlchemy que parametriza las consultas, mitigando la inyección SQL.
- Pruebas de rendimiento con alta concurrencia (más de 100 usuarios
  simultáneos).
- Pruebas automáticas completas del frontend (solo se probaron el pipe y la
directiva de tooltip).
- Pruebas de usabilidad con una muestra mayor de usuarios (solo 3 voluntarios).

A pesar de ello, los resultados obtenidos demuestran que el software es estable,
funcional y cumple con los requisitos fundamentales del proyecto.

== Conclusión de la evaluación

_FinancialPulse_ ha superado las pruebas críticas de funcionalidad, integración,
aceptación, rendimiento y usabilidad. Los errores detectados (concurrencia en
compras, validación de email duplicado, latencia del modelo en español) han sido
corregidos o están documentados como mejora futura. El sistema es usable, cumple
con los requisitos RGPD, ofrece una interfaz responsive y multilingüe, y
presenta un rendimiento aceptable en condiciones normales. Las limitaciones
conocidas se abordarán en trabajos futuros.

En el siguiente capítulo se presentan las conclusiones finales del proyecto y
las líneas de trabajo futuro.
