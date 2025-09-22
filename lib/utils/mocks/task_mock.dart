import '../../domain/models/task_model.dart';

/// Classe utilitária para criar dados fictícios de TaskModel
class TaskMock {
  /// Retorna uma lista de dados fictícios de TaskModel
  static List<TaskModel> getMockTasks() {
    final now = DateTime.now();

    return [
      TaskModel(
        id: '1',
        title: 'Comprar ingredientes para o jantar',
        description:
            'Ir ao supermercado e comprar vegetais, carne e temperos para preparar o jantar da família',
        isCompleted: false,
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      TaskModel(
        id: '2',
        title: 'Estudar Flutter e Dart',
        description:
            'Revisar conceitos de widgets, estado e testes unitários para o projeto atual',
        isCompleted: true,
        createdAt: now.subtract(const Duration(days: 1)),
        completedAt: now.subtract(const Duration(hours: 3)),
      ),
      TaskModel(
        id: '3',
        title: 'Agendar consulta médica',
        description: 'Ligar para a clínica e marcar o exame de rotina anual',
        isCompleted: false,
        createdAt: now.subtract(const Duration(hours: 5)),
      ),
      TaskModel(
        id: '4',
        title: 'Implementar testes unitários',
        description:
            'Criar testes para as classes TaskModel, TaskRepository e TaskViewModel',
        isCompleted: true,
        createdAt: now.subtract(const Duration(days: 2)),
        completedAt: now.subtract(const Duration(days: 1, hours: 2)),
      ),
      TaskModel(
        id: '5',
        title: 'Organizar documentos pessoais',
        description:
            'Digitalizar e organizar documentos importantes em pastas no computador',
        isCompleted: false,
        createdAt: now.subtract(const Duration(days: 3)),
      ),
      TaskModel(
        id: '6',
        title: 'Fazer backup dos dados',
        description:
            'Realizar backup completo dos projetos e arquivos importantes para o cloud',
        isCompleted: true,
        createdAt: now.subtract(const Duration(days: 4)),
        completedAt: now.subtract(const Duration(days: 3, hours: 1)),
      ),
      TaskModel(
        id: '7',
        title: 'Planejar viagem de férias',
        description:
            'Pesquisar destinos, hotéis e atividades para as próximas férias em família',
        isCompleted: false,
        createdAt: now.subtract(const Duration(hours: 8)),
      ),
      TaskModel(
        id: '8',
        title: 'Configurar ambiente de desenvolvimento',
        description:
            'Instalar e configurar todas as ferramentas necessárias para o novo projeto',
        isCompleted: true,
        createdAt: now.subtract(const Duration(days: 5)),
        completedAt: now.subtract(const Duration(days: 4, hours: 6)),
      ),
    ];
  }
}
