import 'package:mastering_tests/data/repositories/task_repository.dart';
import 'package:mastering_tests/domain/models/task_model.dart';
import 'package:mastering_tests/utils/command.dart';
import 'package:mastering_tests/utils/result.dart';

final class TaskViewModel {
  TaskViewModel({required TaskRepository taskRepository})
    : _taskRepository = taskRepository {
    getTasks = Command0<List<TaskModel>>(_getTasks)..execute();
    addTask = Command1<void, TaskModel>(_addTask);
    updateTask = Command1<void, TaskModel>(_updateTask);
    deleteTask = Command1<void, String>(_deleteTask);
    getTaskById = Command1<TaskModel, String>(_getTaskById);
  }

  final TaskRepository _taskRepository;
  final List<TaskModel> tasks = [];

  late final Command0<List<TaskModel>> getTasks;
  late final Command1<void, TaskModel> addTask;
  late final Command1<void, TaskModel> updateTask;
  late final Command1<void, String> deleteTask;
  late final Command1<TaskModel, String> getTaskById;

  Future<Result<List<TaskModel>>> _getTasks() async {
    return await _taskRepository.getAllTasks(databaseId: '').map((tasks) {
      this.tasks
        ..clear()
        ..addAll(tasks);
      return this.tasks;
    });
  }

  Future<Result<TaskModel>> _addTask(TaskModel task) async {
    return await _taskRepository.createTask(databaseId: '1', task: task).map((
      task,
    ) {
      tasks.add(task);
      return task;
    });
  }

  Future<Result<TaskModel>> _updateTask(TaskModel task) async {
    return await _taskRepository.updateTask(databaseId: '1', task: task).map((
      task,
    ) {
      final index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = task;
      }
      return task;
    });
  }

  Future<Result<TaskModel>> _deleteTask(String id) async {
    return await _taskRepository.deleteTask(databaseId: '1', taskId: id).map((
      task,
    ) {
      tasks.removeWhere((t) => t.id == id);
      return task;
    });
  }

  Future<Result<TaskModel>> _getTaskById(String id) async =>
      await _taskRepository.getTaskBy(databaseId: '1', taskId: id);
}
