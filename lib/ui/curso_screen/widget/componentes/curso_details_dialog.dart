import 'package:flutter/material.dart';
import 'package:mastering_tests/domain/models/curso_model.dart';
import 'package:mastering_tests/ui/core/extensions/build_context_extension.dart';

class CursoDetailsDialog extends StatelessWidget {
  final Cursos curso;
  final VoidCallback onEdit;

  const CursoDetailsDialog({
    super.key,
    required this.curso,
    required this.onEdit,
  });

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.customColorTheme.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.customColorTheme.primary.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.school,
                    size: 24,
                    color: context.customColorTheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Detalhes do Curso',
                      style: context.customTextTheme.textXlSemibold.copyWith(
                        color: context.customColorTheme.cardForeground,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: context.customColorTheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Informações Básicas
                    _buildSection(
                      context,
                      'Informações Básicas',
                      [
                        _buildField(context, 'Nome do Curso', curso.nomeCurso),
                        if (curso.codigoCursoEMEC != null)
                          _buildField(context, 'Código e-MEC', curso.codigoCursoEMEC.toString()),
                        if (curso.numeroProcesso != null)
                          _buildField(context, 'Número do Processo', curso.numeroProcesso!),
                        if (curso.tipoProcesso != null)
                          _buildField(context, 'Tipo do Processo', curso.tipoProcesso!),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Dados Acadêmicos
                    _buildSection(
                      context,
                      'Dados Acadêmicos',
                      [
                        _buildField(context, 'Modalidade', curso.modalidade),
                        _buildField(context, 'Grau Conferido', curso.grauConferido),
                        _buildField(context, 'Título Conferido', curso.tituloConferido),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Endereço
                    _buildSection(
                      context,
                      'Endereço',
                      [
                        _buildField(context, 'Logradouro', curso.logradouro),
                        _buildField(context, 'Bairro', curso.bairro),
                        _buildField(context, 'Município', '${curso.nomeMunicipio} (${curso.codigoMunicipio})'),
                        _buildField(context, 'UF', curso.uf),
                        _buildField(context, 'CEP', curso.cep),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Autorização
                    _buildSection(
                      context,
                      'Autorização',
                      [
                        _buildField(context, 'Tipo', curso.autorizacaoTipo),
                        _buildField(context, 'Número', curso.autorizacaoNumero),
                        _buildField(
                          context, 
                          'Data', 
                          _formatDate(curso.autorizacaoData),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Reconhecimento
                    _buildSection(
                      context,
                      'Reconhecimento',
                      [
                        _buildField(context, 'Tipo', curso.reconhecimentoTipo),
                        _buildField(context, 'Número', curso.reconhecimentoNumero),
                        _buildField(
                          context, 
                          'Data', 
                          _formatDate(curso.reconhecimentoData),
                        ),
                      ],
                    ),
                    
                    // Datas do Sistema (se existirem)
                    if (curso.dataCadastro != null || curso.dataProtocolo != null) ...[
                      const SizedBox(height: 20),
                      _buildSection(
                        context,
                        'Datas do Sistema',
                        [
                          if (curso.dataCadastro != null)
                            _buildField(
                              context, 
                              'Data de Cadastro', 
                              _formatDate(curso.dataCadastro!),
                            ),
                          if (curso.dataProtocolo != null)
                            _buildField(
                              context, 
                              'Data de Protocolo', 
                              _formatDate(curso.dataProtocolo!),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            // Footer
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.customColorTheme.muted.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: context.customColorTheme.border),
                    ),
                    child: Text(
                      'Fechar',
                      style: context.customTextTheme.textSmMedium.copyWith(
                        color: context.customColorTheme.mutedForeground,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: onEdit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.customColorTheme.primary,
                      foregroundColor: context.customColorTheme.primaryForeground,
                    ),
                    icon: const Icon(Icons.edit, size: 16),
                    label: Text(
                      'Editar Curso',
                      style: context.customTextTheme.textSmMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.customTextTheme.textLgSemibold.copyWith(
            color: context.customColorTheme.cardForeground,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.customColorTheme.muted.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.customColorTheme.border.withOpacity(0.5),
            ),
          ),
          child: Column(
            children: fields,
          ),
        ),
      ],
    );
  }

  Widget _buildField(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: context.customTextTheme.textSmMedium.copyWith(
                color: context.customColorTheme.mutedForeground,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: context.customTextTheme.textSm.copyWith(
                color: context.customColorTheme.cardForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}