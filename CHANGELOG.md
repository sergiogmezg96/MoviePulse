# Changelog

Todos los cambios relevantes de MoviePulse se documentaran en este archivo.

El formato sigue una estructura sencilla basada en versiones y fechas para mantener trazabilidad durante el desarrollo del proyecto.

## [1.0.3] - 2026-10-19

### Added

- Pruebas unitarias para los casos de uso de favoritos y Mi lista mediante un repositorio espia.
- Pruebas de `MovieRepositoryImpl` para persistencia local, colecciones vacias, consultas por identificador, duplicados, borrados y datos almacenados invalidos.
- Fixtures reutilizables de peliculas y un spy de repositorio para aislar las pruebas de Domain y Data.
- Configuracion del esquema de Xcode para incluir el target de pruebas de MoviePulse.

### Changed

- README actualizado con las funcionalidades implementadas, la composicion de dependencias, la navegacion basada en coordinadores y el flujo MVI actual.
- Documentacion de configuracion de TMDb, persistencia local, cobertura de pruebas y siguientes evoluciones del proyecto.

---

## [1.0.2] - 2026-10-16

### Added

- Buscador de peliculas en Home con interfaz, estados MVI y filtrado por titulo sobre el contenido cargado.
- Componente reutilizable `SearcherItemView` en MPLibrary para desacoplar la UI de busqueda de las features.
- Navegacion centralizada mediante `AppCoordinator`, separando el enrutado de la vista raiz de la aplicacion.
- Coordinador especifico para Mi lista, con navegacion al detalle desde sus resultados.
- Arquitectura MVI completa para Generos, Detalle de pelicula y Mi lista: intents, estados, efectos, comandos y reducers.
- Filtros para Mi lista y mapper dedicado para transformar favoritos en el modelo de presentacion.
- Constantes de aplicacion centralizadas y reubicacion de la configuracion comun fuera de la capa App.
- Nuevas cadenas localizadas para el buscador y los flujos actualizados.

### Changed

- Refactorizacion de Home a una estructura MVI mas explicita, con reducer, efectos y comandos que separan la reduccion de estado de las acciones con efectos secundarios.
- Reorganizacion de las vistas, estados, intents y mappers de Home, Generos, Detalle y Mi lista en carpetas por responsabilidad (`MVI`, `View`, `Mapper`, `Storage` y `Coordinator`).
- Actualizacion de los stores de Home, Detalle y Mi lista para delegar las transiciones de estado en sus reducers y mantener las vistas declarativas.
- Simplificacion de la composicion de la tab bar y de la vista raiz, delegando la navegacion de aplicacion en el coordinador correspondiente.
- Mejora del componente de listado de generos de MPLibrary para alinearlo con el nuevo flujo de presentacion.
- Actualizacion de la dependencia de MPLibrary necesaria para los componentes de busqueda reutilizables.

---

## [1.0.1] - 2026-10-05

### Added

- Estructura inicial del proyecto iOS con SwiftUI.
- Organizacion base por capas siguiendo Clean Architecture: App, Common, Data, Domain y Presentation.
- Base de presentacion MVI para la pantalla inicial.
- Modelos iniciales de pelicula en Domain y Data alineados con la respuesta de TMDb.
- Construccion reutilizable de URLs para endpoints de TMDb.
- README inicial con objetivo del proyecto, arquitectura, uso de TMDb, Firebase futuro y roadmap.
- Sustitucion del template inicial de SwiftData por una base propia preparada para crecer por features.
- Limpieza de referencias iniciales de ejemplo a SwiftData, Item y ContentView.
- Navegacion inicial con `NavigationStack`, coordinador de Home y composicion desde `AppDependencyContainer`.
- Tab bar propia con acceso a Home y Mi lista, dejando fuera las pestañas sin pantalla funcional.
- Pantalla de detalle de pelicula con estado MVI, favorito local, gestion de Mi lista y navegacion de vuelta.
- Pantalla de generos con grid de peliculas, filtros por peliculas, mejor valoradas y anadidas recientemente.
- Pantalla de Mi lista con carga local, estado vacio, filtros y apertura de detalle.
- Persistencia local en `UserDefaults` para favoritos y Mi lista.
- Casos de uso para guardar, eliminar y consultar favoritos y peliculas de Mi lista.
- Componentes reutilizables de UI para tab bar, cabecera de navegacion, imagen remota, imagen de cabecera, botones, chips y tarjetas de pelicula.
- Localizaciones y recursos visuales necesarios para las pantallas nuevas.
- Estado visual de Mi lista en Home con `checkmark` y texto de anadido cuando la pelicula destacada ya esta guardada.
- Intent de toggle para anadir o eliminar la pelicula destacada de Mi lista desde Home.
- Soporte en `MPNavigationHeaderBar` para ocultar el boton derecho cuando una pantalla no tiene accion trailing.
- Centralizacion de nuevos stores y casos de uso en `AppDependencyContainer`.
- Disenos actualizados de Home, Detalle, Generos y Mi lista.
- Ocultacion de acciones sin logica implementada: buscador, perfil, puntuar, Browse y Downloads.
- Comentarios en los intents/casos asociados a buscador, perfil y puntuar hasta que exista su flujo real.

---
