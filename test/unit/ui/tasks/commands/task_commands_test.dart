import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mastering_tests/ui/tasks/view_model/task_commands.dart';
import 'package:mastering_tests/data/repositories/task_repository.dart';
import 'package:mastering_tests/domain/models/task.dart';
import 'package:mastering_tests/utils/result.dart';

// Mocks
class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  group('Command Pattern - Official Flutter Implementation', () {
    late MockTaskRepository mockRepository;

    setUp(() {
      mockRepository = MockTaskRepository();
    });

    setUpAll(() {
      // Register fallback values
      registerFallbackValue(CreateTaskData(title: '', description: ''));
      registerFallbackValue(UpdateTaskData());
    });

    group('Command0 - Load Tasks', () {
      test('should execute successfully and return success result', () async {
        // Arrange
        final tasks = [
          Task(
            id: '1',
            title: 'Task 1',
            description: 'Description 1',
            isCompleted: false,
            createdAt: DateTime.now(),
          ),
          Task(
            id: '2',
            title: 'Task 2',
            description: 'Description 2',
            isCompleted: true,
            createdAt: DateTime.now(),
          ),
        ];
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success(tasks));

        final command = Command0<List<Task>>(() async {
          return await mockRepository.getTasks();
        });

        // Act
        await command.execute();

        // Assert
        expect(command.running, false);
        expect(command.completed, true);
        expect(command.error, false);
        expect(command.result, isA<Success<List<Task>>>());
        
        final result = command.result as Success<List<Task>>;
        expect(result.data, tasks);
        
        verify(() => mockRepository.getTasks()).called(1);
      });

      test('should execute with failure and return error result', () async {
        // Arrange
        const errorMessage = 'Failed to load tasks';
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.failure(errorMessage));

        final command = Command0<List<Task>>(() async {
          return await mockRepository.getTasks();
        });

        // Act
        await command.execute();

        // Assert
        expect(command.running, false);
        expect(command.completed, false);
        expect(command.error, true);
        expect(command.result, isA<Failure<List<Task>>>());
        
        final result = command.result as Failure<List<Task>>;
        expect(result.error, errorMessage);
        
        verify(() => mockRepository.getTasks()).called(1);
      });

      test('should not execute multiple times when already running', () async {
        // Arrange
        const tasks = <Task>[];
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async {
            await Future.delayed(const Duration(milliseconds: 100));
            return Result.success(tasks);
          });

        final command = Command0<List<Task>>(() async {
          return await mockRepository.getTasks();
        });

        // Act
        final future1 = command.execute();
        final future2 = command.execute(); // Should not execute

        await Future.wait([future1, future2]);

        // Assert
        verify(() => mockRepository.getTasks()).called(1); // Only called once
      });

      test('should clear result when clearResult is called', () async {
        // Arrange
        const tasks = <Task>[];
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success(tasks));

        final command = Command0<List<Task>>(() async {
          return await mockRepository.getTasks();
        });

        // Act
        await command.execute();
        expect(command.result, isNotNull);
        
        command.clearResult();

        // Assert
        expect(command.result, isNull);
        expect(command.completed, false);
        expect(command.error, false);
      });
    });

    group('Command1 - Create Task', () {
      test('should execute successfully with argument', () async {
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

        final command = Command1<Task, CreateTaskData>((data) async {
          return await mockRepository.createTask(data);
        });

        // Act
        await command.execute(createData);

        // Assert
        expect(command.running, false);
        expect(command.completed, true);
        expect(command.error, false);
        expect(command.result, isA<Success<Task>>());
        
        final result = command.result as Success<Task>;
        expect(result.data, createdTask);
        
        verify(() => mockRepository.createTask(createData)).called(1);
      });

      test('should execute with failure', () async {
        // Arrange
        final createData = CreateTaskData(
          title: 'New Task',
          description: 'New Description',
        );
        
        const errorMessage = 'Failed to create task';
        
        when(() => mockRepository.createTask(createData))
          .thenAnswer((_) async => Result.failure(errorMessage));

        final command = Command1<Task, CreateTaskData>((data) async {
          return await mockRepository.createTask(data);
        });

        // Act
        await command.execute(createData);

        // Assert
        expect(command.running, false);
        expect(command.completed, false);
        expect(command.error, true);
        expect(command.result, isA<Failure<Task>>());
        
        final result = command.result as Failure<Task>;
        expect(result.error, errorMessage);
        
        verify(() => mockRepository.createTask(createData)).called(1);
      });
    });

    group('Command1 - Update Task', () {
      test('should execute successfully with record argument', () async {
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

        final command = Command1<Task, ({String id, UpdateTaskData data})>((params) async {
          return await mockRepository.updateTask(params.id, params.data);
        });

        // Act
        await command.execute((id: taskId, data: updateData));

        // Assert
        expect(command.running, false);
        expect(command.completed, true);
        expect(command.error, false);
        expect(command.result, isA<Success<Task>>());
        
        final result = command.result as Success<Task>;
        expect(result.data, updatedTask);
        
        verify(() => mockRepository.updateTask(taskId, updateData)).called(1);
      });
    });

    group('Command1 - Delete Task', () {
      test('should execute successfully with string argument', () async {
        // Arrange
        const taskId = '1';
        
        when(() => mockRepository.deleteTask(taskId))
          .thenAnswer((_) async => Result.success(null));

        final command = Command1<void, String>((id) async {
          return await mockRepository.deleteTask(id);
        });

        // Act
        await command.execute(taskId);

        // Assert
        expect(command.running, false);
        expect(command.completed, true);
        expect(command.error, false);
        expect(command.result, isA<Success<void>>());
        
        verify(() => mockRepository.deleteTask(taskId)).called(1);
      });
    });

    group('Command Notifications', () {
      test('should notify listeners when state changes', () async {
        // Arrange
        const tasks = <Task>[];
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async {
            await Future.delayed(const Duration(milliseconds: 50));
            return Result.success(tasks);
          });

        final command = Command0<List<Task>>(() async {
          return await mockRepository.getTasks();
        });

        final notifications = <String>[];
        
        command.addListener(() {
          if (command.running) {
            notifications.add('running');
          } else if (command.completed) {
            notifications.add('completed');
          } else if (command.error) {
            notifications.add('error');
          }
        });

        // Act
        await command.execute();

        // Assert
        expect(notifications, ['running', 'completed']);
      });

      test('should notify listeners on error', () async {
        // Arrange
        const errorMessage = 'Test error';
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async {
            await Future.delayed(const Duration(milliseconds: 50));
            return Result.failure(errorMessage);
          });

        final command = Command0<List<Task>>(() async {
          return await mockRepository.getTasks();
        });

        final notifications = <String>[];
        
        command.addListener(() {
          if (command.running) {
            notifications.add('running');
          } else if (command.error) {
            notifications.add('error');
          }
        });

        // Act
        await command.execute();

        // Assert
        expect(notifications, ['running', 'error']);
      });
    });

    group('Command Integration', () {
      test('should handle complex workflow with multiple commands', () async {
        // Arrange
        final createData = CreateTaskData(
          title: 'New Task',
          description: 'Description',
        );
        
        final createdTask = Task(
          id: '1',
          title: 'New Task',
          description: 'Description',
          isCompleted: false,
          createdAt: DateTime.now(),
        );
        
        final completedTask = createdTask.copyWith(
          isCompleted: true,
          completedAt: DateTime.now(),
        );
        
        when(() => mockRepository.createTask(createData))
          .thenAnswer((_) async => Result.success(createdTask));
        
        when(() => mockRepository.updateTask('1', any()))
          .thenAnswer((_) async => Result.success(completedTask));

        final createCommand = Command1<Task, CreateTaskData>((data) async {
          return await mockRepository.createTask(data);
        });
        
        final completeCommand = Command1<Task, String>((id) async {
          final updateData = UpdateTaskData(isCompleted: true);
          return await mockRepository.updateTask(id, updateData);
        });

        // Act
        await createCommand.execute(createData);
        await completeCommand.execute('1');

        // Assert
        expect(createCommand.completed, true);
        expect(completeCommand.completed, true);
        
        verify(() => mockRepository.createTask(createData)).called(1);
        verify(() => mockRepository.updateTask('1', any())).called(1);
      });
    });
  });
}
