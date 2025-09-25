import 'package:flutter/material.dart';
import 'package:mastering_tests/domain/models/curso_model.dart';
import 'package:mastering_tests/ui/core/extensions/build_context_extension.dart';

class CursoCard extends StatelessWidget {
  final Cursos curso;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CursoCard({
    super.key,
    required this.curso,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  Color _getModalidadeColor(BuildContext context) {
    switch (curso.modalidade) {
      case 'Presencial':
        return context.customColorTheme.primary;
      case 'EaD':
        return context.customColorTheme.secondary;
      case 'Híbrido':
        return context.customColorTheme.accent;
      default:
        return context.customColorTheme.muted;
    }
  }

  Color _getModalidadeTextColor(BuildContext context) {
    switch (curso.modalidade) {
      case 'Presencial':
        return context.customColorTheme.primaryForeground;
      case 'EaD':
        return context.customColorTheme.secondaryForeground;
      case 'Híbrido':
        return context.customColorTheme.accentForeground;
      default:
        return context.customColorTheme.mutedForeground;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.customColorTheme.card,
      elevation: 2,
      shadowColor: context.customColorTheme.border.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: context.customColorTheme.border.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onView,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header do card
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ícone do curso
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.customColorTheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.school,
                      size: 20,
                      color: context.customColorTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Informações principais
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge do código e-MEC e modalidade
                        Row(
                          children: [
                            if (curso.codigoCursoEMEC != null) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: context.customColorTheme.muted,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: context.customColorTheme.border,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  curso.codigoCursoEMEC.toString(),
                                  style: context.customTextTheme.textXs.copyWith(
                                    color: context.customColorTheme.mutedForeground,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getModalidadeColor(context),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                curso.modalidade,
                                style: context.customTextTheme.textXs.copyWith(
                                  color: _getModalidadeTextColor(context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Nome do curso
              Text(
                curso.nomeCurso,
                style: context.customTextTheme.textLgSemibold.copyWith(
                  color: context.customColorTheme.cardForeground,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 4),
              
              // Título conferido
              Text(
                curso.tituloConferido,
                style: context.customTextTheme.textSm.copyWith(
                  color: context.customColorTheme.mutedForeground,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const Spacer(),
              
              // Informações adicionais
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.customColorTheme.muted.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    // Grau conferido
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: context.customColorTheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            curso.grauConferido,
                            style: context.customTextTheme.textXs.copyWith(
                              color: context.customColorTheme.secondaryForeground,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 6),
                    
                    // Localização
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: context.customColorTheme.mutedForeground,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${curso.nomeMunicipio}, ${curso.uf}',
                            style: context.customTextTheme.textXs.copyWith(
                              color: context.customColorTheme.mutedForeground,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Informações de autorização
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Autor.: ',
                              style: context.customTextTheme.textXs.copyWith(
                                color: context.customColorTheme.mutedForeground,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                curso.autorizacaoNumero,
                                style: context.customTextTheme.textXs.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Recon.: ',
                              style: context.customTextTheme.textXs.copyWith(
                                color: context.customColorTheme.mutedForeground,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                curso.reconhecimentoNumero,
                                style: context.customTextTheme.textXs.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Botões de ação
              Row(
                children: [
                  // Botão Ver Detalhes
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onView,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: context.customColorTheme.border),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      icon: Icon(
                        Icons.visibility,
                        size: 16,
                        color: context.customColorTheme.primary,
                      ),
                      label: Text(
                        'Ver',
                        style: context.customTextTheme.textSm.copyWith(
                          color: context.customColorTheme.primary,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 8),
                  
                  // Botão Editar
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onEdit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.customColorTheme.primary,
                        foregroundColor: context.customColorTheme.primaryForeground,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      icon: const Icon(Icons.edit, size: 16),
                      label: Text(
                        'Editar',
                        style: context.customTextTheme.textSm.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 8),
                  
                  // Botão Excluir
                  IconButton(
                    onPressed: onDelete,
                    style: IconButton.styleFrom(
                      backgroundColor: context.customColorTheme.destructive.withOpacity(0.1),
                      padding: const EdgeInsets.all(8),
                    ),
                    icon: Icon(
                      Icons.delete,
                      size: 18,
                      color: context.customColorTheme.destructive,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}