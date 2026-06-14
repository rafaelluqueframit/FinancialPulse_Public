= Software desarrollado

En este capítulo se describe el software implementado y el papel que tuvo la
Inteligencia Artificial Generativa (IAG), en concreto la aproximación que se
denomina "vibe coding": IAG como asistente de desarrollo, no como sustituto del
desarrollador. Se explica dónde y cómo se utilizó la IAG, qué resultados generó
y cuáles fueron las comprobaciones y adaptaciones humanas posteriores. Se
detallan los endpoints principales de la API REST, los servicios del frontend y
las vistas más relevantes. Finalmente, se reflexiona sobre las buenas prácticas,
limitaciones y aprendizajes derivados del uso de IAG en el desarrollo de
FinancialPulse.

== Enfoque general y principio de uso de la IAG

Definición breve: por "vibe coding" se entiende un flujo de trabajo en el que la
IAG se usa para acelerar tareas concretas (scaffolding, refactorings, generación
de ejemplos de uso, propuestas de tests, documentación y ayuda en prompts),
manteniendo siempre la validación, revisión y adaptación manual por parte del
autor.

Reglas aplicadas durante el desarrollo:

- La IAG se usa para proponer, no para decidir: cada fragmento sugerido se
  revisó, se probó y se integró únicamente si cumplía los requisitos de
  fiabilidad y seguridad.
- Documentación de la trazabilidad: cuando un cambio importante derivó de una
  sugerencia de IAG, se anotó en el commit message y en comentarios de código
  para dejar constancia del origen y la intención.
- Seguridad y secretos: nunca se incorporaron claves ni contraseñas reales en
  los fragmentos generados por IAG; las rutas sensibles y valores por defecto se
  extrajeron a ficheros de configuración (`.env`) y a
  `doc/Chapters/apendices.typ`.
- Validación automática y manual: tras aceptar una sugerencia, se ejecutaron
  linters, pruebas unitarias o scripts de comprobación, y se realizó una
  revisión manual (smoke tests, pruebas con Thunder Client y revisión de logs).

== Ámbitos donde la IAG aportó valor

- Plantillas y scaffolding: generación inicial de esqueletos de endpoints,
  clases de modelo y servicios Angular para acelerar la creación de la
  estructura del proyecto.
- Refactorizaciones y optimizaciones: propuestas para simplificar consultas
  SQLAlchemy en `backend/app.py`, extracción de funciones repetidas y mejora de
  nombres y docstrings para facilitar mantenimiento.
- Escritura de pruebas y casos de uso: generación de ejemplos de pruebas
  unitarias y scripts de integración para comprobar comportamientos clave
  (endpoints críticos como registro, login y compra/venta).
- Documentación técnica y snippets para la memoria: redacción y mejora de textos
  en los ficheros `doc/` (por ejemplo, el Apéndice D) que posteriormente se
  revisaron y adaptaron.

== Flujo de trabajo habitual cuando empleé IAG

1. Solicitud / prompt: definir claramente el objetivo (scaffolding, refactor,
  ejemplo de test, explicación de un algoritmo).
2. Generación: la IAG devuelve una o varias propuestas.
3. Revisión humana: leer línea a línea, comprobar supuestos (tipos, excepciones,
  requisitos de librerías) y ajustar estilos y nombres según las convenciones
  del proyecto.
4. Pruebas: ejecutar pruebas unitarias y smoke tests; si procede, ejecutar
  `typst compile` para comprobar la generación de documentación.
5. Integración: añadir los cambios en una rama, crear un commit con mensaje
  explicativo que deje constancia del uso de IAG y abrir PR para revisión.

== Ejemplos concretos y archivos relevantes

Backend: `backend/app.py`

- Contexto: `app.py` contiene los modelos SQLAlchemy, la inicialización de la
  app, y los endpoints principales (registro, login, dashboard, predicción,
  noticias, cartera, favoritos, etc.).
- Uso de IAG: la IAG ayudó a proponer estructuras de endpoints y a generar
  versiones iniciales de funciones complejas (por ejemplo, preprocesado de datos
  para Prophet o plantillas para manejo de tokens de recuperación). En todos los
  casos el código sugerido fue revisado —se comprobó la lógica de negocio, los
  casos de borde y la gestión de errores— antes de integrarlo.
- Validaciones realizadas: ejecución de los endpoints con Thunder Client,
  pruebas locales de la carga de modelos (transformers y Prophet), comprobación
  de la correcta creación de tablas (`db.create_all()`) y verificación de que no
  se introducían dependencias innecesarias en `requirements.txt`.

Frontend: `frontend/src/app/...` (servicios y componentes)

- Contexto: los servicios como `AuthService`, `market.service.ts` y
  `dashboard.service.ts` centralizan las llamadas al backend y la lógica de
  presentación de datos en el cliente.
- Uso de IAG: se utilizaron sugerencias para generar métodos `HttpClient`,
  formularios reactivos y patrones de manejo de errores; posteriormente los
  snippets se adaptaron a las rutas reales definidas en `backend/app.py` y a las
  necesidades del UX (por ejemplo, mensajes de error traducidos en
  `assets/i18n`).
- Validaciones: pruebas manuales en el navegador, verificación de la
  internacionalización (`assets/i18n/en.json` y `es.json`) y revisión de la
  accesibilidad básica (labels, tab order) en componentes críticos.

Documentación y tipado: `doc/`

- La IAG ayudó a redactar descripciones técnicas, resúmenes y explicaciones (por
  ejemplo, para la memoria y los apéndices). Todas las secciones generadas se
  revisaron para garantizar coherencia con el código real y las decisiones
  tomadas (por ejemplo, la extracción de ejemplos de despliegue a
  `doc/Chapters/apendices.typ`).

== Endpoints principales

La siguiente Tabla 6.1 resume los endpoints más relevantes, con su método HTTP y
una breve descripción de lo que hacen.

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

== Buenas prácticas y limitaciones detectadas

- No confiar en las salidas como correctas por defecto: la IAG es muy útil para
  acelerar creación y documentación, pero puede proponer soluciones con
  supuestos incorrectos o usar APIs deprecadas; siempre verificar.
- Rastrabilidad: mantener registros (commits, PRs, mensajes) que indiquen qué
  partes fueron generadas o inspiradas por la IAG y qué cambios se aplicaron
  después de la revisión humana.
- Privacidad y secretos: no introducir valores secretos en prompts; usar
  variables de entorno y centralizar configuraciones en `.env` y en
  `doc/Chapters/apendices.typ` para evitar fugas en la memoria.

== Conclusión

He usado la IAG como una herramienta que incrementa la productividad —para
generar ideas, acelerar tareas repetitivas y mejorar la documentación—, pero
siempre complementada por revisión técnica, pruebas y sentido crítico. El
resultado ha sido código mejor documentado y una velocidad de desarrollo
superior, sin renunciar a la responsabilidad y la trazabilidad en todo momento.

En general, el software desarrollado cumple con los objetivos planteados, aunque
siempre hay margen de mejora. La IAG ha sido una herramienta valiosa para
acelerar el desarrollo, pero la revisión humana ha sido esencial para garantizar
la calidad y seguridad del código.

Los ficheros clave para entender la implementación son `backend/app.py`, los
servicios del frontend en `frontend/src/app/services/` y la documentación en
`doc/Chapters/apendices.typ`.

El código fuente está en GitHub
(https://github.com/rafaelluqueframit/FinancialPulse.git). El siguiente capítulo
presenta las pruebas realizadas y la validación del software.
