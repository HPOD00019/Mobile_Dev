# ChessBot - Flutter Chess Mobile App

## Project Overview

**ChessBot** is a mobile Flutter application for playing chess against an AI bot with adjustable difficulty levels (1-8). The app allows users to play offline (except for bot API calls) with a clean, minimalist interface.

### Key Features
- Bot difficulty selection (8 levels)
- Real-time chess board with drag-and-drop/tap-to-move
- Bot moves via remote API
- Game controls: Undo, Restart, Resign, Swap Color
- Local game state validation using dartchess library
- Portrait orientation, responsive design

### Authors
- Ведров Артем, Филимонов Алексей, Пылев Максим, Собенин Михаил, Кочетков Иван

---

## Technology Stack

| Component | Technology | Version |
|-----------|------------|---------|
| Language | Dart | ^3.11.0 |
| Framework | Flutter | 3.24+ |
| State Management | flutter_bloc (BLoC) | ^9.1.1 |
| DI Container | get_it + injectable | latest |
| Navigation | go_router | ^17.1.0 |
| Chess Logic | dartchess | ^0.12.2 |
| Board UI | chessground | ^9.0.0 |
| HTTP Client | dio | ^5.9.2 |
| Code Generation | freezed, dart_mappable | latest |

---

## Architecture

The project follows a **feature-first** structure with BLoC pattern for state management:

```
lib/
├── core/                    # Shared core utilities
│   ├── errors/             # Error handling
│   ├── usecases/           # Base use case classes
│   ├── utilities/          # Helpers (Result, etc.)
│   └── constants.dart      # App constants (API config)
│
├── di/                      # Dependency Injection
│   ├── injection.dart      # GetIt configuration
│   └── injection.config.dart
│
├── features/                # Feature modules
│   └── chess/
│       ├── domain/         # Business logic layer
│       │   ├── extensions/ # Domain extensions
│       │   ├── models/     # Domain models
│       │   ├── repository/ # Repository interfaces
│       │   └── usecases/   # Business use cases
│       ├── persistence/    # Data layer
│       └── presentation/   # UI layer (BLoC, widgets)
│           └── bloc/
│               └── chess_match_bloc/
│
├── routing/                 # Navigation configuration
│   ├── app_router.dart
│   └── go_router_builder.dart
│
├── ui/                      # Shared UI components
│   └── screens/
│       ├── bot_select_screen.dart
│       └── match_screen/
│
├── app.dart                 # Root widget
└── main.dart                # Entry point
```

### Architecture Layers

1. **UI Layer** - Widgets, screens, BLoC builders
2. **Logic Layer** - BLoCs, Use Cases, Handlers
3. **Data Layer** - Repositories, Services, API calls

### State Management Pattern

```
User Action → BLoC Event → Use Case → Repository/Service → API
                                      ↓
                              BLoC State Update → UI Rebuild
```

---

## Building and Running

### Prerequisites
- Flutter SDK 3.24+
- Dart SDK ^3.11.0
- Android Studio / VS Code with Flutter extensions

### Setup

```bash
cd ChessApp

# Install dependencies
flutter pub get

# Generate code (run after any @injectable, @freezed, etc. changes)
flutter pub run build_runner build --delete-conflicting-outputs

# Run on connected device/emulator
flutter run
```

### Build Commands

```bash
# Debug build
flutter run

# Release APK (Android)
flutter build apk --release

# Release IPA (iOS)
flutter build ios --release

# Run tests
flutter test

# Analyze code
flutter analyze
```

### Code Generation

The project uses multiple code generators. Run after modifying:
- `@injectable` annotated classes
- `@freezed` / `@immutable` classes
- `@TypedGoRoute` routes
- `dart_mappable` models

```bash
# Watch mode (auto-generate on changes)
flutter pub run build_runner watch

# One-time generation
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Development Conventions

### Naming Conventions

- **BLoCs**: `ChessMatchBloc`, `BotSelectBloc`
- **Events**: `MoveRequested`, `LoadMatchRequested` (past tense + -ed)
- **States**: `EmptyState`, `MatchStateActive`, `InternalError`
- **Use Cases**: `MakeMoveUsecase`, `GetSessionUsecase`
- **Repositories**: `ISessionRepository`, `IBotRepository` (I- prefix for interfaces)
- **Models**: `MatchState`, `GameSession`, `Opponent`, `Fen`
- **Screens**: `BotSelectScreen`, `MatchScreen`
- **Widgets**: Private widgets prefixed with `_` (e.g., `_OpponentCard`)

### Code Style

- Use `final class` for all classes (immutability by default)
- Pattern matching with `switch` expressions (Dart 3+)
- Constructor injection for dependencies
- `@factoryMethod` annotation for injectable BLoCs
- Use `Result<T>` pattern for error handling
- Extension methods for domain logic (e.g., `GameSessionExtensions`)

### State Management Rules

1. **BLoC** handles business logic and state transitions
2. **UI** only displays state and sends events
3. **Use Cases** encapsulate single business operations
4. **Repositories** abstract data sources (API, local storage)

### Navigation

Uses `go_router` with type-safe route data:

```dart
// Route definition
@TypedGoRoute<GameScreenRoute>(path: '/game/:sessionId')
class GameScreenRoute extends GoRouteData { ... }

// Navigation
GameScreenRoute(sessionId: id).go(context);
```

---

## Key Domain Models

### MatchState
```dart
class MatchState {
  final Chess position;        // Current board position (dartchess)
  final Side userSide;         // Player's color
  final Opponent white;        // White opponent
  final Opponent black;        // Black opponent
  final SessionId relatedSessionId;
  NormalMove? moveToPromote;   // Pending promotion move
}
```

### Opponent Hierarchy
```dart
abstract class Opponent
  ├── BotOpponent (difficulty: 1-8)
  └── HumanOpponent (profile: PlayerProfile)
```

### GameSession
```dart
class GameSession {
  final SessionId id;
  final List<Fen> history;     // FEN history for undo
  final SessionOpponent white;
  final SessionOpponent black;
}
```

---

## API Configuration

```dart
// lib/core/constants.dart
class ApiConfig {
  static const String chess_api = 'https://api.chessbot.com';
  static const int timeout = 30000;
}
```

---

## Testing Practices

- **Unit Tests**: Use cases, domain models, extensions
- **Widget Tests**: Individual widgets (chess board, opponent cards)
- **Integration Tests**: Full user flows (select bot → start game → make move)

Test files mirror source structure:
```
test/
├── features/
│   └── chess/
│       ├── domain/
│       │   ├── models/
│       │   └── usecases/
│       └── presentation/
│           └── bloc/
└── ui/
    └── screens/
```

---

## Important Implementation Notes

### Chess Move Flow
1. User makes move on board → `ChessBoard` calls `_onMoveHandle`
2. BLoC receives `MoveRequested` event
3. Check for pawn promotion → store pending move
4. `MakeMoveUsecase` validates and applies move
5. Emit new `MatchStateActive` with updated position
6. Bot response handled asynchronously

### Board Orientation
```dart
orientation: state.userSide.getBoardOrientation(state.position.turn)
```

### Dependency Injection
```dart
// Registration via annotations
@factoryMethod
class ChessMatchBloc extends Bloc<...> { ... }

// Usage
BlocProvider<ChessMatchBloc>(
  create: (context) => getIt.get<ChessMatchBloc>(),
  child: MatchScreen(...),
)
```

---

## Documentation References

- [Technical Requirements (TZ.md)](docs/TZ.md) - Full technical specification
- [Frontend Workflow](docs/dev-workflow-frontend.md) - Developer page structure
- [Backend Workflow](docs/dev-workflow-backend.md) - API integration guide
- [Navigation System](docs/nav-system.md) - PagesProvider documentation
- [Architecture Overview](docs/arch.md) - Detailed architecture diagrams

---

## Common Tasks

### Add a new feature
1. Create domain models in `features/chess/domain/models/`
2. Define repository interface in `features/chess/domain/repository/`
3. Implement use case in `features/chess/domain/usecases/`
4. Create BLoC with events/states in `features/chess/presentation/bloc/`
5. Build UI widgets in `features/chess/presentation/` or `ui/screens/`
6. Register dependencies with `@injectable`
7. Run `build_runner`

### Add a new route
1. Create screen widget in `ui/screens/`
2. Define `GoRouteData` class in `routing/go_router_builder.dart`
3. Add `@TypedGoRoute` annotation with path
4. Run `build_runner`

### Debug developer pages
The app includes developer-specific pages for parallel development. Check `dev-workflow-frontend.md` for details.
