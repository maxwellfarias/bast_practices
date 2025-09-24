import 'package:flutter/material.dart';
import 'package:mastering_tests/domain/models/curso_model.dart';
import 'package:mastering_tests/ui/core/extensions/build_context_extension.dart';

class CursoViewDialog extends StatelessWidget {
  final Cursos curso;
  final VoidCallback? onEdit;

  const CursoViewDialog({
    super.key,
    required this.curso,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.customColorTheme.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.customColorTheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.school,
                    color: context.customColorTheme.primaryForeground,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detalhes do Curso',
                          style: context.customTextTheme.textLgSemibold.copyWith(
                            color: context.customColorTheme.primaryForeground,
                          ),
                        ),
                        Text(
                          curso.nomeCurso,
                          style: context.customTextTheme.textSm.copyWith(
                            color: context.customColorTheme.primaryForeground.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: context.customColorTheme.primaryForeground,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Basic Information Section
                    _buildSectionHeader(context, 'Informações Básicas', Icons.info_outline),
                    const SizedBox(height: 12),
                    
                    _buildInfoGrid(context, [
                      _InfoItem('Nome do Curso', curso.nomeCurso),
                      if (curso.codigoCursoEMEC != null) 
                        _InfoItem('Código e-MEC', curso.codigoCursoEMEC.toString()),
                      _InfoItem('Modalidade', curso.modalidade),
                      _InfoItem('Grau Conferido', curso.grauConferido),
                    ]),
                    
                    const SizedBox(height: 16),
                    
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: context.customColorTheme.muted,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.customColorTheme.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Título Conferido',
                            style: context.customTextTheme.textSmSemibold.copyWith(
                              color: context.customColorTheme.mutedForeground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            curso.tituloConferido,
                            style: context.customTextTheme.textBase.copyWith(
                              color: context.customColorTheme.foreground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Address Section
                    _buildSectionHeader(context, 'Endereço', Icons.location_on_outlined),
                    const SizedBox(height: 12),
                    
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.customColorTheme.muted,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.customColorTheme.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${curso.logradouro}, ${curso.bairro}',
                            style: context.customTextTheme.textBaseMedium.copyWith(
                              color: context.customColorTheme.foreground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${curso.nomeMunicipio} - ${curso.uf}',
                            style: context.customTextTheme.textBase.copyWith(
                              color: context.customColorTheme.foreground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'CEP: ${curso.cep}',
                            style: context.customTextTheme.textSm.copyWith(
                              color: context.customColorTheme.mutedForeground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Código do Município: ${curso.codigoMunicipio}',
                            style: context.customTextTheme.textSm.copyWith(
                              color: context.customColorTheme.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Authorization and Recognition Section
                    _buildSectionHeader(context, 'Documentação Legal', Icons.gavel_outlined),
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: context.customColorTheme.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: context.customColorTheme.success.withOpacity(0.3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: context.customColorTheme.success,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Autorização',
                                      style: context.customTextTheme.textSmSemibold.copyWith(
                                        color: context.customColorTheme.success,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${curso.autorizacaoTipo} ${curso.autorizacaoNumero}',
                                  style: context.customTextTheme.textBase.copyWith(
                                    color: context.customColorTheme.foreground,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatDate(curso.autorizacaoData),
                                  style: context.customTextTheme.textSm.copyWith(
                                    color: context.customColorTheme.mutedForeground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: context.customColorTheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: context.customColorTheme.primary.withOpacity(0.3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.verified_outlined,
                                      color: context.customColorTheme.primary,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Reconhecimento',
                                      style: context.customTextTheme.textSmSemibold.copyWith(
                                        color: context.customColorTheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${curso.reconhecimentoTipo} ${curso.reconhecimentoNumero}',
                                  style: context.customTextTheme.textBase.copyWith(
                                    color: context.customColorTheme.foreground,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatDate(curso.reconhecimentoData),
                                  style: context.customTextTheme.textSm.copyWith(
                                    color: context.customColorTheme.mutedForeground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Additional info if available
                    if (curso.numeroProcesso != null || curso.tipoProcesso != null) ...[
                      const SizedBox(height: 24),
                      _buildSectionHeader(context, 'Informações do Processo', Icons.description_outlined),
                      const SizedBox(height: 12),
                      
                      _buildInfoGrid(context, [
                        if (curso.tipoProcesso != null) 
                          _InfoItem('Tipo de Processo', curso.tipoProcesso!),
                        if (curso.numeroProcesso != null) 
                          _InfoItem('Número do Processo', curso.numeroProcesso!),
                        if (curso.dataCadastro != null) 
                          _InfoItem('Data de Cadastro', _formatDate(curso.dataCadastro!)),
                        if (curso.dataProtocolo != null) 
                          _InfoItem('Data do Protocolo', _formatDate(curso.dataProtocolo!)),
                      ]),
                    ],
                  ],
                ),
              ),
            ),
            
            // Footer with actions
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.customColorTheme.card,
                border: Border(
                  top: BorderSide(
                    color: context.customColorTheme.border,
                    width: 1,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: context.customColorTheme.mutedForeground,
                      side: BorderSide(color: context.customColorTheme.border),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text('Fechar'),
                  ),
                  if (onEdit != null) ...[
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onEdit!();
                      },
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('Editar Curso'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.customColorTheme.primary,
                        foregroundColor: context.customColorTheme.primaryForeground,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: context.customColorTheme.primary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: context.customTextTheme.textBaseMedium.copyWith(
            color: context.customColorTheme.cardForeground,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoGrid(BuildContext context, List<_InfoItem> items) {
    return Column(
      children: [
        for (int i = 0; i < items.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: _buildInfoItem(context, items[i]),
                ),
                if (i + 1 < items.length) ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoItem(context, items[i + 1]),
                  ),
                ] else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildInfoItem(BuildContext context, _InfoItem item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.customColorTheme.muted,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.customColorTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label,
            style: context.customTextTheme.textXs.copyWith(
              color: context.customColorTheme.mutedForeground,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.value,
            style: context.customTextTheme.textSm.copyWith(
              color: context.customColorTheme.foreground,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

class _InfoItem {
  final String label;
  final String value;

  _InfoItem(this.label, this.value);
}