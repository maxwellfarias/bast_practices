# Flutter Unit Testing Guide - Arquitetura Oficial

Este tutorial completo ensina como implementar testes unitários seguindo a arquitetura oficial do Flutter, usando as melhores práticas do mercado.

## 📋 Índice

1. [Introdução à Arquitetura](#1-introdução-à-arquitetura)
2. [Configuração do Projeto](#2-configuração-do-projeto)
3. [Implementação das Camadas](#3-implementação-das-camadas)
4. [Estratégias de Teste](#4-estratégias-de-teste)
5. [Testes da Data Layer](#5-testes-da-data-layer)
6. [Testes da Domain Layer](#6-testes-da-domain-layer)
7. [Testes da UI Layer](#7-testes-da-ui-layer)
8. [Mocking com Mocktail](#8-mocking-com-mocktail)
9. [Patterns de Teste](#9-patterns-de-teste)
10. [Melhores Práticas](#10-melhores-práticas)

---

## 1. Introdução à Arquitetura

### Arquitetura em Camadas

A arquitetura oficial do Flutter divide a aplicação em três camadas principais:

```
┌─────────────────────────────────────┐
│            UI Layer                 │
│  (Views + ViewModels + Commands)    │
├─────────────────────────────────────┤
│          Domain Layer               │
│     (Models + Use Cases)            │
├─────────────────────────────────────┤
│           Data Layer                │
│   (Repositories + Services)         │
└─────────────────────────────────────┘
```

### Princípios Fundamentais

1. **Separação de Responsabilidades**: Cada camada tem uma responsabilidade específica
2. **Inversão de Dependência**: Camadas superiores dependem de abstrações
3. **Testabilidade**: Cada camada pode ser testada isoladamente
4. **Reutilização**: Lógica de negócio independente da UI

---

## 2. Configuração do Projeto

### Estrutura de Pastas

```
lib/
├── ui/
│   ├── core/
│   │   ├── ui/              # Widgets compartilhados
│   │   └── themes/          # Temas da aplicação
│   └── tasks/               # Feature específica
│       ├── view_model/      # ViewModels e Commands
│       └── widgets/         # Telas e widgets
├── domain/
│   └── models/              # Modelos de domínio
├── data/
│   ├── repositories/        # Implementação dos repositórios
│   ├── services/           # Serviços de dados
│   └── models/             # Modelos de API
├── config/                 # Configurações
├── utils/                  # Utilitários
└── routing/               # Configuração de rotas

test/
├── unit/                  # Testes unitários
│   ├── data/
│   ├── domain/
│   └── ui/
├── widget/               # Testes de widget
└── integration/          # Testes de integração

testing/
├── fakes/               # Dados falsos para teste
└── mocks/              # Mocks reutilizáveis
```

### Dependências Essenciais

```yaml
dependencies:
  # State Management
  provider: ^6.1.2
  
  # Navigation
  go_router: ^14.2.7
  
  # HTTP Client
  dio: ^5.4.3+1
  
  # Database
  supabase_flutter: ^2.5.6
  
  # Utilities
  uuid: ^4.4.0
  equatable: ^2.0.5

dev_dependencies:
  # Testing
  mocktail: ^1.0.3
  bloc_test: ^9.1.7
```

---

## 3. Implementação das Camadas

### Domain Layer - Modelos

Os modelos de domínio representam as entidades do negócio:

```dart
// lib/domain/models/task.dart
class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    this.completedAt,
  });

  @override
  List<Object?> get props => [id, title, description, isCompleted, createdAt, completedAt];
}
```

### Data Layer - Services e Repositories

**Interfaces (Contratos)**:

```dart
// lib/data/repositories/task_repository.dart
abstract class TaskRepository {
  Future<Result<List<Task>>> getTasks();
  Future<Result<Task>> getTask(String id);
  Future<Result<Task>> createTask(CreateTaskData data);
  Future<Result<Task>> updateTask(String id, UpdateTaskData data);
  Future<Result<void>> deleteTask(String id);
}
```

**Implementações**:

```dart
// lib/data/repositories/supabase_task_repository.dart
class SupabaseTaskRepository implements TaskRepository {
  final TaskApiService _apiService;

  SupabaseTaskRepository(this._apiService);

  @override
  Future<Result<List<Task>>> getTasks() async {
    try {
      final apiTasks = await _apiService.getTasks();
      final tasks = apiTasks.map((apiTask) => apiTask.toDomain()).toList();
      return Result.success(tasks);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
```

### UI Layer - ViewModels e Commands

**Command Pattern Oficial do Flutter**:

```dart
// lib/ui/tasks/view_model/task_commands.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../utils/result.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);

/// Implementação oficial do Command Pattern do Flutter
/// 
/// Facilita interação com ViewModels, encapsula ações,
/// expõe estados de running/error e previne execução múltipla.
abstract class Command<T> extends ChangeNotifier {
  bool _running = false;
  Result<T>? _result;

  /// True quando a ação está executando
  bool get running => _running;

  /// True se a ação completou com erro
  bool get error => _result is Error;

  /// True se a ação completou com sucesso
  bool get completed => _result is Ok;

  /// Resultado da última execução
  Result<T>? get result => _result;

  /// Limpa o resultado da última execução
  void clearResult() {
    _result = null;
    notifyListeners();
  }

  /// Implementação interna de execução
  Future<void> _execute(CommandAction0<T> action) async {
    if (_running) return; // Previne execução múltipla

    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

/// Command sem argumentos
class Command0<T> extends Command<T> {
  final CommandAction0<T> _action;

  Command0(this._action);

  Future<void> execute() async {
    await _execute(_action);
  }
}

/// Command com um argumento
class Command1<T, A> extends Command<T> {
  final CommandAction1<T, A> _action;

  Command1(this._action);

  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}
```

**ViewModel com Commands Oficiais**:

```dart
// lib/ui/tasks/view_model/task_view_model.dart
class TaskViewModel extends ChangeNotifier {
  final TaskRepository _repository;
  
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _error;

  // Commands para operações CRUD
  late final Command1<Task, CreateTaskData> createTaskCommand;
  late final Command1<Task, ({String id, UpdateTaskData data})> updateTaskCommand;
  late final Command1<void, String> deleteTaskCommand;
  late final Command1<Task, String> completeTaskCommand;
  late final Command1<Task, String> uncompleteTaskCommand;
  late final Command0<List<Task>> loadTasksCommand;

  TaskViewModel(this._repository) {
    _initializeCommands();
    _setupCommandListeners();
  }

  // Getters
  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Inicializa todos os comandos
  void _initializeCommands() {
    // Comando para carregar tarefas
    loadTasksCommand = Command0<List<Task>>(() async {
      return await _repository.getTasks();
    });

    // Comando para criar tarefa
    createTaskCommand = Command1<Task, CreateTaskData>((data) async {
      final result = await _repository.createTask(data);
      if (result.isSuccess) {
        await loadTasksCommand.execute(); // Auto-reload
      }
      return result;
    });

    // Comando para atualizar tarefa
    updateTaskCommand = Command1<Task, ({String id, UpdateTaskData data})>((params) async {
      final result = await _repository.updateTask(params.id, params.data);
      if (result.isSuccess) {
        await loadTasksCommand.execute(); // Auto-reload
      }
      return result;
    });

    // Outros comandos...
  }

  /// Configura listeners para os comandos
  void _setupCommandListeners() {
    loadTasksCommand.addListener(() {
      _setLoading(loadTasksCommand.running);
      
      final result = loadTasksCommand.result;
      if (result != null) {
        result.when(
          success: (tasks) {
            _setTasks(tasks);
            _setError(null);
          },
          failure: (error) => _setError(error),
        );
      }
    });

    // Listeners para outros comandos...
  }

  // Métodos públicos
  Future<void> loadTasks() async {
    await loadTasksCommand.execute();
  }

  Future<void> createTask(CreateTaskData data) async {
    await createTaskCommand.execute(data);
  }

  Future<void> updateTask(String id, UpdateTaskData data) async {
    await updateTaskCommand.execute((id: id, data: data));
  }

  // Métodos privados para gerenciar estado
  void _setTasks(List<Task> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  @override
  void dispose() {
    // Dispose dos comandos
    loadTasksCommand.dispose();
    createTaskCommand.dispose();
    updateTaskCommand.dispose();
    deleteTaskCommand.dispose();
    completeTaskCommand.dispose();
    uncompleteTaskCommand.dispose();
    
    super.dispose();
  }
}
```
```

---

## 4. Testando Commands Oficiais

### Commands com Pattern Result

**Estrutura do Command Oficial**:

```dart
// lib/ui/tasks/view_model/task_commands.dart
abstract class Command<T> extends ChangeNotifier {
  bool _running = false;
  Result<T>? _result;

  bool get running => _running;
  bool get completed => _result != null && _result!.isSuccess;
  bool get error => _result != null && _result!.isFailure;
  Result<T>? get result => _result;

  void clearResult() {
    _result = null;
    notifyListeners();
  }

  Future<Result<T>> _execute();

  Future<Result<T>> execute() async {
    if (_running) return _result ?? const Failure('Command already running');

    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await _execute();
    } catch (e) {
      _result = Failure(e.toString());
    } finally {
      _running = false;
      notifyListeners();
    }

    return _result!;
  }
}

// Command sem parâmetros
class Command0<T> extends Command<T> {
  final CommandAction0<T> _action;
  
  Command0(this._action);
  
  @override
  Future<Result<T>> _execute() => _action();
}

// Command com um parâmetro
class Command1<T, A> extends Command<T> {
  final CommandAction1<T, A> _action;
  A? _lastArgument;
  
  Command1(this._action);
  
  Future<Result<T>> execute([A? argument]) async {
    _lastArgument = argument;
    return super.execute();
  }
  
  @override
  Future<Result<T>> _execute() {
    if (_lastArgument == null) {
      throw ArgumentError('Command1 requires an argument');
    }
    return _action(_lastArgument as A);
  }
}

// Typedefs para actions
typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A argument);
```

**Testes dos Commands**:

```dart
// test/unit/ui/tasks/commands/task_commands_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mastering_tests/ui/tasks/view_model/task_commands.dart';
import 'package:mastering_tests/utils/result.dart';

void main() {
  group('Command0 Tests', () {
    test('should execute command and return success result', () async {
      // Arrange
      const expectedValue = 'success';
      final command = Command0<String>(() async {
        return const Success(expectedValue);
      });

      // Act
      final result = await command.execute();

      // Assert
      expect(result.isSuccess, isTrue);
      expect(result.valueOrNull, equals(expectedValue));
      expect(command.completed, isTrue);
      expect(command.running, isFalse);
      expect(command.error, isFalse);
    });

    test('should handle errors and return failure result', () async {
      // Arrange
      const errorMessage = 'Something went wrong';
      final command = Command0<String>(() async {
        return const Failure(errorMessage);
      });

      // Act
      final result = await command.execute();

      // Assert
      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, equals(errorMessage));
      expect(command.error, isTrue);
      expect(command.running, isFalse);
      expect(command.completed, isFalse);
    });

    test('should prevent multiple executions', () async {
      // Arrange
      var executionCount = 0;
      final command = Command0<String>(() async {
        executionCount++;
        await Future.delayed(const Duration(milliseconds: 100));
        return const Success('done');
      });

      // Act
      final future1 = command.execute();
      final future2 = command.execute(); // Should not execute

      // Assert
      expect(command.running, isTrue);
      
      await future1;
      await future2;
      
      expect(executionCount, equals(1));
      expect(command.running, isFalse);
    });

    test('should notify listeners during execution', () async {
      // Arrange
      final command = Command0<String>(() async {
        await Future.delayed(const Duration(milliseconds: 50));
        return const Success('done');
      });

      var notificationCount = 0;
      command.addListener(() {
        notificationCount++;
      });

      // Act
      await command.execute();

      // Assert
      expect(notificationCount, greaterThanOrEqualTo(2)); // Start and end
    });

    test('should clear result', () async {
      // Arrange
      final command = Command0<String>(() async {
        return const Success('result');
      });

      await command.execute();
      expect(command.result, isNotNull);

      // Act
      command.clearResult();

      // Assert
      expect(command.result, isNull);
      expect(command.completed, isFalse);
      expect(command.error, isFalse);
    });
  });

  group('Command1 Tests', () {
    test('should execute with argument and return success result', () async {
      // Arrange
      const input = 42;
      const expectedValue = 'processed: 42';
      final command = Command1<String, int>((value) async {
        return Success('processed: $value');
      });

      // Act
      final result = await command.execute(input);

      // Assert
      expect(result.isSuccess, isTrue);
      expect(result.valueOrNull, equals(expectedValue));
      expect(command.completed, isTrue);
    });

    test('should throw error when executed without argument', () async {
      // Arrange
      final command = Command1<String, int>((value) async {
        return Success('processed: $value');
      });

      // Act & Assert
      expect(() => command.execute(), throwsA(isA<ArgumentError>()));
    });

    test('should handle errors with arguments', () async {
      // Arrange
      const errorMessage = 'Invalid input';
      final command = Command1<String, int>((value) async {
        return const Failure(errorMessage);
      });

      // Act
      final result = await command.execute(123);

      // Assert
      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, equals(errorMessage));
      expect(command.error, isTrue);
    });
  });
}
```

---

## 5. Testes da Data Layer

### Testando Services (API)

```dart
// test/unit/data/services/task_api_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('TaskApiService', () {
    late TaskApiService service;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      service = TaskApiService(mockDio);
    });

    group('getTasks', () {
      test('should return list of tasks when API call is successful', () async {
        // Arrange
        final responseData = [
          {'id': '1', 'title': 'Task 1', 'description': 'Description 1'},
          {'id': '2', 'title': 'Task 2', 'description': 'Description 2'},
        ];
        
        when(() => mockDio.get('/tasks')).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/tasks'),
          ),
        );

        // Act
        final result = await service.getTasks();

        // Assert
        expect(result, hasLength(2));
        expect(result.first.id, '1');
        expect(result.first.title, 'Task 1');
        verify(() => mockDio.get('/tasks')).called(1);
      });

      test('should throw exception when API call fails', () async {
        // Arrange
        when(() => mockDio.get('/tasks')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/tasks'),
            message: 'Network error',
          ),
        );

        // Act & Assert
        expect(() => service.getTasks(), throwsA(isA<DioException>()));
        verify(() => mockDio.get('/tasks')).called(1);
      });
    });

    group('createTask', () {
      test('should return created task when API call is successful', () async {
        // Arrange
        final taskData = CreateTaskData(
          title: 'New Task',
          description: 'New Description',
        );
        
        final responseData = {
          'id': '3',
          'title': 'New Task',
          'description': 'New Description',
          'is_completed': false,
          'created_at': '2023-01-01T00:00:00Z',
        };
        
        when(() => mockDio.post('/tasks', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
            data: responseData,
            statusCode: 201,
            requestOptions: RequestOptions(path: '/tasks'),
          ));

        // Act
        final result = await service.createTask(taskData);

        // Assert
        expect(result.id, '3');
        expect(result.title, 'New Task');
        verify(() => mockDio.post('/tasks', data: {
          'title': 'New Task',
          'description': 'New Description',
        })).called(1);
      });
    });
  });
}
```

### Testando Repositories

```dart
// test/unit/data/repositories/task_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskApiService extends Mock implements TaskApiService {}

void main() {
  group('SupabaseTaskRepository', () {
    late SupabaseTaskRepository repository;
    late MockTaskApiService mockApiService;

    setUp(() {
      mockApiService = MockTaskApiService();
      repository = SupabaseTaskRepository(mockApiService);
    });

    group('getTasks', () {
      test('should return success result with tasks when service call is successful', () async {
        // Arrange
        final apiTasks = [
          TaskApiModel(
            id: '1',
            title: 'Task 1',
            description: 'Description 1',
            isCompleted: false,
            createdAt: DateTime.parse('2023-01-01T00:00:00Z'),
          ),
        ];
        
        when(() => mockApiService.getTasks())
          .thenAnswer((_) async => apiTasks);

        // Act
        final result = await repository.getTasks();

        // Assert
        expect(result.isSuccess, true);
        result.when(
          success: (tasks) {
            expect(tasks, hasLength(1));
            expect(tasks.first.id, '1');
            expect(tasks.first.title, 'Task 1');
          },
          failure: (_) => fail('Should not be failure'),
        );
        
        verify(() => mockApiService.getTasks()).called(1);
      });

      test('should return failure result when service throws exception', () async {
        // Arrange
        when(() => mockApiService.getTasks())
          .thenThrow(Exception('Network error'));

        // Act
        final result = await repository.getTasks();

        // Assert
        expect(result.isFailure, true);
        result.when(
          success: (_) => fail('Should not be success'),
          failure: (error) => expect(error, contains('Network error')),
        );
        
        verify(() => mockApiService.getTasks()).called(1);
      });
    });

    group('createTask', () {
      test('should return success result with created task', () async {
        // Arrange
        final createData = CreateTaskData(
          title: 'New Task',
          description: 'New Description',
        );
        
        final apiTask = TaskApiModel(
          id: '1',
          title: 'New Task',
          description: 'New Description',
          isCompleted: false,
          createdAt: DateTime.now(),
        );
        
        when(() => mockApiService.createTask(createData))
          .thenAnswer((_) async => apiTask);

        // Act
        final result = await repository.createTask(createData);

        // Assert
        expect(result.isSuccess, true);
        result.when(
          success: (task) {
            expect(task.title, 'New Task');
            expect(task.description, 'New Description');
            expect(task.isCompleted, false);
          },
          failure: (_) => fail('Should not be failure'),
        );
        
        verify(() => mockApiService.createTask(createData)).called(1);
      });
    });
  });
}
```

---

## 6. Testes da Domain Layer

### Testando Modelos

```dart
// test/unit/domain/models/task_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Task', () {
    test('should create task with required fields', () {
      // Arrange & Act
      final task = Task(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        isCompleted: false,
        createdAt: DateTime.parse('2023-01-01T00:00:00Z'),
      );

      // Assert
      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.description, 'Test Description');
      expect(task.isCompleted, false);
      expect(task.createdAt, DateTime.parse('2023-01-01T00:00:00Z'));
      expect(task.completedAt, null);
    });

    test('should create completed task with completedAt date', () {
      // Arrange
      final completedDate = DateTime.parse('2023-01-02T00:00:00Z');
      
      // Act
      final task = Task(
        id: '1',
        title: 'Completed Task',
        description: 'Completed Description',
        isCompleted: true,
        createdAt: DateTime.parse('2023-01-01T00:00:00Z'),
        completedAt: completedDate,
      );

      // Assert
      expect(task.isCompleted, true);
      expect(task.completedAt, completedDate);
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final createdAt = DateTime.parse('2023-01-01T00:00:00Z');
        
        final task1 = Task(
          id: '1',
          title: 'Task',
          description: 'Description',
          isCompleted: false,
          createdAt: createdAt,
        );
        
        final task2 = Task(
          id: '1',
          title: 'Task',
          description: 'Description',
          isCompleted: false,
          createdAt: createdAt,
        );

        // Act & Assert
        expect(task1, equals(task2));
        expect(task1.hashCode, equals(task2.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final createdAt = DateTime.parse('2023-01-01T00:00:00Z');
        
        final task1 = Task(
          id: '1',
          title: 'Task 1',
          description: 'Description',
          isCompleted: false,
          createdAt: createdAt,
        );
        
        final task2 = Task(
          id: '2',
          title: 'Task 2',
          description: 'Description',
          isCompleted: false,
          createdAt: createdAt,
        );

        // Act & Assert
        expect(task1, isNot(equals(task2)));
        expect(task1.hashCode, isNot(equals(task2.hashCode)));
      });
    });

    group('copyWith', () {
      test('should create new instance with updated properties', () {
        // Arrange
        final originalTask = Task(
          id: '1',
          title: 'Original Title',
          description: 'Original Description',
          isCompleted: false,
          createdAt: DateTime.parse('2023-01-01T00:00:00Z'),
        );

        // Act
        final updatedTask = originalTask.copyWith(
          title: 'Updated Title',
          isCompleted: true,
          completedAt: DateTime.parse('2023-01-02T00:00:00Z'),
        );

        // Assert
        expect(updatedTask.id, originalTask.id);
        expect(updatedTask.title, 'Updated Title');
        expect(updatedTask.description, originalTask.description);
        expect(updatedTask.isCompleted, true);
        expect(updatedTask.createdAt, originalTask.createdAt);
        expect(updatedTask.completedAt, DateTime.parse('2023-01-02T00:00:00Z'));
        
        // Original should remain unchanged
        expect(originalTask.title, 'Original Title');
        expect(originalTask.isCompleted, false);
      });
    });
  });
}
```

---

## 7. Testes da UI Layer

### Testando ViewModels com Commands Oficiais

```dart
// test/unit/ui/tasks/view_model/task_view_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mastering_tests/ui/tasks/view_model/task_view_model.dart';
import 'package:mastering_tests/domain/models/task.dart';
import 'package:mastering_tests/utils/result.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  group('TaskViewModel', () {
    late MockTaskRepository mockRepository;
    late TaskViewModel viewModel;

    setUp(() {
      mockRepository = MockTaskRepository();
      viewModel = TaskViewModel(mockRepository);
    });

    tearDown(() {
      viewModel.dispose();
    });

    group('loadTasks', () {
      test('should load tasks successfully', () async {
        // Arrange
        final expectedTasks = [
          const Task(id: '1', title: 'Task 1'),
          const Task(id: '2', title: 'Task 2'),
        ];

        when(() => mockRepository.getTasks())
            .thenAnswer((_) async => Success(expectedTasks));

        // Act
        await viewModel.loadTasks();

        // Assert
        expect(viewModel.tasks, equals(expectedTasks));
        expect(viewModel.isLoading, isFalse);
        expect(viewModel.error, isNull);
        expect(viewModel.loadTasksCommand.completed, isTrue);
      });

      test('should handle load tasks error', () async {
        // Arrange
        const errorMessage = 'Failed to load tasks';
        when(() => mockRepository.getTasks())
            .thenAnswer((_) async => const Failure(errorMessage));

        // Act
        await viewModel.loadTasks();

        // Assert
        expect(viewModel.tasks, isEmpty);
        expect(viewModel.isLoading, isFalse);
        expect(viewModel.error, equals(errorMessage));
        expect(viewModel.loadTasksCommand.error, isTrue);
      });

      test('should set loading state during execution', () async {
        // Arrange
        when(() => mockRepository.getTasks())
            .thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return const Success(<Task>[]);
        });

        // Act
        final future = viewModel.loadTasks();
        
        // Assert loading state
        expect(viewModel.isLoading, isTrue);
        expect(viewModel.loadTasksCommand.running, isTrue);
        
        await future;
        
        expect(viewModel.isLoading, isFalse);
        expect(viewModel.loadTasksCommand.running, isFalse);
      });
    });

    group('createTask', () {
      test('should create task and reload tasks', () async {
        // Arrange
        final taskData = CreateTaskData(title: 'New Task');
        final createdTask = Task(id: '1', title: 'New Task');
        final allTasks = [createdTask];

        when(() => mockRepository.createTask(taskData))
            .thenAnswer((_) async => Success(createdTask));
        when(() => mockRepository.getTasks())
            .thenAnswer((_) async => Success(allTasks));

        // Act
        await viewModel.createTask(taskData);

        // Assert
        expect(viewModel.tasks, equals(allTasks));
        expect(viewModel.createTaskCommand.completed, isTrue);
        expect(viewModel.loadTasksCommand.completed, isTrue);
        verify(() => mockRepository.createTask(taskData)).called(1);
        verify(() => mockRepository.getTasks()).called(1);
      });

      test('should handle create task error', () async {
        // Arrange
        final taskData = CreateTaskData(title: 'New Task');
        const errorMessage = 'Failed to create task';

        when(() => mockRepository.createTask(taskData))
            .thenAnswer((_) async => const Failure(errorMessage));

        // Act
        await viewModel.createTask(taskData);

        // Assert
        expect(viewModel.createTaskCommand.error, isTrue);
        expect(viewModel.createTaskCommand.result?.errorOrNull, equals(errorMessage));
        verifyNever(() => mockRepository.getTasks());
      });
    });

    group('updateTask', () {
      test('should update task and reload tasks', () async {
        // Arrange
        const taskId = '1';
        final updateData = UpdateTaskData(title: 'Updated Task');
        final updatedTask = Task(id: taskId, title: 'Updated Task');
        final allTasks = [updatedTask];

        when(() => mockRepository.updateTask(taskId, updateData))
            .thenAnswer((_) async => Success(updatedTask));
        when(() => mockRepository.getTasks())
            .thenAnswer((_) async => Success(allTasks));

        // Act
        await viewModel.updateTask(taskId, updateData);

        // Assert
        expect(viewModel.tasks, equals(allTasks));
        expect(viewModel.updateTaskCommand.completed, isTrue);
        verify(() => mockRepository.updateTask(taskId, updateData)).called(1);
        verify(() => mockRepository.getTasks()).called(1);
      });
    });

    group('Command States', () {
      test('should prevent multiple command executions', () async {
        // Arrange
        when(() => mockRepository.getTasks())
            .thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return const Success(<Task>[]);
        });

        // Act
        final future1 = viewModel.loadTasks();
        final future2 = viewModel.loadTasks(); // Should not execute

        // Assert
        expect(viewModel.loadTasksCommand.running, isTrue);
        
        await future1;
        await future2;
        
        verify(() => mockRepository.getTasks()).called(1); // Only called once
      });

      test('should clear command results', () async {
        // Arrange
        when(() => mockRepository.getTasks())
            .thenAnswer((_) async => const Success(<Task>[]));

        await viewModel.loadTasks();
        expect(viewModel.loadTasksCommand.result, isNotNull);

        // Act
        viewModel.loadTasksCommand.clearResult();

        // Assert
        expect(viewModel.loadTasksCommand.result, isNull);
        expect(viewModel.loadTasksCommand.completed, isFalse);
        expect(viewModel.loadTasksCommand.error, isFalse);
      });
    });

    group('ChangeNotifier', () {
      test('should notify listeners when state changes', () async {
        // Arrange
        when(() => mockRepository.getTasks())
            .thenAnswer((_) async => const Success(<Task>[]));

        var notificationCount = 0;
        viewModel.addListener(() {
          notificationCount++;
        });

        // Act
        await viewModel.loadTasks();

        // Assert
        expect(notificationCount, greaterThan(0));
      });
    });
  });
}
```

### Testando Commands Oficiais

```dart
// test/unit/ui/tasks/commands/task_commands_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  group('TaskCommands', () {
    late MockTaskRepository mockRepository;

    setUp(() {
      mockRepository = MockTaskRepository();
    });

    group('CreateTaskCommand', () {
      test('should execute successfully and call onSuccess', () async {
        // Arrange
        final createData = CreateTaskData(
          title: 'New Task',
          description: 'New Description',
        );
        
        final createdTask = Task(
          id: '1',
          title: 'New Task',
          description: 'New Description',
          isCompleted: false,
          createdAt: DateTime.now(),
        );
        
        when(() => mockRepository.createTask(createData))
          .thenAnswer((_) async => Result.success(createdTask));

        bool onSuccessCalled = false;
        String? onErrorCalled;

        final command = CreateTaskCommand(
          mockRepository,
          createData,
          onSuccess: () => onSuccessCalled = true,
          onError: (error) => onErrorCalled = error,
        );

        // Act
        await command.execute();

        // Assert
        expect(onSuccessCalled, true);
        expect(onErrorCalled, null);
        verify(() => mockRepository.createTask(createData)).called(1);
      });

      test('should execute with failure and call onError', () async {
        // Arrange
        final createData = CreateTaskData(
          title: 'New Task',
          description: 'New Description',
        );
        
        const errorMessage = 'Failed to create task';
        
        when(() => mockRepository.createTask(createData))
          .thenAnswer((_) async => Result.failure(errorMessage));

        bool onSuccessCalled = false;
        String? onErrorCalled;

        final command = CreateTaskCommand(
          mockRepository,
          createData,
          onSuccess: () => onSuccessCalled = true,
          onError: (error) => onErrorCalled = error,
        );

        // Act
        await command.execute();

        // Assert
        expect(onSuccessCalled, false);
        expect(onErrorCalled, errorMessage);
        verify(() => mockRepository.createTask(createData)).called(1);
      });

      test('should execute without callbacks', () async {
        // Arrange
        final createData = CreateTaskData(
          title: 'New Task',
          description: 'New Description',
        );
        
        final createdTask = Task(
          id: '1',
          title: 'New Task',
          description: 'New Description',
          isCompleted: false,
          createdAt: DateTime.now(),
        );
        
        when(() => mockRepository.createTask(createData))
          .thenAnswer((_) async => Result.success(createdTask));

        final command = CreateTaskCommand(mockRepository, createData);

        // Act & Assert - Should not throw
        await command.execute();
        
        verify(() => mockRepository.createTask(createData)).called(1);
      });
    });

    group('UpdateTaskCommand', () {
      test('should execute successfully and call onSuccess', () async {
        // Arrange
        const taskId = '1';
        final updateData = UpdateTaskData(
          title: 'Updated Task',
          isCompleted: true,
        );
        
        final updatedTask = Task(
          id: taskId,
          title: 'Updated Task',
          description: 'Description',
          isCompleted: true,
          createdAt: DateTime.now(),
          completedAt: DateTime.now(),
        );
        
        when(() => mockRepository.updateTask(taskId, updateData))
          .thenAnswer((_) async => Result.success(updatedTask));

        bool onSuccessCalled = false;
        String? onErrorCalled;

        final command = UpdateTaskCommand(
          mockRepository,
          taskId,
          updateData,
          onSuccess: () => onSuccessCalled = true,
          onError: (error) => onErrorCalled = error,
        );

        // Act
        await command.execute();

        // Assert
        expect(onSuccessCalled, true);
        expect(onErrorCalled, null);
        verify(() => mockRepository.updateTask(taskId, updateData)).called(1);
      });
    });

    group('DeleteTaskCommand', () {
      test('should execute successfully and call onSuccess', () async {
        // Arrange
        const taskId = '1';
        
        when(() => mockRepository.deleteTask(taskId))
          .thenAnswer((_) async => Result.success(null));

        bool onSuccessCalled = false;
        String? onErrorCalled;

        final command = DeleteTaskCommand(
          mockRepository,
          taskId,
          onSuccess: () => onSuccessCalled = true,
          onError: (error) => onErrorCalled = error,
        );

        // Act
        await command.execute();

        // Assert
        expect(onSuccessCalled, true);
        expect(onErrorCalled, null);
        verify(() => mockRepository.deleteTask(taskId)).called(1);
      });
    });
  });
}
```

---

## 8. Mocking com Mocktail

### Configuração de Mocks

```dart
// testing/mocks/task_mocks.dart
import 'package:mocktail/mocktail.dart';

// Mocks para Data Layer
class MockTaskApiService extends Mock implements TaskApiService {}
class MockTaskRepository extends Mock implements TaskRepository {}
class MockDio extends Mock implements Dio {}

// Mocks para External Dependencies
class MockSupabaseClient extends Mock implements SupabaseClient {}

// Setup de Fallback Values (se necessário)
void setupTaskMocks() {
  // Registrar fallback values para tipos customizados
  registerFallbackValue(CreateTaskData(title: '', description: ''));
  registerFallbackValue(UpdateTaskData());
  registerFallbackValue(RequestOptions(path: ''));
}
```

### Melhores Práticas de Mocking

#### 1. Mock por Teste vs Mock Compartilhado

```dart
void main() {
  group('TaskViewModel', () {
    late TaskViewModel viewModel;
    late MockTaskRepository mockRepository;

    // Mock compartilhado para o grupo
    setUp(() {
      mockRepository = MockTaskRepository();
      viewModel = TaskViewModel(mockRepository);
    });

    test('specific test', () async {
      // Mock específico para este teste
      when(() => mockRepository.getTasks())
        .thenAnswer((_) async => Result.success([]));
      
      // Test implementation...
    });
  });
}
```

#### 2. Verificação de Chamadas

```dart
test('should call repository with correct parameters', () async {
  // Arrange
  final createData = CreateTaskData(title: 'Test', description: 'Test');
  when(() => mockRepository.createTask(any()))
    .thenAnswer((_) async => Result.success(mockTask));

  // Act
  await viewModel.createTask(createData);

  // Assert - Verificações específicas
  verify(() => mockRepository.createTask(createData)).called(1);
  verifyNever(() => mockRepository.deleteTask(any()));
  verifyNoMoreInteractions(mockRepository);
});
```

#### 3. Argumentos Complexos

```dart
test('should call API with correct request body', () async {
  // Arrange
  when(() => mockDio.post(
    any(),
    data: any(named: 'data'),
    options: any(named: 'options'),
  )).thenAnswer((_) async => mockResponse);

  // Act
  await service.createTask(createData);

  // Assert - Capturar e verificar argumentos
  final captured = verify(() => mockDio.post(
    captureAny(),
    data: captureAny(named: 'data'),
  )).captured;
  
  expect(captured[0], '/tasks');
  expect(captured[1], {
    'title': createData.title,
    'description': createData.description,
  });
});
```

#### 4. Mocking de Streams

```dart
class MockTaskStreamRepository extends Mock implements TaskStreamRepository {}

test('should listen to task updates', () async {
  // Arrange
  final controller = StreamController<List<Task>>();
  when(() => mockStreamRepository.taskStream)
    .thenAnswer((_) => controller.stream);

  final tasks = [mockTask1, mockTask2];
  final receivedTasks = <List<Task>>[];

  // Act
  viewModel.taskStream.listen(receivedTasks.add);
  controller.add(tasks);
  await Future.delayed(Duration.zero); // Allow stream to emit

  // Assert
  expect(receivedTasks, [tasks]);
  
  // Cleanup
  controller.close();
});
```

---

## 9. Patterns de Teste

### Test Data Builders

```dart
// testing/builders/task_builder.dart
class TaskBuilder {
  String _id = '1';
  String _title = 'Default Task';
  String _description = 'Default Description';
  bool _isCompleted = false;
  DateTime _createdAt = DateTime.parse('2023-01-01T00:00:00Z');
  DateTime? _completedAt;

  TaskBuilder withId(String id) {
    _id = id;
    return this;
  }

  TaskBuilder withTitle(String title) {
    _title = title;
    return this;
  }

  TaskBuilder completed() {
    _isCompleted = true;
    _completedAt = DateTime.parse('2023-01-02T00:00:00Z');
    return this;
  }

  TaskBuilder createdAt(DateTime date) {
    _createdAt = date;
    return this;
  }

  Task build() {
    return Task(
      id: _id,
      title: _title,
      description: _description,
      isCompleted: _isCompleted,
      createdAt: _createdAt,
      completedAt: _completedAt,
    );
  }
}

// Usage em testes
test('should handle completed tasks', () {
  final task = TaskBuilder()
    .withTitle('Important Task')
    .completed()
    .build();
    
  expect(task.isCompleted, true);
  expect(task.completedAt, isNotNull);
});
```

### Object Mother Pattern

```dart
// testing/mothers/task_mother.dart
class TaskMother {
  static Task simple() {
    return TaskBuilder().build();
  }

  static Task completed() {
    return TaskBuilder().completed().build();
  }

  static Task withTitle(String title) {
    return TaskBuilder().withTitle(title).build();
  }

  static Task urgent() {
    return TaskBuilder()
      .withTitle('URGENT: Complete now')
      .withDescription('This task requires immediate attention')
      .build();
  }

  static List<Task> manyTasks(int count) {
    return List.generate(
      count,
      (index) => TaskBuilder()
        .withId('task_$index')
        .withTitle('Task $index')
        .build(),
    );
  }

  static List<Task> mixedTasks() {
    return [
      simple(),
      completed(),
      urgent(),
    ];
  }
}

// Usage em testes
test('should display task count correctly', () {
  final tasks = TaskMother.manyTasks(5);
  
  // Test implementation...
});
```

### Custom Matchers

```dart
// testing/matchers/task_matchers.dart
Matcher isTaskWithTitle(String title) {
  return predicate<Task>(
    (task) => task.title == title,
    'Task with title "$title"',
  );
}

Matcher isCompletedTask() {
  return predicate<Task>(
    (task) => task.isCompleted && task.completedAt != null,
    'Completed task',
  );
}

Matcher hasTaskCount(int count) {
  return predicate<List<Task>>(
    (tasks) => tasks.length == count,
    'List with $count tasks',
  );
}

// Usage em testes
test('should mark task as completed', () {
  final task = TaskMother.simple();
  final completedTask = task.copyWith(
    isCompleted: true,
    completedAt: DateTime.now(),
  );
  
  expect(completedTask, isCompletedTask());
});
```

### Test Fixtures

```dart
// testing/fixtures/task_fixtures.dart
class TaskFixtures {
  static const String singleTaskJson = '''
    {
      "id": "1",
      "title": "Test Task",
      "description": "Test Description",
      "is_completed": false,
      "created_at": "2023-01-01T00:00:00Z"
    }
  ''';

  static const String tasksListJson = '''
    [
      {
        "id": "1",
        "title": "Task 1",
        "description": "Description 1",
        "is_completed": false,
        "created_at": "2023-01-01T00:00:00Z"
      },
      {
        "id": "2",
        "title": "Task 2",
        "description": "Description 2",
        "is_completed": true,
        "created_at": "2023-01-01T00:00:00Z",
        "completed_at": "2023-01-02T00:00:00Z"
      }
    ]
  ''';

  static Map<String, dynamic> get singleTaskMap {
    return json.decode(singleTaskJson) as Map<String, dynamic>;
  }

  static List<Map<String, dynamic>> get tasksListMap {
    return (json.decode(tasksListJson) as List)
      .cast<Map<String, dynamic>>();
  }
}
```

---

## 10. Melhores Práticas

### Estrutura de Teste

#### 1. Padrão AAA (Arrange, Act, Assert)

```dart
test('should create task successfully', () async {
  // Arrange - Preparar dados e mocks
  final createData = CreateTaskData(title: 'Test', description: 'Test');
  final expectedTask = TaskMother.simple();
  
  when(() => mockRepository.createTask(createData))
    .thenAnswer((_) async => Result.success(expectedTask));

  // Act - Executar a ação
  final result = await useCase.createTask(createData);

  // Assert - Verificar resultados
  expect(result.isSuccess, true);
  result.when(
    success: (task) => expect(task.title, 'Test'),
    failure: (_) => fail('Should not fail'),
  );
  
  verify(() => mockRepository.createTask(createData)).called(1);
});
```

#### 2. Naming Conventions

```dart
group('TaskViewModel', () {
  group('loadTasks', () {
    test('should load tasks successfully when repository returns data', () {
      // Test implementation
    });

    test('should emit loading state during task loading', () {
      // Test implementation
    });

    test('should handle error when repository fails', () {
      // Test implementation
    });
  });

  group('createTask', () {
    test('should create task and reload list when successful', () {
      // Test implementation
    });

    test('should show error message when creation fails', () {
      // Test implementation
    });
  });
});
```

#### 3. Test Organization

```dart
void main() {
  group('TaskRepository', () {
    late TaskRepository repository;
    late MockTaskApiService mockApiService;

    setUp(() {
      mockApiService = MockTaskApiService();
      repository = SupabaseTaskRepository(mockApiService);
    });

    tearDown(() {
      // Cleanup if needed
    });

    setUpAll(() {
      // One-time setup for the entire group
    });

    tearDownAll(() {
      // One-time cleanup for the entire group
    });

    // Tests here...
  });
}
```

### Cobertura de Testes

#### 1. Executar Testes com Cobertura

```bash
# Executar todos os testes com cobertura
flutter test --coverage

# Gerar relatório HTML
genhtml coverage/lcov.info -o coverage/html

# Abrir relatório
open coverage/html/index.html
```

#### 2. Configuração de Cobertura

```yaml
# analysis_options.yaml
analyzer:
  exclude:
    - "lib/**.g.dart"
    - "lib/**.freezed.dart"
    - "build/**"

linter:
  rules:
    # Lint rules...

coverage:
  exclude:
    - "lib/main.dart"
    - "lib/main_*.dart"
    - "lib/**/models/*.dart"  # Se são apenas data classes
```

#### 3. Metas de Cobertura

- **Data Layer**: 90-95% (alta cobertura por ser crítica)
- **Domain Layer**: 95-100% (lógica de negócio)
- **UI Layer**: 70-85% (ViewModels e Commands)
- **Widgets**: 60-70% (testes de widget específicos)

### Performance de Testes

#### 1. Testes Paralelos

```bash
# Executar testes em paralelo
flutter test --concurrency=4
```

#### 2. Testes Focados

```dart
// Executar apenas um grupo
flutter test test/unit/data/repositories/task_repository_test.dart

// Executar com pattern
flutter test --name "TaskViewModel"
```

#### 3. Otimização de Mocks

```dart
// Evitar criar mocks complexos desnecessariamente
class LightweightMockRepository extends Mock implements TaskRepository {
  // Implementar apenas métodos usados nos testes
}

// Usar fake objects quando apropriado
class FakeTaskRepository implements TaskRepository {
  final List<Task> _tasks = [];

  @override
  Future<Result<List<Task>>> getTasks() async {
    return Result.success(List.from(_tasks));
  }

  @override
  Future<Result<Task>> createTask(CreateTaskData data) async {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: data.title,
      description: data.description,
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    _tasks.add(task);
    return Result.success(task);
  }
}
```

### Debugging de Testes

#### 1. Debugging no VS Code

```json
// .vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug Tests",
      "request": "launch",
      "type": "dart",
      "program": "test/unit/ui/tasks/view_model/task_view_model_test.dart"
    }
  ]
}
```

#### 2. Logging em Testes

```dart
test('should handle complex scenario', () async {
  // Use print para debugging temporário
  print('Starting test with data: $testData');
  
  // Use debugPrint em widgets
  debugPrint('Widget state: ${widget.toString()}');
  
  // Use expectLater para verificar streams
  expectLater(
    stream,
    emitsInOrder([
      predicate<int>((value) {
        print('Stream emitted: $value');
        return value > 0;
      }),
    ]),
  );
});
```

### Continuous Integration

#### 1. GitHub Actions

```yaml
# .github/workflows/test.yml
name: Tests

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.16.0'
        
    - name: Install dependencies
      run: flutter pub get
      
    - name: Analyze code
      run: flutter analyze
      
    - name: Run tests
      run: flutter test --coverage
      
    - name: Upload coverage
      uses: codecov/codecov-action@v3
      with:
        file: coverage/lcov.info
```

#### 2. Scripts de Automação

```bash
#!/bin/bash
# scripts/test.sh

echo "🧪 Running Flutter Tests..."

# Verificar dependências
flutter pub get

# Executar análise estática
echo "📊 Running static analysis..."
flutter analyze

# Executar testes unitários
echo "🔬 Running unit tests..."
flutter test test/unit/ --coverage

# Executar testes de widget
echo "🎨 Running widget tests..."
flutter test test/widget/

# Gerar relatório de cobertura
echo "📈 Generating coverage report..."
genhtml coverage/lcov.info -o coverage/html

echo "✅ All tests completed!"
echo "📊 Coverage report available at: coverage/html/index.html"
```

---

## Conclusão

Este tutorial fornece uma base sólida para implementar testes unitários em Flutter seguindo a arquitetura oficial. As principais takeaways são:

### 🎯 Pontos Chave

1. **Arquitetura em Camadas**: Separe responsabilidades e teste cada camada isoladamente
2. **Inversão de Dependência**: Use interfaces para facilitar o mocking
3. **Patterns de Teste**: Implemente Builder, Object Mother, e Custom Matchers
4. **Mocktail**: Ferramenta poderosa para mocking sem boilerplate
5. **Cobertura**: Mantenha alta cobertura nas camadas críticas
6. **CI/CD**: Automatize execução de testes no pipeline

### 🚀 Próximos Passos

1. Implemente testes de integração
2. Adicione testes de golden (screenshot)
3. Configure performance testing
4. Implemente testes E2E com integration_test

### 📚 Recursos Adicionais

- [Documentação Oficial de Testes Flutter](https://docs.flutter.dev/testing)
- [Mocktail Documentation](https://pub.dev/packages/mocktail)
- [Flutter Architecture Guide](https://docs.flutter.dev/app-architecture)
- [Test-Driven Development in Flutter](https://flutter.dev/docs/cookbook/testing)

---

**Happy Testing! 🧪✨**
