import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mastering_tests/domain/models/curso_model.dart';
import 'package:mastering_tests/ui/curso_screen/viewmodel/curso_viewmodel.dart';
import 'package:mastering_tests/ui/core/extensions/build_context_extension.dart';
import 'package:mastering_tests/utils/command.dart';
import 'componentes/curso_card.dart';
import 'componentes/curso_form_dialog.dart';
import 'componentes/curso_details_dialog.dart';

final class CursoScreen extends StatefulWidget {
  final CursoViewModel viewModel;

  const CursoScreen({super.key, required this.viewModel});

  @override
  State<CursoScreen> createState() => _CursoScreenState();
}

class _CursoScreenState extends State<CursoScreen> {
  String _searchTerm = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // LISTENERS OBRIGATÓRIOS PARA 3 COMMANDS
    widget.viewModel.updateCursoCommand.addListener(() => _onResult(
        command: widget.viewModel.updateCursoCommand, 
        successMessage: 'Curso atualizado com sucesso!'
    ));
    widget.viewModel.deleteCursoCommand.addListener(() => _onResult(
        command: widget.viewModel.deleteCursoCommand, 
        successMessage: 'Curso excluído com sucesso!'
    ));
    widget.viewModel.createCursoCommand.addListener(() => _onResult(
        command: widget.viewModel.createCursoCommand, 
        successMessage: 'Curso criado com sucesso!'
    ));
    // EXECUTAR GET ALL OBRIGATÓRIO
    widget.viewModel.getAllCursosCommand.execute();
  }

  @override
  void dispose() {
    // DISPOSE DE TODOS OS LISTENERS OBRIGATÓRIO
    widget.viewModel.updateCursoCommand.removeListener(() => _onResult(
        command: widget.viewModel.updateCursoCommand, 
        successMessage: 'Curso atualizado com sucesso!'
    ));
    widget.viewModel.deleteCursoCommand.removeListener(() => _onResult(
        command: widget.viewModel.deleteCursoCommand, 
        successMessage: 'Curso excluído com sucesso!'
    ));
    widget.viewModel.createCursoCommand.removeListener(() => _onResult(
        command: widget.viewModel.createCursoCommand, 
        successMessage: 'Curso criado com sucesso!'
    ));
    _searchController.dispose();
    super.dispose();
  }

  /// MÉTODO _onResult OBRIGATÓRIO PARA FEEDBACK VISUAL
  void _onResult({required Command command, required String successMessage}) {
    if (command.error) {
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
      curso.grauConferido.toLowerCase().contains(_searchTerm.toLowerCase()) ||
      curso.nomeMunicipio.toLowerCase().contains(_searchTerm.toLowerCase()) ||
      curso.uf.toLowerCase().contains(_searchTerm.toLowerCase())
    ).toList();
  }

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) => CursoFormDialog(
        viewModel: widget.viewModel,
        onSubmit: (curso) => widget.viewModel.createCursoCommand.execute(curso),
      ),
    );
  }

  void _showEditDialog(Cursos curso) {
    showDialog(
      context: context,
      builder: (context) => CursoFormDialog(
        viewModel: widget.viewModel,
        curso: curso,
        onSubmit: (updatedCurso) => widget.viewModel.updateCursoCommand.execute(updatedCurso),
      ),
    );
  }

  void _showDetailsDialog(Cursos curso) {
    showDialog(
      context: context,
      builder: (context) => CursoDetailsDialog(
        curso: curso,
        onEdit: () {
          Navigator.of(context).pop(); // Fecha o dialog de detalhes
          _showEditDialog(curso); // Abre o dialog de edição
        },
      ),
    );
  }

  void _deleteCurso(int cursoId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.customColorTheme.card,
        title: Text(
          'Excluir Curso',
          style: context.customTextTheme.textXlSemibold.copyWith(
            color: context.customColorTheme.cardForeground,
          ),
        ),
        content: Text(
          'Tem certeza que deseja excluir este curso? Esta ação não pode ser desfeita.',
          style: context.customTextTheme.textBase.copyWith(
            color: context.customColorTheme.mutedForeground,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancelar',
              style: context.customTextTheme.textSmMedium.copyWith(
                color: context.customColorTheme.mutedForeground,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.viewModel.deleteCursoCommand.execute(cursoId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.customColorTheme.destructive,
              foregroundColor: context.customColorTheme.destructiveForeground,
            ),
            child: Text(
              'Excluir',
              style: context.customTextTheme.textSmMedium,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColorTheme.background,
      appBar: AppBar(
        backgroundColor: context.customColorTheme.card,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Gestão de Cursos',
          style: context.customTextTheme.textXlSemibold.copyWith(
            color: context.customColorTheme.cardForeground,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: context.customColorTheme.primary,
            ),
            onPressed: () => widget.viewModel.getAllCursosCommand.execute(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header com busca e botão criar
          Container(
            color: context.customColorTheme.card,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.customColorTheme.input,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: context.customColorTheme.border),
                        ),
                        child: TextField(
                          controller: _searchController,
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
                          style: context.customTextTheme.textBase.copyWith(
                            color: context.customColorTheme.foreground,
                          ),
                          onChanged: (value) => setState(() => _searchTerm = value),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: _showCreateDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.customColorTheme.primary,
                        foregroundColor: context.customColorTheme.primaryForeground,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      icon: const Icon(Icons.add, size: 18),
                      label: Text(
                        'Novo Curso',
                        style: context.customTextTheme.textSmMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Lista de cursos
          Expanded(
            child: ListenableBuilder(
              listenable: Listenable.merge([
                widget.viewModel,
                widget.viewModel.getAllCursosCommand,
              ]),
              builder: (context, _) {
                /// ESTADO LOADING OBRIGATÓRIO
                if (widget.viewModel.getAllCursosCommand.running) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CupertinoActivityIndicator(radius: 20),
                        const SizedBox(height: 16),
                        Text(
                          'Carregando cursos...',
                          style: context.customTextTheme.textBase.copyWith(
                            color: context.customColorTheme.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                /// ESTADO ERROR OBRIGATÓRIO
                if (widget.viewModel.getAllCursosCommand.error) {
                  return Center(
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
                            onPressed: () => widget.viewModel.getAllCursosCommand.execute(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.customColorTheme.primary,
                              foregroundColor: context.customColorTheme.primaryForeground,
                            ),
                            child: Text(
                              'Tentar Novamente',
                              style: context.customTextTheme.textSmMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                /// ESTADO EMPTY OBRIGATÓRIO
                if (_filteredCursos.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _searchTerm.isNotEmpty ? Icons.search_off : Icons.school_outlined,
                          size: 48,
                          color: context.customColorTheme.mutedForeground,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchTerm.isNotEmpty 
                              ? 'Nenhum curso encontrado'
                              : 'Nenhum curso cadastrado',
                          style: context.customTextTheme.textLgMedium.copyWith(
                            color: context.customColorTheme.mutedForeground,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _searchTerm.isNotEmpty 
                              ? 'Tente ajustar os filtros de busca'
                              : 'Comece criando o primeiro curso',
                          style: context.customTextTheme.textBase.copyWith(
                            color: context.customColorTheme.mutedForeground,
                          ),
                        ),
                        if (_searchTerm.isEmpty) ...[
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _showCreateDialog,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.customColorTheme.primary,
                              foregroundColor: context.customColorTheme.primaryForeground,
                            ),
                            icon: const Icon(Icons.add, size: 18),
                            label: Text(
                              'Criar Primeiro Curso',
                              style: context.customTextTheme.textSmMedium,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }

                /// ESTADO SUCCESS - LISTA DE DADOS
                return LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 1;
                    if (constraints.maxWidth >= 1200) crossAxisCount = 3;
                    else if (constraints.maxWidth >= 800) crossAxisCount = 2;

                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _filteredCursos.length,
                      itemBuilder: (context, index) {
                        final curso = _filteredCursos[index];
                        return CursoCard(
                          curso: curso,
                          onView: () => _showDetailsDialog(curso),
                          onEdit: () => _showEditDialog(curso),
                          onDelete: () => _deleteCurso(curso.cursoID),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}