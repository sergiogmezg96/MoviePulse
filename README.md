# MoviePulse

MoviePulse es una aplicación iOS en SwiftUI para explorar películas populares, consultar su detalle y mantener una colección local de favoritos y títulos guardados. El proyecto está organizado con Clean Architecture, MVI en las pantallas principales y coordinadores para aislar la navegación de las vistas.

## Funcionalidades actuales

- Carga de películas populares desde [TMDb](https://developer.themoviedb.org/docs/getting-started).
- Home con película destacada y secciones por género.
- Búsqueda local sobre el catálogo descargado, presentada en una hoja modal.
- Vista de género con filtros de interfaz.
- Detalle de película.
- Favoritos y «Mi lista» persistidos localmente con `UserDefaults`.
- Estados de carga, contenido, vacío y error en los flujos que consultan datos.

Las pestañas activas son **Inicio** y **Mi lista**. Las definiciones de «Explorar» y «Descargas» existen en el modelo de pestañas, pero todavía no se exponen como flujos de la aplicación.

## Requisitos y configuración

- Xcode con soporte para SwiftUI y Swift Concurrency.
- Una API key de TMDb.

La key no se versiona. Copia `MoviePulse/Config/LocalConfig.example.xcconfig` como `LocalConfig.xcconfig` y configura el valor local:

```xcconfig
TMDB_API_KEY = tu_api_key_de_tmdb
```

La aplicación obtiene este valor mediante `MoviePulseConfiguration`, que admite `TMDBAPIKey` y `TMDB_API_KEY` en el `Info.plist` resultante. Si falta la key, las solicitudes remotas no podrán autenticarse.

El esquema de pruebas está incluido en el proyecto Xcode.

## Arquitectura actual

La estructura del proyecto es la siguiente:

```text
MoviePulse/
├── App/                    # Arranque, composición y navegación raíz
├── Common/                 # Configuración y constantes de la aplicación
├── Data/                   # Repositorio, DTOs y persistencia concreta
├── Domain/                 # Modelos, contratos y casos de uso
├── Presentation/           # Vistas SwiftUI, MVI, stores, mappers y coordinadores
├── Resource/               # Recursos y localización
└── Packages/MPLibrary/     # Componentes UI y utilidades compartidas
```

La composición de dependencias se concentra en `AppDependencyContainer`. Crea el repositorio concreto, construye los casos de uso y proporciona los stores y coordinadores que necesita cada flujo. Las vistas no crean repositorios ni casos de uso directamente.

La dirección deseada de dependencias es:

```text
Presentation ──> Domain <── Data
       ▲
       └──────── App ───────┘
```

- **Domain** define `MovieRepository`, modelos y casos de uso.
- **Data** implementa el contrato con `MovieRepositoryImpl`: consulta la API de TMDb y guarda favoritos y títulos de «Mi lista» mediante `UserDefaults` codificado con `Codable`.
- **Presentation** adapta los datos a la UI, mantiene el estado de cada pantalla y emite efectos de navegación.
- **App** es el punto de composición y posee el coordinador raíz.

### Persistencia y red

`MovieRepositoryImpl` es actualmente la única implementación de `MovieRepository`. Reúne dos responsabilidades de infraestructura: la consulta de películas populares en TMDb y la persistencia local de favoritos y «Mi lista». La persistencia evita duplicados y permite consultar elementos por identificador.

Los casos de uso encapsulan estas operaciones para que los stores no dependan de la implementación del repositorio: obtener películas, guardar/eliminar favoritos, guardar/eliminar títulos de la lista y recuperar colecciones o elementos individuales.

## Navegación

La navegación está centralizada y no se construye desde las vistas:

```text
MoviePulseApp
  └─ AppCoordinator
      ├─ NavigationStack raíz y ruta compartida
      ├─ HomeCoordinator
      │   ├─ Home
      │   ├─ Search (sheet)
      │   ├─ Genre
      │   └─ Movie detail
      └─ MyListCoordinator
          └─ Movie detail
```

`AppCoordinator` mantiene la pestaña seleccionada y un único `navigationPath`. `HomeCoordinator` y `MyListCoordinator` construyen las vistas de sus rutas y actúan como manejadores de efectos. Cada uno conserva sus stores de raíz para preservar el estado del flujo mientras se cambia de pestaña.

Home puede abrir la búsqueda en un `sheet`, el detalle de una película o una sección de género. «Mi lista» puede abrir el detalle. Las vistas sólo emiten intents; un efecto de presentación llega al coordinador, que modifica la ruta o cierra la pantalla.

## MVI en Presentation

Las pantallas **Home**, **Movie Detail**, **My List** y **Genres** siguen el mismo flujo base:

```text
View → Intent → Reducer → State + Command/Effect
                              ├─ Command → Store → Use case → Intent
                              └─ Effect  → Coordinator
```

- **Intent** representa una interacción o un resultado asíncrono.
- **Reducer** es una función sin efectos que transforma el estado y devuelve una transición.
- **State** contiene la información necesaria para renderizar la pantalla.
- **Command** representa trabajo de presentación que ejecuta el store: cargar contenido o actualizar favoritos/listas.
- **Effect** representa una consecuencia de una sola vez, como abrir el detalle o volver atrás; el coordinador la consume.
- **Store** está aislado en `@MainActor`, es observable con `@Observable` y orquesta comandos, casos de uso y nuevos intents.

Este enfoque mantiene las `View` declarativas: observan `state`, despachan `process(_:)` y no contienen reglas de negocio ni navegación imperativa.

La búsqueda utiliza un `SearchStore` y un `SearchViewState`: reutiliza el catálogo cargado y filtra localmente por título antes de emitir los efectos de cierre o apertura de detalle.

## Testing actual

Hay pruebas unitarias para:

- Los casos de uso de favoritos y «Mi lista», usando un repositorio espía.
- `MovieRepositoryImpl`, incluida la persistencia, ausencia de datos, duplicados, borrados y datos persistidos inválidos.

## Próximos pasos

1. Ampliar los endpoints de TMDb para búsqueda remota, detalle enriquecido y filtros avanzados por género.
2. Añadir cobertura a reducers, stores y flujos de navegación.
3. Incorporar nuevas fuentes de datos según evolucionen las funcionalidades de la aplicación.

## Firebase e IA

Firebase y las recomendaciones basadas en IA no forman parte de la implementación actual. Se abordarán en una fase posterior y deberán entrar mediante protocolos y casos de uso, manteniendo `Presentation` ajena al proveedor concreto. Posibles casos de uso futuros incluyen autenticación, sincronización remota de favoritos/listas y recomendaciones personalizadas.
