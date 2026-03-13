
## 6. Технические требования

### 6.1 Технологический стек

| Компонент          | Технология                        | Версия       | Лицензия    |
|--------------------|-----------------------------------|--------------|-------------|
| Language           | Dart                              | ^3.11.0      | BSD-style   |
| Framework          | Flutter                           | 3.24+        | BSD-style   |
| **CQRS/Mediator**  | **streamline**                    | latest       | **MIT**     |
| **DI Container**   | **get_it** + **injectable**       | latest       | **MIT**     |
| **UI State**       | **Provider** (ChangeNotifier)     | ^6.1.5+      | MIT         |
| Navigation         | go_router                         | latest       | BSD-style   |
| Chess Logic        | chess                             | ^0.8.0+      | MIT         |
| Board UI           | flutter_chess_board / chessground | latest       | MIT         |
| HTTP Client        | dio                               | latest       | MIT         |

### 6.2 Архитектура приложения

#### 6.2.1 Трёхслойная архитектура (рекомендация Flutter)

Следуем официальному [руководству по архитектуре Flutter](https://docs.flutter.dev/app-architecture):
```
┌─────────────────────────────────────────────────────────┐
│ UI Layer                                                │
│ ┌─────────────┐ ┌─────────────────────────┐            │
│ │ Views       │ ◄────── │ View Models     │            │
│ │ (Widgets)   │        │ (UI State only) │            │
│ └─────────────┘        └───────────┬─────────────┘    │
│                                    │                   │
└────────────────────────────────────┼───────────────────┘
│ Commands/Queries
┌──────────────────▼──────────────────┐
│ Logic Layer                         │
│ ┌─────────────┐ ┌───────────────┐   │
│ │ Commands    │ │ Handlers      │   │
│ │ (Queries)   │ │ (Processors)  │   │
│ └─────────────┘ └───────────────┘   │
└──────────────────┬──────────────────┘
│
┌──────────────────▼──────────────────┐
│ Data Layer                          │
│ ┌─────────────┐ ┌───────────────┐   │
│ │ Services    │ │ Repositories  │   │
│ │ (API)       │ │ (Local DB)    │   │
│ └─────────────┘ └───────────────┘   │
└─────────────────────────────────────┘
```
**Обязанности слоёв:**

| Слой            | Обязанности                                   | Правила коммуникации                              |
|-----------------|-----------------------------------------------|---------------------------------------------------|
| **UI Layer**    | Отображение данных, обработка ввода           | Отправляет Commands/Queries в Logic Layer         |
| **Logic Layer** | Бизнес-логика, обработка команд               | Принимает от UI, читает/пишет в Data Layer        |
| **Data Layer**  | Вызовы API, операции с локальными данными     | Общается только с Logic Layer                     |

### 6.3 Паттерн CQRS с Mediator (пакет streamline)

#### 6.3.1 Почему streamline (аналог MediatR)?

Пакет **[streamline](https://pub.dev/packages/streamline)** выбран потому что он:

- ✅ **MIT лицензия** (в отличие от AGPL-альтернатив)
- ✅ **Автоматическая регистрация handlers** через code generation
- ✅ Настоящий **CQRS/Mediator**-паттерн как в .NET MediatR
- ✅ Разделяет **Commands** (запись) и **Queries** (чтение)
- ✅ Поддерживает **Domain Events** для перерисовки UI
- ✅ Поддерживает **pipeline behaviors** (logging, validation, caching)

#### 6.3.2 Поток CQRS
```
┌─────────────────────────────────────────────────────────────┐
│ UI Layer                                                    │
│ [ChessBoard] [Buttons] [DifficultySelector]                 │
└─────────────────────┬───────────────────────────────────────┘
│ User Action
▼
┌─────────────────────────────────────────────────────────────┐
│ Mediator (streamline)                                       │
│ ┌─────────────────────────────────────────────────────┐     │
│ │ Commands (write operations):                        │     │
│ │ - MakeMoveCommand                                   │     │
│ │ - UndoCommand                                       │     │
│ │ - RestartCommand                                    │     │
│ │ - ResignCommand                                     │     │
│ │ - SetBotLevelCommand                                │     │
│ └─────────────────────────────────────────────────────┘     │
│ ┌─────────────────────────────────────────────────────┐     │
│ │ Queries (read operations):                          │     │
│ │ - GetCurrentFenQuery                                │     │
│ │ - GetGameStatusQuery                                │     │
│ │ - GetBotLevelQuery                                  │     │
│ └─────────────────────────────────────────────────────┘     │
│ ┌─────────────────────────────────────────────────────┐     │
│ │ Domain Events (trigger UI rebuilds):                │     │
│ │ - GameStateChangedEvent                             │     │
│ │ - GameOverEvent                                     │     │
│ │ - BotLevelChangedEvent                              │     │
│ └─────────────────────────────────────────────────────┘     │
└─────────────────────┬───────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│ Command/Query Handlers                                      │
│ (Business Logic - validate, coordinate, transform)          │
└─────────────────────┬───────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│ Data Layer                                                  │
│ ┌─────────────────┐ ┌─────────────────┐                     │
│ │ Services        │ │ Repositories    │                     │
│ │ - ApiService    │ │ - LocalStorage  │                     │
│ │ - BotService    │ │ (optional)      │                     │
│ └─────────────────┘ └─────────────────┘                     │
└─────────────────────────────────────────────────────────────┘
```

#### 6.3.3 Описание компонентов

- **Commands** — неизменяемые объекты действий, меняющих состояние  
  Примеры: `MakeMoveCommand`, `UndoCommand`, `ResignCommand`
- **Queries** — неизменяемые запросы на данные  
  Примеры: `GetCurrentFenQuery`, `GetGameStatusQuery`
- **Handlers** — классы с бизнес-логикой, зависимости через constructor injection
- **Domain Events** — публикуются после успешной команды, вызывают rebuild UI через `QueryBuilder`

### 6.4 Dependency Injection (get_it + injectable)

#### 6.4.1 Почему get_it + injectable?

| Возможность               | get_it + injectable       | Provider              |
|---------------------------|---------------------------|-----------------------|
| **Pattern**               | Service Locator           | InheritedWidget       |
| **Auto-registration**     | ✅ code generation        | ❌ ручная             |
| **BuildContext required** | ❌                        | ✅                    |
| **Use in pure Dart**      | ✅                        | ❌                    |
| **Constructor injection** | ✅ автоматическая         | ❌ ручная             |
| **Learning curve**        | низкая (как .NET DI)      | средняя               |

#### 6.4.2 Как работает

1. Аннотации: `@injectable`, `@lazySingleton`, `@singleton`
2. `flutter pub run build_runner build`
3. Вызов `configureDependencies()` / `init()` при старте
4. `getIt<MyService>()` в любом месте

### 6.5 Services vs Repositories

#### 6.5.1 Services (основной доступ к данным)

**ChessService** — все API-вызовы:

- `getGameSession(level)`
- `makeMove(sessionId, from, to)`
- `getFen(sessionId)`
- `getGameStatus(sessionId)`

#### 6.5.3 Почему Services, а не Repositories в MVP

| Аспект              | Repository       | Service         | Решение ChessBot |
|---------------------|------------------|-----------------|------------------|
| Источник данных     | локальное        | HTTP API        | ✅ API           |
| Где состояние       | локально         | на сервере      | ✅ сервер        |
| Offline support     | обязательно      | опционально     | ❌ не нужно      |
| Кэширование         | встроенное       | ручное          | ❌ не нужно      |

**Вывод для MVP:** Services напрямую в Handlers, repositories — опционально позже.

### 6.6 Управление состоянием UI (Provider + ChangeNotifier)

Два механизма обновления UI:

| Механизм                  | Назначение                     | Триггер                          |
|---------------------------|--------------------------------|----------------------------------|
| **Domain Events** (streamline) | данные изменились            | завершение Command               |
| **ChangeNotifier** (Provider)  | UI-состояние (loading, error) | `notifyListeners()`              |

**ViewModel** (только в UI-слое):

- `isLoading`
- `error`
- `showDialog`
- `selectedLevel`

Handlers и сервисы **не используют** ChangeNotifier.

### 6.7 Навигация — go_router

Преимущества:

- deep linking
- browser history (web)
- nested routes
- route guards
- доступ без BuildContext

Маршруты:

- `/difficulty`
- `/game?level=X`

### 6.8 Unidirectional Data Flow
UI → Command → Mediator → Handler → Service → API
↓
Domain Event → QueryBuilder → rebuild UI
textUI никогда не меняет данные напрямую.

### 6.9 Структура проекта
```
lib/
├── di/
│   ├── injection.dart
│   └── injection.config.dart
├── data/
│   ├── dto/
│   └── services/
├── logic/
│   ├── commands/
│   ├── queries/
│   ├── handlers/
│   └── events/
├── ui/
│   ├── viewmodels/
│   ├── screens/
│   └── widgets/
├── routing/
│   └── app_router.dart
└── main.dart
```
### 6.10 Итог

- Автоматическая регистрация DI
- Нет зависимости от BuildContext
- Чёткое разделение CQRS
- Легко тестируемые handlers
- Автообновление UI через Domain Events
- Минимальный boilerplate
- API-first подход
