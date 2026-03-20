# Technical Requirements

## 6. Technical Requirements

### 6.1 Technology Stack

| Component | Technology | Version | License |
|-----------|------------|---------|---------|
| Language | Dart | ^3.11.0 | BSD-style |
| Framework | Flutter | 3.24+ | BSD-style |
| **CQRS/Mediator** | **streamline** | latest | **MIT** |
| **DI Container** | **get_it** + **injectable** | latest | **MIT** |
| **UI State** | **Provider** (ChangeNotifier) | ^6.1.5+ | MIT |
| Navigation | go_router | latest | BSD-style |
| Chess Logic | chess | ^0.8.0+ | MIT |
| Board UI | flutter_chess_board / chessground | latest | MIT |
| HTTP Client | dio | latest | MIT |

---

### 6.2 Application Architecture

#### 6.2.1 Three-Layer Architecture (Flutter Recommended)

Following the official [Flutter architecture guide](https://docs.flutter.dev/app-architecture):

```
┌─────────────────────────────────────────────────────────┐
│                    UI Layer                             │
│  ┌─────────────┐         ┌─────────────────────────┐   │
│  │    Views    │ ◄────── │      View Models        │   │
│  │  (Widgets)  │         │  (UI State only)        │   │
│  └─────────────┘         └───────────┬─────────────┘   │
│                                      │                  │
└──────────────────────────────────────┼──────────────────┘
                                       │ Commands/Queries
                    ┌──────────────────▼──────────────────┐
                    │           Logic Layer               │
                    │  ┌─────────────┐  ┌───────────────┐ │
                    │  │  Commands   │  │   Handlers    │ │
                    │  │  (Queries)  │  │  (Processors) │ │
                    │  └─────────────┘  └───────────────┘ │
                    └──────────────────┬──────────────────┘
                                       │
                    ┌──────────────────▼──────────────────┐
                    │           Data Layer                │
                    │  ┌─────────────┐  ┌───────────────┐ │
                    │  │  Services   │  │  Repositories │ │
                    │  │  (API)      │  │  (Local DB)   │ │
                    │  └─────────────┘  └───────────────┘ │
                    └─────────────────────────────────────┘
```

**Layer Responsibilities:**

| Layer | Responsibility | Communication Rules |
|-------|----------------|---------------------|
| **UI Layer** | Displays data, handles user input | Sends Commands/Queries to Logic Layer |
| **Logic Layer** | Business logic, command processing | Receives from UI, reads/writes to Data Layer |
| **Data Layer** | API calls, local data operations | Only communicates with Logic Layer |

---

### 6.3 CQRS Pattern with Mediator (streamline package)

#### 6.3.1 Why streamline (MediatR-like)?

We use **[streamline](https://pub.dev/packages/streamline)** because it:
- ✅ Is **MIT licensed** (unlike AGPL alternatives)
- ✅ Provides **automatic handler registration** via code generation
- ✅ Implements **true CQRS/Mediator pattern** like MediatR in .NET
- ✅ Separates **Commands** (writes) from **Queries** (reads)
- ✅ Uses **Domain Events** to trigger UI rebuilds
- ✅ Supports **pipeline behaviors** (logging, validation, caching)

#### 6.3.2 CQRS Flow

```
┌─────────────────────────────────────────────────────────────┐
│                         UI Layer                            │
│  [ChessBoard] [Buttons] [DifficultySelector]                │
└─────────────────────┬───────────────────────────────────────┘
                      │ User Action
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                    Mediator (streamline)                    │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  Commands (write operations - change state):        │   │
│  │  - MakeMoveCommand                                  │   │
│  │  - UndoCommand                                      │   │
│  │  - RestartCommand                                   │   │
│  │  - ResignCommand                                    │   │
│  │  - SetBotLevelCommand                               │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  Queries (read operations - get data):              │   │
│  │  - GetCurrentFenQuery                               │   │
│  │  - GetGameStatusQuery                               │   │
│  │  - GetBotLevelQuery                                 │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  Domain Events (trigger UI rebuilds):               │   │
│  │  - GameStateChangedEvent                            │   │
│  │  - GameOverEvent                                    │   │
│  │  - BotLevelChangedEvent                             │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                   Command/Query Handlers                    │
│  (Business Logic - validate, coordinate, transform)         │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                    Data Layer                               │
│  ┌─────────────────┐  ┌─────────────────┐                  │
│  │   Services      │  │  Repositories   │                  │
│  │ - ApiService    │  │ - LocalStorage  │                  │
│  │ - BotService    │  │   (optional)    │                  │
│  └─────────────────┘  └─────────────────┘                  │
└─────────────────────────────────────────────────────────────┘
```

#### 6.3.3 Component Descriptions

**Commands** - Immutable objects representing user actions that change state. Examples: `MakeMoveCommand`, `UndoCommand`, `ResignCommand`.

**Queries** - Immutable objects representing data requests. Examples: `GetCurrentFenQuery`, `GetGameStatusQuery`.

**Handlers** - Classes that process Commands and Queries. Contain all business logic. Receive dependencies via constructor injection.

**Domain Events** - Published after successful Command execution. Trigger UI rebuilds via `QueryBuilder` widget.

---

### 6.4 Dependency Injection (get_it + injectable)

#### 6.4.1 Why get_it + injectable?

| Feature | get_it + injectable | Provider |
|---------|---------------------|----------|
| **Pattern** | Service Locator | InheritedWidget-based |
| **Auto-registration** | ✅ Via code generation | ❌ Manual |
| **BuildContext required** | ❌ No | ✅ Yes |
| **Use in pure Dart** | ✅ Yes | ❌ No |
| **Constructor injection** | ✅ Automatic | ❌ Manual |
| **Learning curve** | Low (similar to .NET DI) | Medium |

**get_it** = Service locator (runtime container)  
**injectable** = Code generator for auto-registration source generators

#### 6.4.2 How It Works

1. Annotate classes with `@injectable`, `@lazySingleton`, or `@singleton`
2. Run `build_runner` to generate registration code
3. Call generated `init()` method at app startup
4. Resolve dependencies anywhere via `getIt<Service>()`

#### 6.4.3 Available Annotations

| Annotation | Purpose |
|------------|---------|
| `@injectable` | Mark class for factory registration |
| `@lazySingleton` | Register as lazy singleton (created on first use) |
| `@singleton` | Register as singleton (created immediately) |
| `@module` | Mark abstract class for third-party type registration |
| `@preResolve` | Pre-await async dependencies before registration |
| `@Named('name')` | Named registration for multiple implementations |
| `@Environment('dev')` | Environment-specific registration |

---

### 6.5 Services vs Repositories

#### 6.5.1 Services (Primary Data Access)

**Services** handle all external API communication. The game session exists on the server, so **Services are the primary data access mechanism**.

**ChessService** - Handles all chess game API calls:
- `getGameSession(level)` - Create/fetch game session
- `makeMove(sessionId, from, to)` - Submit player move, receive bot response
- `getFen(sessionId)` - Get current board state
- `getGameStatus(sessionId)` - Check if game is over

**Characteristics:**
- Direct HTTP API communication
- Stateless (each call is independent)
- Returns DTOs (Data Transfer Objects)
- No business logic

#### 6.5.2 Repositories (Optional - Local Data Only)

**Repositories** implement generic CRUD interface for local data persistence. In ChessBot, repositories are **optional** since game state is server-side.

**Potential uses:**
- `ISettingsRepository` - Store user preferences (bot level, theme)
- `IGameHistoryRepository` - Cache completed games locally
- `ISessionRepository` - Cache active session for offline recovery

**Generic Interface:**
```
IRepository<T, ID>:
  - T? getById(ID id)
  - List<T> getAll()
  - T create(T entity)
  - T update(T entity)
  - void delete(ID id)
```

#### 6.5.3 Why Services Over Repositories for ChessBot

| Aspect | Repository | Service | ChessBot Decision |
|--------|------------|---------|-------------------|
| **Data source** | Local storage / ORM | HTTP API | ✅ API (stateless backend) |
| **State location** | Local objects | Server session | ✅ Server |
| **Offline support** | Required | Optional | ❌ Not required (MVP) |
| **Caching** | Built-in | Manual | ❌ Not needed (simple MVP) |

**Conclusion:** For ChessBot MVP, **Services are used directly by Handlers**. Repositories may be added later for settings persistence or game history caching.

---

### 6.6 UI State Management (Provider + ChangeNotifier)

#### 6.6.1 How UI Updates Work

**Two separate mechanisms:**

| Mechanism | Purpose | Trigger |
|-----------|---------|---------|
| **Domain Events (streamline)** | Notify that **data changed** | Command completion |
| **ChangeNotifier (Provider)** | Hold **UI-specific state** | `notifyListeners()` |

#### 6.6.2 Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    UI Layer                                 │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  Widgets read from TWO sources:                     │   │
│  │  1. QueryBuilder → Query → Handler → Service        │   │
│  │     (Rebuilds when Domain Event is published)       │   │
│  │  2. Consumer<ViewModel> → ChangeNotifier            │   │
│  │     (Rebuilds when notifyListeners() is called)     │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

**Important:** Services and Handlers do **NOT** use ChangeNotifier. Only ViewModels in the UI layer use it for UI-specific state (loading indicators, error messages, dialog visibility).

#### 6.6.3 ViewModel Responsibilities

ViewModels are UI-layer classes that extend `ChangeNotifier`:
- `isLoading` - Show/hide loading spinner
- `error` - Display error messages
- `showDialog` - Control dialog visibility
- `selectedLevel` - Track UI selection state

---

### 6.7 Navigation with go_router

**go_router** is the Flutter team's recommended navigation package:

| Feature | Benefit |
|---------|---------|
| Deep linking | Full support for external links |
| Browser history | Back/forward buttons work on web |
| Nested routes | Support complex navigation hierarchies |
| Route guards | Built-in redirect logic |
| No BuildContext | Accessible from anywhere via DI |

**Routes:**
- `/difficulty` - Bot level selection screen
- `/game?level=X` - Game screen with specified bot level

---

### 6.8 Unidirectional Data Flow Explained

**Flutter's recommendation:** *"Data updates flow from Data Layer → UI. UI interactions flow from UI → Data Layer."*

**With CQRS + streamline:**

```
┌─────────────────────────────────────────────────────────────┐
│  FLOW 1: User Action (UI → Data)                            │
│  ─────────────────────────────────────────────────────      │
│  1. User taps square                                        │
│  2. UI sends Command to Mediator                            │
│  3. Handler processes command (business logic)              │
│  4. Handler calls Service (API request)                     │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│  FLOW 2: State Update (Data → UI)                           │
│  ─────────────────────────────────────────────────────      │
│  1. Handler publishes Domain Event after success            │
│  2. QueryBuilder listens for this event                     │
│  3. QueryBuilder re-executes Query                          │
│  4. Query fetches fresh data from Service                   │
│  5. UI rebuilds with new data                               │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│  FLOW 3: UI State (Loading, Errors)                         │
│  ─────────────────────────────────────────────────────      │
│  1. Handler updates ViewModel (ChangeNotifier)              │
│  2. ViewModel calls notifyListeners()                       │
│  3. Consumer widgets rebuild                                │
└─────────────────────────────────────────────────────────────┘
```

**Key Point:** UI **never directly modifies** data. All mutations go through:
`UI → Command → Handler → Service → Domain Event → Query → UI rebuild`

---

### 6.9 Project Structure

```
lib/
├── di/
│   ├── injection.dart          # get_it configuration
│   └── injection.config.dart   # Generated by injectable
├── data/
│   ├── dto/                    # Data Transfer Objects
│   │   ├── game_session_dto.dart
│   │   └── bot_move_dto.dart
│   └── services/               # API services
│       ├── bot_service.dart
│       └── api_service.dart
├── logic/
│   ├── commands/               # Command definitions
│   │   ├── make_move_command.dart
│   │   ├── undo_command.dart
│   │   └── resign_command.dart
│   ├── queries/                # Query definitions
│   │   ├── get_current_fen_query.dart
│   │   └── get_game_status_query.dart
│   ├── handlers/               # Command/Query handlers
│   │   ├── make_move_handler.dart
│   │   └── get_current_fen_handler.dart
│   └── events/                 # Domain events
│       └── game_state_changed_event.dart
├── ui/
│   ├── viewmodels/             # UI state (ChangeNotifier)
│   │   └── game_view_model.dart
│   ├── screens/
│   │   ├── difficulty_screen.dart
│   │   └── game_screen.dart
│   └── widgets/
│       ├── chess_board.dart
│       └── control_panel.dart
├── routing/
│   └── app_router.dart
└── main.dart
```

**Note:** No `repositories/` folder in MVP - Services handle all data access. Repositories may be added later for local persistence if needed.

---

### 6.10 Benefits Summary

| Benefit | How It's Achieved |
|---------|-------------------|
| **Auto DI registration** | injectable code generation (like .NET) |
| **No BuildContext needed** | get_it service locator |
| **Clear separation** | CQRS with Commands/Queries/Events |
| **Testable handlers** | Pure business logic, dependencies injected |
| **UI auto-rebuilds** | Domain Events + QueryBuilder |
| **UI state management** | ChangeNotifier for loading/errors only |
| **Navigation anywhere** | go_router accessible from handlers |
| **API-first design** | Services handle all server communication |
| **Minimal boilerplate** | No unnecessary repositories for server state |
