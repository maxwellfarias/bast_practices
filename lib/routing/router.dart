import 'package:go_router/go_router.dart';
import 'package:mastering_tests/routing/routes.dart';
import 'package:mastering_tests/ui/tasks/view_model/task_view_model.dart';
import 'package:mastering_tests/ui/tasks/widgets/todo_list_screen.dart';
import 'package:provider/provider.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        return TodoListScreen(viewModel: TaskViewModel(taskRepository: context.read()));
      },
    )
  ],
);
