import 'package:flutter/material.dart';
import 'package:mastering_tests/ui/core/extensions/build_context_extension.dart';

/// Widget para o estado vazio (quando não há tarefas)
class TaskEmptyState extends StatelessWidget {
  const TaskEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ícone de checklist
          Icon(
            Icons.checklist_rounded,
            size: 80,
            color: context.customColorTheme.mutedForeground,
          ),

          const SizedBox(height: 16),

          // Mensagem
          Text(
            'Nenhuma tarefa encontrada',
            style: context.customTextTheme.textLgMedium.copyWith(
              color: context.customColorTheme.mutedForeground,
            ),
          ),

          const SizedBox(height: 8),

          // Submensagem
          Text(
            'Toque no botão + para criar uma nova tarefa',
            style: context.customTextTheme.textSm.copyWith(
              color: context.customColorTheme.mutedForeground,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
