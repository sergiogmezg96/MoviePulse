# Changelog

Todos los cambios relevantes de MoviePulse se documentaran en este archivo.

El formato sigue una estructura sencilla basada en versiones y fechas para mantener trazabilidad durante el desarrollo del proyecto.

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
