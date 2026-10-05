## Summary

Added the initial MoviePulse setup, including the layered project structure, the local `MPLibrary` package for shared code, network configuration, initial models, movie repository, localized API errors, color palette, dynamic typography, and reusable spacing tokens.

## Changes

- Added the initial iOS project structure using layered architecture.
- Added `MPLibrary` as a local Swift Package for shared `Common` and `Core` code.
- Added reusable design system foundations:
  - Color palette.
  - Dynamic typography.
  - Spacing and padding tokens.
- Added network configuration, API request models, endpoints, executor, and error mapping.
- Added initial domain/data models and movie repository implementation.
- Added localized API error strings.
- Added initial documentation files.

## Architecture Notes

- Shared infrastructure and UI foundations live in `MPLibrary` to keep the app target cleaner and more modular.
- The app target keeps feature, presentation, domain, and data responsibilities separated.
- Design tokens avoid hardcoded colors, font sizes, and spacing values inside views.
- Networking remains isolated from SwiftUI views and can be reused from repositories or services.

## Validation

- [ ] The project builds successfully.
- [ ] `MPLibrary` can be imported from the app target.
- [ ] API key configuration works through `LocalConfig.xcconfig`.
- [ ] Localized API error messages resolve correctly.
- [ ] Colors, fonts, and padding tokens are available from app views.

## Screenshots

Add screenshots or mockups if this PR changes UI.

## Notes

No production API keys or sensitive local configuration files should be committed.
