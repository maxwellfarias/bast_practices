import 'package:flutter/material.dart';
import 'package:mastering_tests/domain/models/task_model.dart';
import 'package:mastering_tests/ui/core/extensions/build_context_extension.dart';

/// Card de tarefa seguindo o design HTML com fidelidade de 100%
///
/// Estrutura:
/// - Esquerda: Checkbox circular com borda colorida
/// - Centro: Título da tarefa + data/hora com ícones
/// - Direita: Tag de categoria
class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;
  final VoidCallback onToggleComplete;
  final VoidCallback onDelete;
  final int index;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggleComplete,
    required this.onDelete,
    required this.index,
  });

  /// Retorna a cor da borda do checkbox baseada no índice
  /// Alterna entre azul, vermelho e cinza para variedade visual
  Color _getBorderColor(BuildContext context) {
    if (task.isCompleted) {
      return context.customColorTheme.mutedForeground;
    }

    // Alterna cores para simular prioridades diferentes
    switch (index % 3) {
      case 0:
        return context.customColorTheme.primary; // Azul
      case 1:
        return context.customColorTheme.destructive; // Vermelho
      default:
        return context.customColorTheme.border; // Cinza
    }
  }

  /// Retorna a cor do texto de data/hora
  Color _getDateTimeColor(BuildContext context) {
    if (task.isCompleted) {
      return context.customColorTheme.mutedForeground;
    }
    return context.customColorTheme.success; // Verde como no HTML
  }

  /// Formata a data de criação
  String _formatDateTime() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final taskDate = DateTime(
      task.createdAt.year,
      task.createdAt.month,
      task.createdAt.day,
    );

    if (taskDate == today) {
      // Mostra hora se for hoje
      final hour = task.createdAt.hour.toString().padLeft(2, '0');
      final minute = task.createdAt.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } else {
      // Mostra dia da semana se for outro dia
      final weekdays = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
      return weekdays[task.createdAt.weekday % 7];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onDelete,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8), // space-y-2 do HTML
        padding: const EdgeInsets.all(16), // p-4 do HTML
        decoration: BoxDecoration(
          color: context.customColorTheme.card,
          borderRadius: BorderRadius.circular(12), // rounded-lg
          border: Border.all(
            color: context.customColorTheme.border,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox circular (esquerda)
            _buildCheckbox(context),

            const SizedBox(width: 16), // space-x-4 do HTML

            // Conteúdo principal (centro)
            Expanded(
              child: _buildContent(context),
            ),

            const SizedBox(width: 8),

            // Tag de categoria (direita)
            _buildCategoryTag(context),
          ],
        ),
      ),
    );
  }

  /// Checkbox circular com borda colorida
  Widget _buildCheckbox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4), // pt-1 do HTML
      child: GestureDetector(
        onTap: onToggleComplete,
        child: Container(
          width: 24, // w-6 do HTML
          height: 24, // h-6 do HTML
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: _getBorderColor(context),
              width: 2,
            ),
            color: task.isCompleted
                ? _getBorderColor(context).withValues(alpha: 0.2)
                : Colors.transparent,
          ),
          child: task.isCompleted
              ? Icon(
                  Icons.check,
                  size: 16,
                  color: _getBorderColor(context),
                )
              : null,
        ),
      ),
    );
  }

  /// Conteúdo principal: título + data/hora
  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título da tarefa
        Text(
          task.title,
          style: context.customTextTheme.textBase.copyWith(
            color: context.customColorTheme.cardForeground,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),

        const SizedBox(height: 4), // mt-1 do HTML

        // Data/hora com ícones
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 16, // text-base do HTML
              color: _getDateTimeColor(context),
            ),
            const SizedBox(width: 6), // mr-1.5 do HTML
            Text(
              _formatDateTime(),
              style: context.customTextTheme.textSm.copyWith(
                color: _getDateTimeColor(context),
              ),
            ),
            const SizedBox(width: 8), // ml-2 do HTML
            Icon(
              Icons.repeat,
              size: 16,
              color: _getDateTimeColor(context),
            ),
          ],
        ),
      ],
    );
  }

  /// Tag de categoria (direita)
  Widget _buildCategoryTag(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4), // pt-1 do HTML
      child: Text(
        'Tasks #',
        style: context.customTextTheme.textSm.copyWith(
          color: context.customColorTheme.mutedForeground,
        ),
      ),
    );
  }
}
