# MoviePulse

MoviePulse es un proyecto iOS en Swift y SwiftUI creado para consolidar fundamentos de arquitectura como desarrollador iOS: Clean Architecture, MVI, modularizacion basica por capas, consumo de API, manejo de errores y testing unitario.

El objetivo del repositorio es servir como proyecto tecnico completo y entregable antes del cierre de 2026, documentando decisiones, ventajas, inconvenientes y sensaciones de ergonomia al trabajar con MVI frente a MVVM.

## Por que TMDb

La primera fuente de datos real del proyecto sera [The Movie Database API](https://developer.themoviedb.org/docs/getting-started). TMDb encaja especialmente bien porque permite construir flujos claros y progresivos:

- Listado de peliculas populares.
- Busqueda por texto.
- Detalle de pelicula.
- Imagenes, generos, reparto y metadatos.
- Estados de carga, error, vacio y contenido.

La API requiere una key gratuita desde la cuenta de TMDb. Esa key no debe subirse al repositorio; se incorporara mediante configuracion local o variables de entorno cuando se implemente la capa de red real.

## Arquitectura

La app se organizara con Clean Architecture:

- `Presentation`: vistas SwiftUI, estados, intents y stores MVI.
- `Domain`: entidades, contratos de repositorio y casos de uso.
- `Data`: cliente HTTP, endpoints, DTOs, mappers y repositorios concretos.
- `Core`: errores, configuracion y utilidades compartidas.
- `App`: punto de entrada y composicion de dependencias.

La regla principal es que las capas internas no dependan de detalles externos. La UI no conocera DTOs, Firebase ni clientes HTTP. El dominio definira contratos y la capa de datos aportara implementaciones.

## MVI

MoviePulse usara MVI como patron de presentacion. Cada pantalla tendra:

- `Intent`: acciones explicitas del usuario o del ciclo de vida.
- `ViewState`: estado completo que necesita la vista.
- `Store`: responsable de procesar intents, ejecutar casos de uso y publicar nuevo estado.
- `View`: declarativa, ligera y sin logica de negocio.

Frente a MVVM, MVI aporta trazabilidad y estados mas predecibles, especialmente en pantallas con busqueda, carga, errores y acciones encadenadas. Como inconveniente, puede introducir mas tipos y algo mas de ceremonia, por lo que se aplicara con una estructura simple y consistente.

## Firebase e IA

Firebase no se integrara en la primera fase. Se reserva para hitos posteriores:

- Autenticacion.
- Favoritos sincronizados.
- Base de preferencias del usuario.
- Recomendaciones personalizadas.

Las recomendaciones inteligentes se plantearan sobre los favoritos, generos y descripciones de peliculas. La opcion preferente sera mantener la logica desacoplada mediante casos de uso y protocolos para poder evolucionar entre Firebase, Core ML o modelos nativos de Apple sin contaminar Presentation ni Domain.

## Roadmap

1. Crear estructura base Clean Architecture + MVI y documentacion inicial.
2. Implementar cliente TMDb, endpoints, DTOs y mappers.
3. Crear pantalla de peliculas populares con estados MVI.
4. Anadir busqueda y detalle de pelicula.
5. Incorporar manejo de errores y estados vacios.
6. Anadir testing unitario de casos de uso, stores y mappers.
7. Integrar Firebase para autenticacion y favoritos.
8. Explorar recomendaciones inteligentes basadas en gustos.

## Estado actual

Base inicial del proyecto. Todavia no hay integracion real con TMDb, Firebase ni IA. La prioridad es dejar una estructura limpia, mantenible y preparada para crecer sin romper responsabilidades entre capas.
