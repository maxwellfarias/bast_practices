import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mastering_tests/domain/models/curso_model.dart';
import 'package:mastering_tests/ui/curso_screen/viewmodel/curso_viewmodel.dart';
import 'package:mastering_tests/ui/curso_screen/widget/curso_form_dialog.dart';
import 'package:mastering_tests/ui/curso_screen/widget/curso_view_dialog.dart';
import 'package:mastering_tests/ui/core/extensions/build_context_extension.dart';
import 'package:mastering_tests/utils/command.dart';

final class CursoScreen extends StatefulWidget {
  final CursoViewModel viewModel;

  const CursoScreen({super.key, required this.viewModel});

  @override
  State<CursoScreen> createState() => _CursoScreenState();
}

class _CursoScreenState extends State<CursoScreen> {
  String _searchTerm = "";

  @override
  void initState() {
    super.initState();
    // LISTENERS OBRIGATÓRIOS PARA 3 COMMANDS
    widget.viewModel.updateCursoCommand.addListener(() => _onResult(command: widget.viewModel.updateCursoCommand, successMessage: 'Curso atualizado com sucesso!'));
    widget.viewModel.deleteCursoCommand.addListener(() => _onResult(command: widget.viewModel.deleteCursoCommand, successMessage: 'Curso excluído com sucesso!'));
    widget.viewModel.createCursoCommand.addListener(() => _onResult(command: widget.viewModel.createCursoCommand, successMessage: 'Curso criado com sucesso!'));
    // EXECUTAR GET ALL OBRIGATÓRIO
    widget.viewModel.getAllCursos();
  }

  @override
  void dispose() {
    // DISPOSE DE TODOS OS LISTENERS OBRIGATÓRIO
    widget.viewModel.updateCursoCommand.removeListener(() => _onResult(command: widget.viewModel.updateCursoCommand, successMessage: 'Curso atualizado com sucesso!'));
    widget.viewModel.deleteCursoCommand.removeListener(() => _onResult(command: widget.viewModel.deleteCursoCommand, successMessage: 'Curso excluído com sucesso!'));
    widget.viewModel.createCursoCommand.removeListener(() => _onResult(command: widget.viewModel.createCursoCommand, successMessage: 'Curso criado com sucesso!'));
    
    super.dispose();
  }

  /// MÉTODO _onResult OBRIGATÓRIO PARA FEEDBACK VISUAL
  void _onResult({required Command command, required String successMessage}) {
    if(command.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: ${command.errorMessage ?? 'Ocorreu um erro desconhecido.'}'),
          backgroundColor: context.customColorTheme.destructive,
        ),
      );
    } else if (command.completed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(successMessage),
          backgroundColor: context.customColorTheme.success,
        ),
      );
    }
  }

  List<Cursos> get _filteredCursos {
    if (_searchTerm.isEmpty) return widget.viewModel.cursos;
    return widget.viewModel.cursos.where((curso) =>
      curso.nomeCurso.toLowerCase().contains(_searchTerm.toLowerCase()) ||
      curso.tituloConferido.toLowerCase().contains(_searchTerm.toLowerCase()) ||
      curso.modalidade.toLowerCase().contains(_searchTerm.toLowerCase()) ||
      curso.grauConferido.toLowerCase().contains(_searchTerm.toLowerCase())
    ).toList();
  }

  String _getModalidadeBadgeColor(String modalidade) {
    switch (modalidade) {
      case "Presencial":
        return "primary";
      case "EaD":
        return "secondary";
      case "Híbrido":
        return "accent";
      default:
        return "muted";
    }
  }

  void _openCreateDialog() {
    showDialog(
      context: context,
      builder: (context) => CursoFormDialog(
        title: 'Criar Novo Curso',
        description: 'Preencha as informações do novo curso',
        onSubmit: (curso) => widget.viewModel.createCurso(curso),
        isEdit: false,
      ),
    );
  }

  void _openEditDialog(Cursos curso) {
    showDialog(
      context: context,
      builder: (context) => CursoFormDialog(
        title: 'Editar Curso',
        description: 'Atualize as informações do curso',
        initialCurso: curso,
        onSubmit: (updatedCurso) => widget.viewModel.updateCurso(updatedCurso),
        isEdit: true,
      ),
    );
  }

  void _openViewDialog(Cursos curso) {
    showDialog(
      context: context,
      builder: (context) => CursoViewDialog(
        curso: curso,
        onEdit: () => _openEditDialog(curso),
      ),
    );
  }

  void _handleDeleteCurso(int cursoID) {
    widget.viewModel.deleteCurso(cursoID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gestão de Cursos',
          style: context.customTextTheme.textXlSemibold.copyWith(
            color: context.customColorTheme.foreground,
          ),
        ),
        backgroundColor: context.customColorTheme.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: context.customColorTheme.primary,
            ),
            onPressed: () => widget.viewModel.getAllCursos(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with search and create button
          Container(
            padding: const EdgeInsets.all(16),
            color: context.customColorTheme.card,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.customColorTheme.input,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: context.customColorTheme.border,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) => setState(() => _searchTerm = value),
                          style: context.customTextTheme.textBase.copyWith(
                            color: context.customColorTheme.foreground,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Buscar cursos...',
                            hintStyle: context.customTextTheme.textBase.copyWith(
                              color: context.customColorTheme.mutedForeground,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: context.customColorTheme.mutedForeground,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: _openCreateDialog,
                      icon: const Icon(Icons.add),
                      label: const Text('Novo Curso'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.customColorTheme.primary,
                        foregroundColor: context.customColorTheme.primaryForeground,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Content area
          Expanded(
            child: ListenableBuilder(
              listenable: Listenable.merge([
                widget.viewModel,
                widget.viewModel.getAllCursosCommand,
              ]),
              builder: (context, _) {
                /// ESTADO LOADING OBRIGATÓRIO
                if (widget.viewModel.getAllCursosCommand.running) {
                  return Container(
                    color: context.customColorTheme.background,
                    child: const Center(
                      child: CupertinoActivityIndicator(radius: 16),
                    ),
                  );
                }

                /// ESTADO ERROR OBRIGATÓRIO
                if (widget.viewModel.getAllCursosCommand.error) {
                  return Container(
                    color: context.customColorTheme.background,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48,
                              color: context.customColorTheme.destructive,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Erro ao carregar cursos',
                              style: context.customTextTheme.textLgSemibold.copyWith(
                                color: context.customColorTheme.destructive,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.viewModel.getAllCursosCommand.errorMessage ?? 'Ocorreu um erro desconhecido',
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.mutedForeground,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => widget.viewModel.getAllCursos(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.customColorTheme.primary,
                                foregroundColor: context.customColorTheme.primaryForeground,
                              ),
                              child: const Text('Tentar novamente'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                /// ESTADO EMPTY OBRIGATÓRIO
                if (_filteredCursos.isEmpty) {
                  return Container(
                    color: context.customColorTheme.background,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 64,
                            color: context.customColorTheme.mutedForeground,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.viewModel.cursos.isEmpty ? 'Nenhum curso encontrado' : 'Nenhum curso corresponde à busca',
                            style: context.customTextTheme.textLgMedium.copyWith(
                              color: context.customColorTheme.mutedForeground,
                            ),
                          ),
                          if (widget.viewModel.cursos.isEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Comece criando seu primeiro curso',
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.mutedForeground,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: _openCreateDialog,
                              icon: const Icon(Icons.add),
                              label: const Text('Criar Primeiro Curso'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.customColorTheme.primary,
                                foregroundColor: context.customColorTheme.primaryForeground,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }

                /// ESTADO SUCCESS - LISTA DE DADOS
                return Container(
                  color: context.customColorTheme.background,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredCursos.length,
                    itemBuilder: (context, index) {
                      final curso = _filteredCursos[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        color: context.customColorTheme.card,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: context.customColorTheme.border,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header with title and badges
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.school,
                                    color: context.customColorTheme.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          curso.nomeCurso,
                                          style: context.customTextTheme.textLgSemibold.copyWith(
                                            color: context.customColorTheme.cardForeground,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          curso.tituloConferido,
                                          style: context.customTextTheme.textSm.copyWith(
                                            color: context.customColorTheme.mutedForeground,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: _getModalidadeBadgeColor(curso.modalidade) == "primary" 
                                              ? context.customColorTheme.primary 
                                              : _getModalidadeBadgeColor(curso.modalidade) == "secondary" 
                                                  ? context.customColorTheme.secondary 
                                                  : context.customColorTheme.accent,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          curso.modalidade,
                                          style: context.customTextTheme.textXs.copyWith(
                                            color: _getModalidadeBadgeColor(curso.modalidade) == "primary" 
                                                ? context.customColorTheme.primaryForeground 
                                                : _getModalidadeBadgeColor(curso.modalidade) == "secondary" 
                                                    ? context.customColorTheme.secondaryForeground 
                                                    : context.customColorTheme.accentForeground,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      if (curso.codigoCursoEMEC != null) ...[
                                        const SizedBox(height: 4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: context.customColorTheme.muted,
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(
                                              color: context.customColorTheme.border,
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            'e-MEC ${curso.codigoCursoEMEC}',
                                            style: context.customTextTheme.textXs.copyWith(
                                              color: context.customColorTheme.mutedForeground,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Course details
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: context.customColorTheme.secondary,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        curso.grauConferido,
                                        style: context.customTextTheme.textXs.copyWith(
                                          color: context.customColorTheme.secondaryForeground,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: context.customColorTheme.mutedForeground,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      '${curso.nomeMunicipio}, ${curso.uf}',
                                      style: context.customTextTheme.textSm.copyWith(
                                        color: context.customColorTheme.mutedForeground,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 8),
                              
                              // Authorization and Recognition info
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Autorização: ${curso.autorizacaoNumero}',
                                          style: context.customTextTheme.textXs.copyWith(
                                            color: context.customColorTheme.mutedForeground,
                                          ),
                                        ),
                                        Text(
                                          'Reconhecimento: ${curso.reconhecimentoNumero}',
                                          style: context.customTextTheme.textXs.copyWith(
                                            color: context.customColorTheme.mutedForeground,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Action buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () => _openViewDialog(curso),
                                      icon: const Icon(Icons.visibility, size: 16),
                                      label: const Text('Ver Detalhes'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: context.customColorTheme.primary,
                                        side: BorderSide(color: context.customColorTheme.border),
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () => _openEditDialog(curso),
                                      icon: const Icon(Icons.edit, size: 16),
                                      label: const Text('Editar'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: context.customColorTheme.primary,
                                        foregroundColor: context.customColorTheme.primaryForeground,
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  OutlinedButton(
                                    onPressed: () => _showDeleteConfirmation(curso),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: context.customColorTheme.destructive,
                                      side: BorderSide(color: context.customColorTheme.destructive),
                                      padding: const EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      minimumSize: const Size(40, 32),
                                    ),
                                    child: const Icon(Icons.delete, size: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(Cursos curso) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.customColorTheme.card,
          title: Text(
            'Excluir Curso',
            style: context.customTextTheme.textLgSemibold.copyWith(
              color: context.customColorTheme.cardForeground,
            ),
          ),
          content: Text(
            'Tem certeza que deseja excluir o curso "${curso.nomeCurso}"? Esta ação não pode ser desfeita.',
            style: context.customTextTheme.textBase.copyWith(
              color: context.customColorTheme.mutedForeground,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: context.customTextTheme.textBase.copyWith(
                  color: context.customColorTheme.mutedForeground,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleDeleteCurso(curso.cursoID);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.customColorTheme.destructive,
                foregroundColor: context.customColorTheme.destructiveForeground,
              ),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}