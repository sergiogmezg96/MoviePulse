# MoviePulse

MoviePulse es un proyecto iOS en Swift y SwiftUI creado para consolidar fundamentos de arquitectura como desarrollador iOS: Clean Architecture, MVI, modularización básica por capas, consumo de API, manejo de errores y testing unitario.

El objetivo del repositorio es servir como proyecto técnico completo y entregable antes del cierre de 2026, documentando decisiones, ventajas, inconvenientes y sensaciones de ergonomía al trabajar con MVI frente a MVVM.

## Por qué TMDb

La primera fuente de datos real del proyecto será [The Movie Database API](https://developer.themoviedb.org/docs/getting-started). TMDb encaja especialmente bien porque permite construir flujos claros y progresivos:

- Listado de películas populares.
- Búsqueda por texto.
- Detalle de película.
- Imágenes, géneros, reparto y metadatos.
- Estados de carga, error, vacío y contenido.

La API requiere una key gratuita desde la cuenta de TMDb. Esa key no debe subirse al repositorio; se incorporará mediante configuración local o variables de entorno cuando se implemente la capa de red real.

## Arquitectura

MoviePulse se plantea como una app iOS construida con Clean Architecture y MVI. La idea es separar bien reglas de negocio, origen de datos y presentación para que cada parte pueda evolucionar sin arrastrar al resto del sistema.

La organización principal es:

- `App`: punto de entrada, configuración inicial y composición de dependencias.
- `Presentation`: vistas SwiftUI, modelos de UI, estados, intents y stores MVI.
- `Domain`: entidades de negocio, contratos de repositorio y casos de uso.
- `Data`: implementaciones concretas de repositorios, clientes remotos/locales, modelos de respuesta y mappers.
- `Core`/`Common`: utilidades transversales, componentes compartidos, errores, networking base y soporte común de la app.

La dirección de dependencias buscada es:

```text
Presentation -> Domain <- Data
App -> Presentation / Domain / Data
```

`Domain` debe ser la capa más estable. Define qué necesita la aplicación mediante protocolos y casos de uso, pero no debería conocer SwiftUI, DTOs, clientes HTTP, Firebase, persistencia local ni detalles visuales. `Data` se encarga de cumplir esos contratos y traducir modelos externos a modelos de dominio. `Presentation` consume casos de uso y transforma el resultado en estado preparado para pintar en SwiftUI.

Esta separación permite:

- Cambiar TMDb por otra API sin reescribir las pantallas.
- Sustituir persistencia local, Firebase o cualquier proveedor externo sin contaminar el dominio.
- Testear casos de uso, stores y mappers de forma aislada.
- Mantener las vistas declarativas y centradas en renderizar estado.
- Reducir el acoplamiento entre funcionalidades a medida que el proyecto vaya creciendo.

### Composición de dependencias

La creación de repositorios, casos de uso y stores se concentra en `AppDependencyContainer`. Este contenedor actúa como punto de composición: conoce las implementaciones concretas y las inyecta donde son necesarias. Así se evita que una vista cree directamente repositorios, clientes HTTP o servicios externos.

El objetivo es que las dependencias entren desde fuera y que cada pieza declare lo que necesita mediante inicializadores. Esto mejora la testabilidad y evita dependencias globales difíciles de sustituir.

### Estado actual de la arquitectura

El proyecto ya contiene la base de capas principales:

- Casos de uso en `Domain/UseCases`.
- Contratos en `Domain/Repository`.
- Implementaciones en `Data/Repository`.
- Pantallas en `Presentation`.
- Stores MVI para Home y Movie Detail.
- Composición de dependencias en `App`.

Como deuda técnica conocida, la navegación todavía no se considera parte de la arquitectura limpia definitiva. Ahora mismo está resuelta con herramientas propias de SwiftUI dentro de la capa `App`/`Presentation`, y más adelante debería evolucionar hacia coordinadores para separar mejor el flujo de navegación de las vistas.

También se debe seguir vigilando que `Domain` no reciba modelos propios de `Presentation`. Si una funcionalidad necesita guardar o recuperar información que hoy nace como modelo de UI, la solución a largo plazo debería ser mover ese contrato a modelos de dominio y hacer el mapping en la capa correspondiente.

## MVI

MoviePulse usa MVI como patrón de presentación. Cada pantalla se organiza alrededor de cuatro piezas:

- `Intent`: enum con las acciones explícitas que pueden ocurrir en la pantalla.
- `ViewState`: estructura que representa todo lo que la vista necesita para renderizarse.
- `Store`: objeto observable que recibe intents, ejecuta casos de uso y publica nuevos estados.
- `View`: componente SwiftUI declarativo, responsable de pintar el estado y enviar intents.

El flujo buscado es unidireccional:

```text
View -> Intent -> Store -> UseCase -> State -> View
```

La vista no decide reglas de negocio ni coordina operaciones complejas. Cuando el usuario interactúa con la pantalla o ocurre un evento del ciclo de vida, la vista envía un intent al store. El store interpreta esa acción, ejecuta los casos de uso necesarios y actualiza el estado. SwiftUI observa ese cambio y vuelve a pintar la vista.

### Por qué MVI en vez de MVVM

MVVM es un patrón muy natural en iOS y puede ser suficiente para pantallas simples. En este proyecto no se elige MVI porque MVVM esté mal, sino porque MVI encaja mejor con lo que se quiere practicar: trazabilidad, control de estado y pantallas fáciles de razonar.

Las razones principales son:

- Las acciones quedan centralizadas en enums de `Intent`. Esto hace más fácil filtrar, buscar y entender qué puede ocurrir en una pantalla: `viewDidAppear`, `submitSearch`, `toggleFavorite`, `toggleMyList`, `goBack`, etc.
- El estado completo vive en un único `ViewState`. En lugar de tener muchos `@Published` independientes que pueden cambiar en momentos distintos, la pantalla trabaja con una representación única y coherente.
- El store concentra la transición entre acción y estado. Esto facilita seguir el recorrido de una interacción: qué intent llega, qué caso de uso se ejecuta y qué estado nuevo se publica.
- SwiftUI encaja muy bien con esta idea porque las vistas son una función del estado. Si cambia el estado, cambia la UI. La vista no necesita conocer el detalle de la operación que produjo ese estado.
- Los estados de carga, error, vacío y contenido se modelan de forma más predecible. Esto es especialmente útil en pantallas con llamadas async, búsqueda, favoritos, listas guardadas y detalle de película.
- La testabilidad mejora porque se puede validar el store enviando intents y comprobando estados resultantes, sin depender de la vista.

Frente a MVVM, MVI reduce la dispersión de comportamiento. En MVVM es habitual que un ViewModel crezca con varias propiedades observables y métodos públicos, lo que puede hacer más difícil saber qué acciones reales soporta la pantalla y qué combinaciones de estado son válidas. Con MVI, las acciones están acotadas por el enum de intents y el resultado visible se agrupa en un solo state.

El coste de MVI es que introduce algo más de complejidad: más tipos, más nombres y una estructura algo más estricta. En MoviePulse se acepta ese coste porque ayuda a mantener pantallas previsibles, fáciles de depurar y alineadas con Clean Architecture. La regla será aplicarlo de forma pragmática: stores pequeños, intents claros, estados expresivos y sin sobreingeniería.

### Desventajas frente a MVVM

MVI no siempre es la opción más cómoda. Para pantallas pequeñas o con muy poca interacción, MVVM puede ser más directo porque requiere menos estructura y permite avanzar con menos archivos. En MVI, incluso una pantalla sencilla suele necesitar intent, state y store, por lo que el coste inicial es mayor.

También exige más disciplina. Si el store empieza a acumular demasiadas responsabilidades, puede acabar convirtiéndose en un punto central demasiado grande. Por eso la lógica de negocio debe seguir en `Domain`, las transformaciones deben apoyarse en mappers cuando tenga sentido y el store debe limitarse a coordinar la lógica de presentación.

Otro inconveniente es que algunos cambios visuales muy simples pueden parecer más largos de implementar, ya que pasan por el flujo intent/state en lugar de modificar una propiedad observable concreta. En este proyecto se acepta esa desventaja porque se prioriza la trazabilidad y la consistencia del estado por encima de la rapidez en cambios puntuales.

### Responsabilidades dentro de Presentation

Dentro de `Presentation`, las responsabilidades se reparten así:

- La `View` pinta el `ViewState` y emite `Intent`.
- El `Store` contiene la lógica de presentación y orquesta casos de uso.
- Los `UseCases` pertenecen a `Domain` y encapsulan acciones de negocio.
- Los mappers convierten modelos de dominio en modelos preparados para UI cuando la pantalla lo necesita.

Con esta división, una vista SwiftUI debería mantenerse ligera. No debería crear repositorios, construir requests de red, guardar favoritos directamente ni decidir reglas de negocio. Su papel es declarar la interfaz a partir del estado y delegar acciones al store.

## Firebase e IA

Firebase no se integrará en la primera fase. Se reserva para hitos posteriores:

- Autenticación.
- Favoritos sincronizados.
- Base de preferencias del usuario.
- Recomendaciones personalizadas.

Las recomendaciones inteligentes se plantearán sobre los favoritos, géneros y descripciones de películas. La opción preferente será mantener la lógica desacoplada mediante casos de uso y protocolos para poder evolucionar entre Firebase, Core ML o modelos nativos de Apple sin contaminar Presentation ni Domain.

## Roadmap

1. Crear estructura base Clean Architecture + MVI y documentación inicial.
2. Implementar cliente TMDb, endpoints, DTOs y mappers.
3. Crear pantalla de películas populares con estados MVI.
4. Añadir búsqueda y detalle de película.
5. Incorporar manejo de errores y estados vacíos.
6. Añadir testing unitario de casos de uso, stores y mappers.
7. Integrar Firebase para autenticación y favoritos.
8. Explorar recomendaciones inteligentes basadas en gustos.

## Estado actual

El proyecto ya cuenta con una base funcional de arquitectura por capas, consumo inicial de TMDb para películas populares, stores MVI en las primeras pantallas y persistencia local básica para favoritos/lista. Firebase e IA siguen fuera de la primera fase.

La prioridad actual es seguir cerrando funcionalidades manteniendo la separación entre capas: dominio estable, datos reemplazables, presentación declarativa y stores responsables de transformar intents en estados.
