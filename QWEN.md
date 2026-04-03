# ChessBot — Mobile Chess App (Flutter)

## Project Overview

**ChessBot** is a mobile Flutter application for playing classical chess against an AI bot with configurable difficulty levels (1–8). The app is designed for chess enthusiasts who want to play anytime without needing online matchmaking or registration.

### Key Features
- Difficulty selection screen with 8 bot levels
- Full chess game screen with drag-and-drop/tap-to-move board
- Bot move integration via server-side API
- Game controls: Undo, Restart, Resign, Swap Colors
- Local game-end detection (checkmate, stalemate, draw)
- Dark/light theme support (system-based)
- Portrait orientation only, adaptive design

### Tech Stack
| Component | Technology |
|-----------|------------|
| **Language** | Dart ^3.11.0 |
| **Framework** | Flutter 3.24+ |
| **DI Container** | `get_it` + `injectable` |
| **State Management** | `provider` (ChangeNotifier) + `bloc`/`flutter_bloc` |
| **Navigation** | `go_router` |
| **Chess Logic** | `dartchess` ^0.12.2 |
| **Board UI** | `chessground` ^9.0.0 |
| **HTTP Client** | `dio` ^5.9.2 |
| **Code Generation** | `dart_mappable`, `freezed`, `go_router_builder`, `injectable_generator` |
| **Linting** | `flutter_lints` |

### Architecture

The app follows a **feature-first layered architecture** with CQRS/Mediator patterns:

```
lib/
├── core/                 # Shared utilities, constants, errors, usecases
├── di/                   # Dependency injection (get_it + injectable)
├── features/
│   └── chess/
│       ├── domain/       # Models, repository interfaces, use cases
│       ├── persistence/  # Data sources, API services
│       ├── presentation/ # BLoCs, screens, widgets
│       └── errors/       # Error types and handling
├── routing/              # go_router configuration (code-generated)
├── ui/                   # Shared UI components
├── app.dart              # MaterialApp.router setup
└── main.dart             # Entry point
```

**Data Flow:**
```
UI → Command/Event → BLoC/Handler → Service/Repository → API
↓
State Update → UI Rebuild
```

## Building and Running

### Prerequisites
- Flutter SDK 3.24+
- Dart SDK ^3.11.0
- Android SDK (for Android builds) or Xcode (for iOS builds)

### Setup
```bash
cd ChessApp
flutter pub get
```

### Run Code Generation
After adding/modifying models, DI registrations, or routes:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Or for continuous watching during development:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Run the App
```bash
# Connected device or emulator
flutter run

# Specific platform
flutter run -d android
flutter run -d ios
```

### Build for Release
```bash
# Android APK (split per ABI)
flutter build apk --split-per-abi

# Android App Bundle (release)
flutter build appbundle --release

# iOS
flutter build ios
```

### Linting and Analysis
```bash
# Format check
dart format --set-exit-if-changed .

# Static analysis
flutter analyze --fatal-infos
```

### Testing
```bash
# Run all tests
flutter test

# With coverage
flutter test --coverage --test-randomize-ordering-seed random
```

### CI/CD
The project uses Gitflic CI (`.gitflic-ci.yaml`) with three stages:
1. **analyze** — format check + `flutter analyze`
2. **test** — `flutter test` with coverage
3. **build** — APK/AppBundle (on `develop` or `master` branches)

## Development Conventions

### Code Generation
The project relies heavily on code generation for:
- **DI registration** — `@injectable`, `@lazySingleton`, `@singleton` annotations in `lib/di/`
- **Data models** — `dart_mappable` and `freezed` for immutable value classes
- **Routing** — `go_router_builder` for type-safe route definitions

Always run `build_runner` after adding annotations.

### Dependency Injection
- Use `getIt<Service>()` for resolving dependencies
- Annotate classes with `@injectable` (transient), `@lazySingleton`, or `@singleton`
- DI is initialized in `main.dart` via `injectDependencies()` before `runApp()`

### State Management
- **BLoC** (`bloc`/`flutter_bloc`) for feature-level business logic
- **Provider** (ChangeNotifier) for UI-only state (loading, errors, dialogs)
- Handlers/services do **not** use ChangeNotifier

### Navigation
- Uses `go_router` with code-generated route definitions
- Routes defined in `lib/routing/`
- No `BuildContext` required for navigation

### Linting
- `flutter_lints` with `--fatal-infos` in CI
- Follow Dart/Flutter style conventions
- Format with `dart format` before committing

### Testing
- Unit tests expected for domain logic (use cases, services, handlers)
- Widget tests for presentation layer components
- Coverage artifacts collected in CI

### Platform Support
- Android 8.0+ (API 26+)
- iOS 12.0+
- Phones and tablets (portrait only)

## Authors
- Ведров Артем
- Филимонов Алексей
- Пылев Максим
- Собенин Михаил
- Кочетков Иван

## License
MIT License — see [LICENSE.md](LICENSE.md)
