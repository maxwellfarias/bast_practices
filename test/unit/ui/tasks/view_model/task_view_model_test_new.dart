import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mastering_tests/ui/tasks/view_model/task_view_model.dart';
import 'package:mastering_tests/data/repositories/task_repository.dart';
import 'package:mastering_tests/domain/models/task.dart';
import 'package:mastering_tests/utils/result.dart';

// Mocks
class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  group('TaskViewModel with Official Command Pattern', () {
    late TaskViewModel viewModel;
    late MockTaskRepository mockRepository;

    setUp(() {
      mockRepository = MockTaskRepository();
      viewModel = TaskViewModel(mockRepository);
    });

    tearDown(() {
      try {
        viewModel.dispose();
      } catch (_) {
        // Already disposed
      }
    });

    setUpAll(() {
      // Register fallback values
      registerFallbackValue(CreateTaskData(title: '', description: ''));
      registerFallbackValue(UpdateTaskData());
    });

    group('initial state', () {
      test('should have correct initial values', () {
        // Assert
        expect(viewModel.tasks, isEmpty);
        expect(viewModel.isLoading, false);
        expect(viewModel.error, null);
        expect(viewModel.totalTasks, 0);
        expect(viewModel.completedCount, 0);
        expect(viewModel.pendingCount, 0);
        expect(viewModel.completedTasks, isEmpty);
        expect(viewModel.pendingTasks, isEmpty);
      });

      test('should initialize all commands', () {
        // Assert
        expect(viewModel.loadTasksCommand, isNotNull);
        expect(viewModel.createTaskCommand, isNotNull);
        expect(viewModel.updateTaskCommand, isNotNull);
        expect(viewModel.deleteTaskCommand, isNotNull);
        expect(viewModel.completeTaskCommand, isNotNull);
        expect(viewModel.uncompleteTaskCommand, isNotNull);
      });
    });

    group('loadTasks', () {
      test('should load tasks successfully and update state', () async {
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

        // Act
        await viewModel.loadTasks();

        // Assert
        expect(viewModel.tasks, tasks);
        expect(viewModel.isLoading, false);
        expect(viewModel.error, null);
        expect(viewModel.totalTasks, 2);
        expect(viewModel.completedCount, 1);
        expect(viewModel.pendingCount, 1);
        expect(viewModel.loadTasksCommand.completed, true);
        expect(viewModel.loadTasksCommand.error, false);
        
        verify(() => mockRepository.getTasks()).called(1);
      });

      test('should handle load tasks failure', () async {
        // Arrange
        const errorMessage = 'Failed to load tasks';
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.failure(errorMessage));

        // Act
        await viewModel.loadTasks();

        // Assert
        expect(viewModel.tasks, isEmpty);
        expect(viewModel.isLoading, false);
        expect(viewModel.error, errorMessage);
        expect(viewModel.loadTasksCommand.completed, false);
        expect(viewModel.loadTasksCommand.error, true);
        
        verify(() => mockRepository.getTasks()).called(1);
      });

      test('should update loading state during execution', () async {
        // Arrange
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async {
            await Future.delayed(const Duration(milliseconds: 100));
            return Result.success(<Task>[]);
          });

        // Act & Assert
        final future = viewModel.loadTasks();
        
        // Check loading state is true during execution
        expect(viewModel.isLoading, true);
        expect(viewModel.loadTasksCommand.running, true);
        
        await future;
        
        // Check loading state is false after completion
        expect(viewModel.isLoading, false);
        expect(viewModel.loadTasksCommand.running, false);
      });
    });

    group('createTask', () {
      test('should create task and reload tasks on success', () async {
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
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success([createdTask]));

        // Act
        await viewModel.createTask(createData);

        // Assert
        expect(viewModel.tasks, [createdTask]);
        expect(viewModel.error, null);
        expect(viewModel.totalTasks, 1);
        expect(viewModel.pendingCount, 1);
        expect(viewModel.completedCount, 0);
        expect(viewModel.createTaskCommand.completed, true);
        expect(viewModel.createTaskCommand.error, false);
        
        verify(() => mockRepository.createTask(createData)).called(1);
        verify(() => mockRepository.getTasks()).called(1); // Auto-reload
      });

      test('should handle create task failure', () async {
        // Arrange
        final createData = CreateTaskData(
          title: 'New Task',
          description: 'New Description',
        );
        
        const errorMessage = 'Failed to create task';
        
        when(() => mockRepository.createTask(createData))
          .thenAnswer((_) async => Result.failure(errorMessage));

        // Act
        await viewModel.createTask(createData);

        // Assert
        expect(viewModel.error, errorMessage);
        expect(viewModel.createTaskCommand.completed, false);
        expect(viewModel.createTaskCommand.error, true);
        
        verify(() => mockRepository.createTask(createData)).called(1);
        verifyNever(() => mockRepository.getTasks()); // No reload on failure
      });
    });

    group('updateTask', () {
      test('should update task and reload tasks on success', () async {
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
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success([updatedTask]));

        // Act
        await viewModel.updateTask(taskId, updateData);

        // Assert
        expect(viewModel.tasks, [updatedTask]);
        expect(viewModel.error, null);
        expect(viewModel.updateTaskCommand.completed, true);
        expect(viewModel.updateTaskCommand.error, false);
        
        verify(() => mockRepository.updateTask(taskId, updateData)).called(1);
        verify(() => mockRepository.getTasks()).called(1); // Auto-reload
      });
    });

    group('deleteTask', () {
      test('should delete task and reload tasks on success', () async {
        // Arrange
        const taskId = '1';
        
        when(() => mockRepository.deleteTask(taskId))
          .thenAnswer((_) async => Result.success(null));
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success([]));

        // Act
        await viewModel.deleteTask(taskId);

        // Assert
        expect(viewModel.tasks, isEmpty);
        expect(viewModel.error, null);
        expect(viewModel.totalTasks, 0);
        expect(viewModel.deleteTaskCommand.completed, true);
        expect(viewModel.deleteTaskCommand.error, false);
        
        verify(() => mockRepository.deleteTask(taskId)).called(1);
        verify(() => mockRepository.getTasks()).called(1); // Auto-reload
      });
    });

    group('completeTask', () {
      test('should complete task and reload tasks on success', () async {
        // Arrange
        const taskId = '1';
        
        final completedTask = Task(
          id: taskId,
          title: 'Task',
          description: 'Description',
          isCompleted: true,
          createdAt: DateTime.now(),
          completedAt: DateTime.now(),
        );
        
        when(() => mockRepository.updateTask(taskId, any()))
          .thenAnswer((_) async => Result.success(completedTask));
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success([completedTask]));

        // Act
        await viewModel.completeTask(taskId);

        // Assert
        expect(viewModel.tasks, [completedTask]);
        expect(viewModel.error, null);
        expect(viewModel.completedCount, 1);
        expect(viewModel.pendingCount, 0);
        expect(viewModel.completeTaskCommand.completed, true);
        expect(viewModel.completeTaskCommand.error, false);
        
        // Verify correct update data was used
        final capturedUpdateData = verify(() => mockRepository.updateTask(
          taskId,
          captureAny(),
        )).captured.first as UpdateTaskData;
        
        expect(capturedUpdateData.isCompleted, true);
        verify(() => mockRepository.getTasks()).called(1); // Auto-reload
      });
    });

    group('uncompleteTask', () {
      test('should uncomplete task and reload tasks on success', () async {
        // Arrange
        const taskId = '1';
        
        final uncompletedTask = Task(
          id: taskId,
          title: 'Task',
          description: 'Description',
          isCompleted: false,
          createdAt: DateTime.now(),
        );
        
        when(() => mockRepository.updateTask(taskId, any()))
          .thenAnswer((_) async => Result.success(uncompletedTask));
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success([uncompletedTask]));

        // Act
        await viewModel.uncompleteTask(taskId);

        // Assert
        expect(viewModel.tasks, [uncompletedTask]);
        expect(viewModel.error, null);
        expect(viewModel.completedCount, 0);
        expect(viewModel.pendingCount, 1);
        expect(viewModel.uncompleteTaskCommand.completed, true);
        expect(viewModel.uncompleteTaskCommand.error, false);
        
        // Verify correct update data was used
        final capturedUpdateData = verify(() => mockRepository.updateTask(
          taskId,
          captureAny(),
        )).captured.first as UpdateTaskData;
        
        expect(capturedUpdateData.isCompleted, false);
        verify(() => mockRepository.getTasks()).called(1); // Auto-reload
      });
    });

    group('toggleTaskCompletion', () {
      test('should complete task when currently incomplete', () async {
        // Arrange
        const taskId = '1';
        
        final incompleteTask = Task(
          id: taskId,
          title: 'Task',
          description: 'Description',
          isCompleted: false,
          createdAt: DateTime.now(),
        );
        
        final completedTask = incompleteTask.copyWith(
          isCompleted: true,
          completedAt: DateTime.now(),
        );
        
        // Setup initial state with incomplete task
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success([incompleteTask]));
        
        await viewModel.loadTasks();
        
        when(() => mockRepository.updateTask(taskId, any()))
          .thenAnswer((_) async => Result.success(completedTask));
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success([completedTask]));

        // Act
        await viewModel.toggleTaskCompletion(taskId);

        // Assert
        final capturedUpdateData = verify(() => mockRepository.updateTask(
          taskId,
          captureAny(),
        )).captured.first as UpdateTaskData;
        
        expect(capturedUpdateData.isCompleted, true);
      });

      test('should uncomplete task when currently complete', () async {
        // Arrange
        const taskId = '1';
        
        final completedTask = Task(
          id: taskId,
          title: 'Task',
          description: 'Description',
          isCompleted: true,
          createdAt: DateTime.now(),
          completedAt: DateTime.now(),
        );
        
        final incompleteTask = completedTask.copyWith(
          isCompleted: false,
          completedAt: null,
        );
        
        // Setup initial state with completed task
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success([completedTask]));
        
        await viewModel.loadTasks();
        
        when(() => mockRepository.updateTask(taskId, any()))
          .thenAnswer((_) async => Result.success(incompleteTask));
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success([incompleteTask]));

        // Act
        await viewModel.toggleTaskCompletion(taskId);

        // Assert
        final capturedUpdateData = verify(() => mockRepository.updateTask(
          taskId,
          captureAny(),
        )).captured.first as UpdateTaskData;
        
        expect(capturedUpdateData.isCompleted, false);
      });
    });

    group('utility methods', () {
      test('clearError should clear current error', () {
        // Arrange
        viewModel.loadTasksCommand.addListener(() {
          if (viewModel.loadTasksCommand.error) {
            // Simulate error state
            viewModel.clearError();
          }
        });
        
        // Act
        viewModel.clearError();

        // Assert - Error should be null after clearing
        expect(viewModel.error, null);
      });

      test('getTaskById should return correct task', () async {
        // Arrange
        final task = Task(
          id: '1',
          title: 'Task 1',
          description: 'Description',
          isCompleted: false,
          createdAt: DateTime.now(),
        );
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success([task]));
        
        await viewModel.loadTasks();

        // Act
        final foundTask = viewModel.getTaskById('1');
        final notFoundTask = viewModel.getTaskById('2');

        // Assert
        expect(foundTask, task);
        expect(notFoundTask, null);
      });

      test('getTasksByStatus should filter tasks correctly', () async {
        // Arrange
        final tasks = [
          Task(
            id: '1',
            title: 'Task 1',
            description: 'Description',
            isCompleted: false,
            createdAt: DateTime.now(),
          ),
          Task(
            id: '2',
            title: 'Task 2',
            description: 'Description',
            isCompleted: true,
            createdAt: DateTime.now(),
          ),
        ];
        
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success(tasks));
        
        await viewModel.loadTasks();

        // Act
        final completedTasks = viewModel.getTasksByStatus(true);
        final incompleteTasks = viewModel.getTasksByStatus(false);

        // Assert
        expect(completedTasks.length, 1);
        expect(completedTasks.first.isCompleted, true);
        expect(incompleteTasks.length, 1);
        expect(incompleteTasks.first.isCompleted, false);
      });
    });

    group('command state management', () {
      test('should prevent multiple concurrent executions', () async {
        // Arrange
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async {
            await Future.delayed(const Duration(milliseconds: 100));
            return Result.success(<Task>[]);
          });

        // Act
        final future1 = viewModel.loadTasks();
        final future2 = viewModel.loadTasks(); // Should not execute

        await Future.wait([future1, future2]);

        // Assert
        verify(() => mockRepository.getTasks()).called(1); // Only called once
      });

      test('should clear command results when clearResult is called', () async {
        // Arrange
        when(() => mockRepository.getTasks())
          .thenAnswer((_) async => Result.success(<Task>[]));

        await viewModel.loadTasks();
        
        expect(viewModel.loadTasksCommand.result, isNotNull);

        // Act
        viewModel.loadTasksCommand.clearResult();

        // Assert
        expect(viewModel.loadTasksCommand.result, isNull);
        expect(viewModel.loadTasksCommand.completed, false);
        expect(viewModel.loadTasksCommand.error, false);
      });
    });

    group('error handling across commands', () {
      test('should maintain separate error states for different commands', () async {
        // Arrange
        final createData = CreateTaskData(
          title: 'New Task',
          description: 'Description',
        );
        
        when(() => mockRepository.createTask(createData))
          .thenAnswer((_) async => Result.failure('Create failed'));
        
        when(() => mockRepository.deleteTask('1'))
          .thenAnswer((_) async => Result.failure('Delete failed'));

        // Act
        await viewModel.createTask(createData);
        final firstError = viewModel.error;
        
        await viewModel.deleteTask('1');
        final secondError = viewModel.error;

        // Assert
        expect(firstError, 'Create failed');
        expect(secondError, 'Delete failed');
        expect(viewModel.createTaskCommand.error, true);
        expect(viewModel.deleteTaskCommand.error, true);
      });
    });
  });
}
