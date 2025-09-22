import 'package:flutter/material.dart';
import 'package:mastering_tests/domain/models/task_model.dart';
import 'package:mastering_tests/ui/tasks/view_model/task_view_model.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({required this.viewModel, super.key});
  final TaskViewModel viewModel;

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.viewModel.getTasks.execute();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Seção para buscar tarefa por ID
            _buildSearchSection(),

            const SizedBox(height: 16),

            Expanded(child: _buildTasksList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(),
        child: Icon(Icons.add),
        tooltip: 'Atualizar lista',
      ),
    );
  }

  Widget _buildSearchSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Buscar Tarefa por ID',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Digite o ID da tarefa',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _searchTaskById,
                  child: const Text('Buscar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTasksList() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Lista de Tarefas',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: AnimatedBuilder(
                animation: widget.viewModel.getTasks,
                builder: (context, child) {
                  if (widget.viewModel.getTasks.running) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (widget.viewModel.getTasks.error) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 48),
                          const SizedBox(height: 8),
                          Text(
                            'Erro: ${widget.viewModel.getTasks.errorMessage ?? "Erro desconhecido"}',
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () =>
                                widget.viewModel.getTasks.execute(),
                            child: const Text('Tentar Novamente'),
                          ),
                        ],
                      ),
                    );
                  }

                  final tasks = widget.viewModel.getTasks.value ?? [];

                  if (tasks.isEmpty) {
                    return const Center(
                      child: Text('Nenhuma tarefa encontrada'),
                    );
                  }

                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return _buildTaskCard(task);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(TaskModel task) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
                Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) => _toggleTaskCompletion(task),
                ),
              ],
            ),
            if (task.description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                task.description,
                style: TextStyle(
                  color: Colors.grey[600],
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ],
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID: ${task.id}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () => _editTask(task),
                      tooltip: 'Editar',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: () => _deleteTask(task.id),
                      tooltip: 'Excluir',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _searchTaskById() async {
    final id = _searchController.text.trim();
    if (id.isEmpty) {
      _showMessage('Por favor, digite um ID válido');
      return;
    }

    await widget.viewModel.getTaskById.execute(id);

    if (widget.viewModel.getTaskById.completed) {
      final task = widget.viewModel.getTaskById.value!;
      _showTaskDialog(task);
    } else if (widget.viewModel.getTaskById.error) {
      _showMessage(
        'Erro ao buscar tarefa: ${widget.viewModel.getTaskById.errorMessage}',
      );
    }
  }

  void _toggleTaskCompletion(TaskModel task) async {
    final updatedTask = task.copyWith(
      isCompleted: !task.isCompleted,
      completedAt: !task.isCompleted ? DateTime.now() : null,
    );

    await widget.viewModel.updateTask.execute(updatedTask);

    if (widget.viewModel.updateTask.completed) {
      widget.viewModel.getTasks.execute();
    } else if (widget.viewModel.updateTask.error) {
      _showMessage(
        'Erro ao atualizar tarefa: ${widget.viewModel.updateTask.errorMessage}',
      );
    }
  }

  void _editTask(TaskModel task) {
    _titleController.text = task.title;
    _descriptionController.text = task.description;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Tarefa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final updatedTask = task.copyWith(
                title: _titleController.text.trim(),
                description: _descriptionController.text.trim(),
              );

              await widget.viewModel.updateTask.execute(updatedTask);

              if (widget.viewModel.updateTask.completed) {
                Navigator.pop(context);
                _titleController.clear();
                _descriptionController.clear();
                _showMessage('Tarefa atualizada com sucesso!');
                widget.viewModel.getTasks.execute();
              } else if (widget.viewModel.updateTask.error) {
                _showMessage(
                  'Erro ao atualizar tarefa: ${widget.viewModel.updateTask.errorMessage}',
                );
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _deleteTask(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: const Text('Tem certeza que deseja excluir esta tarefa?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              await widget.viewModel.deleteTask.execute(id);

              if (widget.viewModel.deleteTask.completed) {
                Navigator.pop(context);
                _showMessage('Tarefa excluída com sucesso!');
                widget.viewModel.getTasks.execute();
              } else if (widget.viewModel.deleteTask.error) {
                _showMessage(
                  'Erro ao excluir tarefa: ${widget.viewModel.deleteTask.errorMessage}',
                );
              }
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Nova Tarefa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _titleController.clear();
              _descriptionController.clear();
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = _titleController.text.trim();
              final description = _descriptionController.text.trim();

              if (title.isEmpty) {
                _showMessage('Por favor, digite um título para a tarefa');
                return;
              }

              final newTask = TaskModel(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                title: title,
                description: description,
                isCompleted: false,
                createdAt: DateTime.now(),
              );

              await widget.viewModel.addTask.execute(newTask);

              if (widget.viewModel.addTask.completed) {
                _titleController.clear();
                _descriptionController.clear();
                Navigator.pop(context);
                _showMessage('Tarefa adicionada com sucesso!');
                widget.viewModel.getTasks.execute();
              } else if (widget.viewModel.addTask.error) {
                _showMessage(
                  'Erro ao adicionar tarefa: ${widget.viewModel.addTask.errorMessage}',
                );
              }
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  void _showTaskDialog(TaskModel task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(task.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${task.id}'),
            const SizedBox(height: 8),
            Text('Descrição: ${task.description}'),
            const SizedBox(height: 8),
            Text('Status: ${task.isCompleted ? "Concluída" : "Pendente"}'),
            const SizedBox(height: 8),
            Text('Criada em: ${_formatDate(task.createdAt)}'),
            if (task.completedAt != null) ...[
              const SizedBox(height: 8),
              Text('Concluída em: ${_formatDate(task.completedAt!)}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
