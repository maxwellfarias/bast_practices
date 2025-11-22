import 'package:flutter/material.dart';
// import 'package:mastering_tests/data/repositories/task/task_repository.dart';
// import 'package:mastering_tests/data/repositories/task/task_repository_impl.dart';
// import 'package:mastering_tests/ui/todo/viewmodel/task_viewmodel.dart';
// import 'package:mastering_tests/ui/todo/widget/task_screen.dart';

/// Exemplo de como usar a TaskScreen
///
/// Esta tela implementa um CRUD completo de tarefas seguindo:
/// - Design 100% fiel ao HTML em design.html
/// - Padrões da documentação screen.md
/// - Arquitetura MVVM com Command Pattern
///
/// Features implementadas:
/// ✅ Criar tarefa (FAB +)
/// ✅ Listar tarefas (cards com design HTML)
/// ✅ Editar tarefa (tap no card)
/// ✅ Excluir tarefa (long press no card)
/// ✅ Marcar como concluída (tap no checkbox)
/// ✅ Estados: loading, error, empty, success
/// ✅ Feedback visual com SnackBars
/// ✅ Dialogs de confirmação
/// ✅ Tipografia e cores do tema customizado
///
/// Componentes criados:
/// - TaskScreen: Tela principal
/// - TaskCard: Card de tarefa individual
/// - TaskFormDialog: Dialog de criar/editar
/// - TaskEmptyState: Estado vazio
class TaskScreenExample extends StatelessWidget {
  const TaskScreenExample({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTA: Este é apenas um exemplo
    // Em produção, use injeção de dependência (Provider, GetIt, etc.)
    //
    // Como o TaskRepositoryImpl atualmente usa mocks (TaskMock),
    // você pode criar a instância diretamente. Quando migrar para API real,
    // substitua pelos serviços adequados.

    // Exemplo comentado - descomente e ajuste conforme sua DI:
    /*
    final TaskRepository taskRepository = TaskRepositoryImpl(
      apiService: getIt<ApiClient>(),
      baseUrl: 'https://api.example.com',
      logger: getIt<CustomLogger>(),
    );

    final taskViewModel = TaskViewModel(taskRepository: taskRepository);

    return TaskScreen(viewModel: taskViewModel);
    */

    // Por enquanto, retorne um placeholder
    return const Scaffold(
      body: Center(
        child: Text(
          'Configure a injeção de dependência para usar TaskScreen.\n'
          'Veja task_screen_example.dart para instruções.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// Como usar no seu app:
///
/// ```dart
/// // No seu MaterialApp ou onde você define rotas:
/// MaterialApp(
///   home: TaskScreenExample(),
///   // ou
///   routes: {
///     '/tasks': (context) => TaskScreenExample(),
///   },
/// )
/// ```
///
/// Com Provider/Get_it:
///
/// ```dart
/// // Usando Provider
/// ChangeNotifierProvider(
///   create: (_) => TaskViewModel(taskRepository: getIt<TaskRepository>()),
///   child: Consumer<TaskViewModel>(
///     builder: (context, viewModel, _) => TaskScreen(viewModel: viewModel),
///   ),
/// )
/// ```
