import '../../domain/models/task.dart';
import '../../utils/result.dart';

/// Interface do repositório de tarefas
/// 
/// Define o contrato para operações CRUD de tarefas.
/// Esta interface permite inversão de dependência e facilita testes
/// através de mocking.
abstract interface class TaskRepository {
  /// Busca todas as tarefas
  Future<Result<List<Task>>> getTasks();

  /// Cria uma nova tarefa
  Future<Result<void>> createTask(Task data);

  /// Atualiza uma tarefa existente
  Future<Result<void>> updateTask(Task data);

  /// Remove uma tarefa
  Future<Result<void>> deleteTask(String id);
}
