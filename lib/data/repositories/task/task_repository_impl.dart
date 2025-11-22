import 'dart:async';
import 'package:mastering_tests/data/services/api/api_serivce.dart';
import 'package:mastering_tests/domain/models/task_model.dart';
import 'package:mastering_tests/exceptions/app_exception.dart';
import 'package:mastering_tests/templates/flutter_templates/simple_mock_template.dart';
import 'package:mastering_tests/utils/logger/custom_logger.dart';
import '../../../utils/result.dart';
import 'task_repository.dart';


  class TaskRepositoryImpl implements TaskRepository {
    final ApiClient _apiService;
    final String _baseUrl;
    final CustomLogger _logger;

    TaskRepositoryImpl({required ApiClient apiService, required String baseUrl, required CustomLogger logger})
      : _apiService = apiService,
        _baseUrl = baseUrl,
        _logger = logger;
      
        @override
        Future<Result<TaskModel>> createTask({required TaskModel task}) async {
          return TaskMock.addTask(task);
          try {
            final response = await _apiService.request(url: '$_baseUrl/tasks', metodo: .post, body: task.toJson())
            .map(TaskModel.fromJson);
            return response;
          } catch (e, stackTrace) {
            _logger.error('Error in createTask: $e', stackTrace: stackTrace);
            return Result.error(UnknownErrorException());
          }
        }
      
        @override
        Future<Result<dynamic>> deleteTask({required String taskId}) async {
          return TaskMock.deleteTask(taskId);
          try {
            final response = await _apiService.request(url: '$_baseUrl/tasks/$taskId', metodo: .delete);
            return response;
          } catch (e, stackTrace) {
            _logger.error('Error in deleteTask: $e', stackTrace: stackTrace);
            return Result.error(UnknownErrorException());
          }
        }
      
        @override
        Future<Result<List<TaskModel>>> getAllTasks() async {
          return TaskMock.getMockTasks();
          try {
            final response = await _apiService.request(url: '$_baseUrl/tasks', metodo: .get)
            .map((data) {
              final List<dynamic> dataList = data as List<dynamic>;
              return dataList.map((item) => TaskModel.fromJson(item)).toList();
            });
            return response;
          } catch (e, stackTrace) {
            _logger.error('Error in getAllTasks: $e', stackTrace: stackTrace);
            return Result.error(UnknownErrorException());
          }
        }
      
        @override
        Future<Result<TaskModel>> getTaskBy({required String taskId}) async {
          return TaskMock.getTaskById(taskId);
          try {
            final response = await _apiService.request(url: '$_baseUrl/tasks/$taskId', metodo: .get)
            .map(TaskModel.fromJson);
            return response;
          } catch (e, stackTrace) {
            _logger.error('Error in getTaskBy: $e', stackTrace: stackTrace);
            return Result.error(UnknownErrorException());
          }
        }
      
        @override
        Future<Result<TaskModel>> updateTask({required TaskModel task}) async {
          return TaskMock.updateTask(task);
          try {
            final response = await _apiService.request(url: '$_baseUrl/tasks/${task.id}', metodo: .put, body: task.toJson())
            .map(TaskModel.fromJson);
            return response;
          } catch (e, stackTrace) {
            _logger.error('Error in updateTask: $e', stackTrace: stackTrace);
            return Result.error(UnknownErrorException());
          }
        }

  }
