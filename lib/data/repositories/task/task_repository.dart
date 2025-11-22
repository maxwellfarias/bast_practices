import 'package:mastering_tests/domain/models/task_model.dart';

import '../../../utils/result.dart';


abstract interface class TaskRepository {

  Future<Result<List<TaskModel>>> getAllTasks();
  Future<Result<TaskModel>> getTaskBy({required String taskId});
  Future<Result<TaskModel>> createTask({required TaskModel task});
  Future<Result<TaskModel>> updateTask({required TaskModel task});
  Future<Result<dynamic>> deleteTask({required String taskId});
}


/*

{
    public interface IAlunosRepository
    {
        Task<List<Alunos>> GetAllAsync(int numeroBanco);
        Task<Alunos?>      GetByIdAsync(int numeroBanco, int id);
        Task<Alunos>       CreateAsync(int numeroBanco, Alunos usuario);
        Task<Alunos>       UpdateAsync(int numeroBanco, Alunos usuario);
        Task<bool>         DeleteAsync(int numeroBanco, int id);
    }
}

 */