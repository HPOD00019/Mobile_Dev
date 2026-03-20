# Sprint 1.0.0 — Environment Setup & Architecture Foundation

**Goal:** Set up the development environment, configure all dependencies, establish the folder structure according to the architecture, and verify that all components work correctly.

---

## Table of Contents

1. [Prerequisites](#1-prerequisites)
2. [Step 1: Install Dependencies](#2-step-1-install-dependencies)
3. [Step 2: Create Folder Structure](#3-step-2-create-folder-structure)
4. [Step 3: Configure Dependency Injection](#4-step-3-configure-dependency-injection)
5. [Step 4: Create Sample Components](#5-step-4-create-sample-components)
6. [Step 5: Build & Verify](#6-step-5-build--verify)
7. [Definition of Done](#7-definition-of-done)

---

## 1. Prerequisites

Ensure the following tools are installed:

| Tool | Version | Installation Link |
|------|---------|-------------------|
| Flutter SDK | 3.24+ | [flutter.dev](https://flutter.dev) |
| Dart SDK | ^3.11.0 | Bundled with Flutter |
| IDE | Latest | VS Code / Android Studio / IntelliJ |
| Git | Latest | [git-scm.com](https://git-scm.com) |

### Verify Installation

```bash
flutter doctor -v
flutter --version
dart --version
```

---

## 2. Step 1: Install Dependencies

### 2.1 Update `pubspec.yaml`

Replace the current `pubspec.yaml` content with the following:

```yaml
name: mobile_dev
description: "Chess Bot Mobile App with CQRS Architecture"
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.11.0

dependencies:
  flutter:
    sdk: flutter
  
  # DI Container
  get_it: ^8.0.0
  injectable: ^2.5.0
  
  # CQRS/Mediator
  streamline: ^1.0.0
  
  # Navigation
  go_router: ^14.0.0
  
  # HTTP Client
  dio: ^5.4.0
  
  # Chess Logic
  chess: ^0.8.0
  
  # Board UI (choose one)
  flutter_chess_board: ^1.0.0
  # OR
  # chessground: ^1.0.0
  
  # Utility
  equatable: ^2.0.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  
  # Code Generation
  build_runner: ^2.4.0
  injectable_generator: ^2.6.0
  streamline_generator: ^1.0.0

flutter:
  uses-material-design: true
```

### 2.2 Install Packages

```bash
flutter pub get
```

---

## 3. Step 2: Create Folder Structure

### 3.1 CQRS Use-Case Based Structure

Create the following folder structure under `lib/`:

```
lib/
├── di/                          # Dependency Injection
│   ├── injection.dart
│   └── injection.config.dart    # Generated (DO NOT CREATE MANUALLY)
│
├── data/
│   └── api/                     # API layer (Dio instances)
│       └── chess_api.dart       # Dio instance for chess API
│
├── logic/
│   ├── commands/                # Write operations (use-case folders)
│   │   └── make_move/
│   │       ├── make_move.dart           # Command definition
│   │       └── make_move_handler.dart   # Handler
│   ├── queries/                 # Read operations (use-case folders)
│   │   ├── get_current_fen/
│   │   │   ├── get_current_fen.dart           # Query definition
│   │   │   └── get_current_fen_handler.dart   # Handler
│   │   └── get_game_status/
│   │       ├── get_game_status.dart
│   │       └── get_game_status_handler.dart
│   └── events/                  # Domain events
│       └── game_state_changed_event.dart
│
├── ui/
│   ├── screens/                 # Full-screen widgets
│   │   ├── difficulty_screen.dart
│   │   └── game_screen.dart
│   └── widgets/                 # Reusable widgets
│       ├── chess_board_widget.dart
│       └── loading_overlay.dart
│
├── routing/
│   └── app_router.dart          # go_router configuration
│
├── core/                        # Shared utilities
│   ├── constants.dart
│   └── extensions.dart
│
├── app.dart                     # MaterialApp configuration
└── main.dart                    # Entry point
```

**Key difference:** Each use-case has its own folder containing both the command/query and its handler.

### 3.2 Create Folders via Script (Windows)

```powershell
cd lib

# Create main folders
New-Item -ItemType Directory -Force -Path di
New-Item -ItemType Directory -Force -Path data\api
New-Item -ItemType Directory -Force -Path logic\commands\make_move
New-Item -ItemType Directory -Force -Path logic\queries\get_current_fen
New-Item -ItemType Directory -Force -Path logic\queries\get_game_status
New-Item -ItemType Directory -Force -Path logic\events
New-Item -ItemType Directory -Force -Path ui\screens
New-Item -ItemType Directory -Force -Path ui\widgets
New-Item -ItemType Directory -Force -Path routing
New-Item -ItemType Directory -Force -Path core
```

---

## 4. Step 3: Configure Dependency Injection

### 4.1 Create `lib/di/injection.dart`

```dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();
```

### 4.2 Create `lib/core/constants.dart`

```dart
class AppConstants {
  static const String baseUrl = 'https://api.chessbot.com';
  static const int defaultTimeout = 30000; // 30 seconds
}
```

---

## 5. Step 4: Create Sample Components

### 5.1 Create API Client (`lib/data/api/chess_api.dart`)

```dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../core/constants.dart';

@lazySingleton
class ChessApi {
  final Dio _dio;

  ChessApi() : _dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: const Duration(milliseconds: AppConstants.defaultTimeout),
    receiveTimeout: const Duration(milliseconds: AppConstants.defaultTimeout),
  ));

  Dio get dio => _dio;
}
```

### 5.2 Create a Sample Command (`lib/logic/commands/make_move/make_move.dart`)

```dart
import 'package:equatable/equatable.dart';
import 'package:streamline/streamline.dart';

class MakeMoveCommand extends Command {
  final String sessionId;
  final String from;
  final String to;

  const MakeMoveCommand({
    required this.sessionId,
    required this.from,
    required this.to,
  });
}
```

### 5.3 Create Command Handler (`lib/logic/commands/make_move/make_move_handler.dart`)

**Handlers directly inject `Dio` - no service layer needed!**

```dart
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';
import 'package:dio/dio.dart';
import 'make_move.dart';
import '../../events/game_state_changed_event.dart';
import '../../../data/api/chess_api.dart';

@injectable
class MakeMoveHandler extends CommandHandler<MakeMoveCommand, bool> {
  final Dio _dio;

  MakeMoveHandler(ChessApi chessApi) : _dio = chessApi.dio;

  @override
  Future<bool> handle(MakeMoveCommand command) async {
    try {
      final response = await _dio.post('/game/move', data: {
        'sessionId': command.sessionId,
        'from': command.from,
        'to': command.to,
      });
      
      final success = response.statusCode == 200;

      if (success) {
        // Publish domain event to trigger UI rebuild
        publish(GameStateChangedEvent(sessionId: command.sessionId));
      }

      return success;
    } catch (e) {
      throw Exception('Failed to make move: $e');
    }
  }
}
```

### 5.4 Create a Sample Query (`lib/logic/queries/get_current_fen/get_current_fen.dart`)

```dart
import 'package:equatable/equatable.dart';
import 'package:streamline/streamline.dart';

class GetCurrentFenQuery extends Query<String> {
  final String sessionId;

  const GetCurrentFenQuery({required this.sessionId});
}
```

### 5.5 Create Query Handler (`lib/logic/queries/get_current_fen/get_current_fen_handler.dart`)

```dart
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';
import 'package:dio/dio.dart';
import 'get_current_fen.dart';
import '../../../data/api/chess_api.dart';

@injectable
class GetCurrentFenHandler extends QueryHandler<GetCurrentFenQuery, String> {
  final Dio _dio;

  GetCurrentFenHandler(ChessApi chessApi) : _dio = chessApi.dio;

  @override
  Future<String> handle(GetCurrentFenQuery query) async {
    try {
      final response = await _dio.get(
        '/game/fen',
        queryParameters: {'sessionId': query.sessionId},
      );
      return response.data['fen'] as String;
    } catch (e) {
      throw Exception('Failed to get FEN: $e');
    }
  }
}
```

### 5.6 Create another Query (`lib/logic/queries/get_game_status/get_game_status.dart`)

```dart
import 'package:equatable/equatable.dart';
import 'package:streamline/streamline.dart';

class GetGameStatusQuery extends Query<Map<String, dynamic>> {
  final String sessionId;

  const GetGameStatusQuery({required this.sessionId});
}
```

### 5.7 Create Query Handler (`lib/logic/queries/get_game_status/get_game_status_handler.dart`)

```dart
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';
import 'package:dio/dio.dart';
import 'get_game_status.dart';
import '../../../data/api/chess_api.dart';

@injectable
class GetGameStatusHandler extends QueryHandler<GetGameStatusQuery, Map<String, dynamic>> {
  final Dio _dio;

  GetGameStatusHandler(ChessApi chessApi) : _dio = chessApi.dio;

  @override
  Future<Map<String, dynamic>> handle(GetGameStatusQuery query) async {
    try {
      final response = await _dio.get(
        '/game/status',
        queryParameters: {'sessionId': query.sessionId},
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get game status: $e');
    }
  }
}
```

### 5.8 Create a Sample Event (`lib/logic/events/game_state_changed_event.dart`)

```dart
import 'package:equatable/equatable.dart';
import 'package:streamline/streamline.dart';

class GameStateChangedEvent extends DomainEvent {
  final String sessionId;

  const GameStateChangedEvent({required this.sessionId});
}
```

### 5.9 Create a Sample Screen with QueryBuilder (`lib/ui/screens/game_screen.dart`)

**Important:** This is how Streamline handles UI updates — **no Provider/ChangeNotifier needed**.

```dart
import 'package:flutter/material.dart';
import 'package:streamline/streamline.dart';
import '../../logic/commands/make_move/make_move.dart';
import '../../logic/queries/get_current_fen/get_current_fen.dart';
import '../../logic/queries/get_game_status/get_game_status.dart';
import '../../logic/events/game_state_changed_event.dart';

class GameScreen extends StatelessWidget {
  final int level;
  final String sessionId;

  const GameScreen({
    super.key,
    required this.level,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game - Level $level'),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () => _undoMove(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // QueryBuilder automatically rebuilds when GameStateChangedEvent is published
          QueryBuilder<GetCurrentFenQuery>(
            query: GetCurrentFenQuery(sessionId: sessionId),
            // Events that trigger this query to re-execute
            events: [
              (event) => event is GameStateChangedEvent && 
                        event.sessionId == sessionId,
            ],
            builder: (context, fen) {
              return ChessBoardWidget(fen: fen ?? '');
            },
            loadingBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorBuilder: (context, error) => Center(
              child: Text('Error: $error'),
            ),
          ),
          
          // Another QueryBuilder for game status
          QueryBuilder<GetGameStatusQuery>(
            query: GetGameStatusQuery(sessionId: sessionId),
            events: [
              (event) => event is GameStateChangedEvent &&
                        event.sessionId == sessionId,
            ],
            builder: (context, status) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Status: ${status?['status'] ?? 'Loading...'}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
            loadingBuilder: (context) => const SizedBox.shrink(),
          ),
          
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _resign(context),
                    child: const Text('Resign'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _restart(context),
                    child: const Text('Restart'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _makeMove(BuildContext context, String from, String to) {
    final command = MakeMoveCommand(
      sessionId: sessionId,
      from: from,
      to: to,
    );
    // Send command via Mediator
    context.send(command);
  }

  void _undoMove(BuildContext context) {
    // Implement undo command
  }

  void _resign(BuildContext context) {
    // Implement resign command
  }

  void _restart(BuildContext context) {
    // Implement restart command
  }
}
```

### 5.10 Create Chess Board Widget (`lib/ui/widgets/chess_board_widget.dart`)

```dart
import 'package:flutter/material.dart';

class ChessBoardWidget extends StatelessWidget {
  final String fen;

  const ChessBoardWidget({super.key, required this.fen});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.brown, width: 4),
        ),
        child: Center(
          child: Text(
            'Chess Board\nFEN: $fen',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
```

### 5.11 Create Difficulty Screen (`lib/ui/screens/difficulty_screen.dart`)

```dart
import 'package:flutter/material.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Difficulty'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Choose your level:'),
            const SizedBox(height: 20),
            ...List.generate(5, (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate with session creation
                  Navigator.pushNamed(
                    context,
                    '/game',
                    arguments: {'level': index + 1},
                  );
                },
                child: Text('Level ${index + 1}'),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
```

### 5.12 Create Router (`lib/routing/app_router.dart`)

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ui/screens/difficulty_screen.dart';
import '../ui/screens/game_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/difficulty',
  routes: [
    GoRoute(
      path: '/difficulty',
      builder: (context, state) => const DifficultyScreen(),
    ),
    GoRoute(
      path: '/game',
      builder: (context, state) {
        final level = state.uri.queryParameters['level'] ?? '1';
        final sessionId = state.uri.queryParameters['sessionId'] ?? 'default';
        return GameScreen(
          level: int.parse(level),
          sessionId: sessionId,
        );
      },
    ),
  ],
);
```

### 5.13 Update `lib/app.dart`

**No Provider needed!** Streamline's `MediatorConfig` wraps the app.

```dart
import 'package:flutter/material.dart';
import 'package:streamline/streamline.dart';
import 'routing/app_router.dart';

class ChessBotApp extends StatelessWidget {
  const ChessBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediatorConfig(
      // Optional: initialization logic
      onInitialize: () async {
        debugPrint('Mediator initialized!');
      },
      // Optional: loading widget during initialization
      onInitializeWaitingBuilder: (context) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      child: MaterialApp.router(
        title: 'Chess Bot',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
```

### 5.14 Update `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'di/injection.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configure Dependency Injection
  await configureDependencies();
  
  runApp(const ChessBotApp());
}
```

---

## 6. Step 5: Build & Verify

### 6.1 Run Build Runner

Generate DI and CQRS code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**Note:** If you get an error about `build.yaml` containing CI/CD configuration, use:

```bash
flutter pub run build_runner build --delete-conflicting-outputs --no-build-yaml
```

This will generate:
- `lib/di/injection.config.dart` — DI configuration
- Handler registrations for streamline

### 6.2 Run the App

```bash
flutter run
```

### 6.3 Verify Everything Works

Checklist:

- [ ] App launches without errors
- [ ] Navigation works (`/difficulty` → `/game`)
- [ ] No DI errors in console
- [ ] `getIt` resolves services correctly
- [ ] QueryBuilder widgets load and display data
- [ ] Domain events trigger UI rebuilds (test by sending commands)

### 6.4 Run Tests

```bash
flutter test
```

---

## 7. Definition of Done

Sprint 1.0.0 is complete when:

1. ✅ All dependencies installed (`flutter pub get` succeeds)
2. ✅ Folder structure matches CQRS use-case architecture
3. ✅ DI configured and code generated
4. ✅ API client created (ChessApi with Dio)
5. ✅ Sample Command + Handler created (MakeMove)
6. ✅ Sample Query + Handler created (GetCurrentFen, GetGameStatus)
7. ✅ Domain Event created (GameStateChangedEvent)
8. ✅ Handlers directly inject Dio via ChessApi
9. ✅ UI uses **QueryBuilder** instead of Provider/ChangeNotifier
10. ✅ Navigation with go_router configured
11. ✅ App launches and navigates between screens
12. ✅ Build runner generates all files without errors
13. ✅ All tests pass

---

## Quick Reference Commands

```bash
# Install dependencies
flutter pub get

# Generate all code (DI, CQRS)
flutter pub run build_runner build --delete-conflicting-outputs

# If you have CI/CD config in build.yaml, use:
flutter pub run build_runner build --delete-conflicting-outputs --no-build-yaml

# Watch for changes (auto-regenerate)
flutter pub run build_runner watch --delete-conflicting-outputs

# Run the app
flutter run

# Run tests
flutter test

# Check for issues
flutter doctor -v
flutter analyze
```

---

## Key Architecture Principles

### Pure CQRS with Streamline

```
UI → Command → Mediator → Handler (injects Dio) → API
                                              ↓
UI Rebuild ← QueryBuilder ← Domain Event ← publish(event)
```

### No Service Layer Needed

| Traditional Layer | Pure CQRS Approach |
|-------------------|-------------------|
| Controller → Service → Repository | Handler injects Dio directly |
| Service classes | API clients (Dio wrappers) only |
| Business logic in services | **All business logic in handlers** |
| Multiple abstraction layers | Single handler layer |

### Benefits

- ✅ **Less boilerplate** - no service/repository interfaces
- ✅ **Direct dependencies** - handlers inject exactly what they need
- ✅ **Easier testing** - mock Dio or API client in handler tests
- ✅ **Clear separation** - commands (write) vs queries (read)
- ✅ **Event-driven UI** - domain events trigger automatic rebuilds

### Use-Case Folder Structure

Each use-case is self-contained:

```
logic/commands/make_move/
├── make_move.dart              # Command definition
└── make_move_handler.dart      # Handler with business logic

logic/queries/get_current_fen/
├── get_current_fen.dart        # Query definition
└── get_current_fen_handler.dart # Handler with business logic
```

This makes it easy to:
- Find all code related to a specific use-case
- Delete/modify use-cases without affecting others
- Test handlers in isolation

---

## Troubleshooting

### Issue: `injection.config.dart` not generated

**Solution:**
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: QueryBuilder not rebuilding

**Solution:** 
- Ensure the event filter matches the published event type
- Check that `publish()` is called in the handler after command execution
- Verify the query is correctly defined with `Query<T>` base class

### Issue: go_router navigation fails

**Solution:** Check that route paths match exactly and `routerConfig` is set in `MaterialApp.router`.

### Issue: Mediator not initialized

**Solution:** Ensure `MediatorConfig` wraps the entire app in `app.dart`.

---

**Next Sprint:** Implement actual chess game logic, integrate chess board UI, and connect to real API.
