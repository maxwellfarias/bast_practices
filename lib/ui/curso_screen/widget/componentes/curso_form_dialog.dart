import 'package:flutter/material.dart';
import 'package:mastering_tests/domain/models/curso_model.dart';
import 'package:mastering_tests/ui/curso_screen/viewmodel/curso_viewmodel.dart';
import 'package:mastering_tests/ui/core/extensions/build_context_extension.dart';

class CursoFormDialog extends StatefulWidget {
  final CursoViewModel viewModel;
  final Cursos? curso;
  final Function(Cursos) onSubmit;

  const CursoFormDialog({
    super.key,
    required this.viewModel,
    required this.onSubmit,
    this.curso,
  });

  @override
  State<CursoFormDialog> createState() => _CursoFormDialogState();
}

class _CursoFormDialogState extends State<CursoFormDialog> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers para todos os campos
  late TextEditingController _nomeCursoController;
  late TextEditingController _codigoCursoEMECController;
  late TextEditingController _numeroProcessoController;
  late TextEditingController _tituloConferidoController;
  late TextEditingController _logradouroController;
  late TextEditingController _bairroController;
  late TextEditingController _codigoMunicipioController;
  late TextEditingController _nomeMunicipioController;
  late TextEditingController _ufController;
  late TextEditingController _cepController;
  late TextEditingController _autorizacaoNumeroController;
  late TextEditingController _reconhecimentoNumeroController;

  // Estados para dropdowns e datas
  String? _modalidadeSelecionada;
  String? _grauConferidoSelecionado;
  String? _tipoProcessoSelecionado;
  String? _autorizacaoTipoSelecionado;
  String? _reconhecimentoTipoSelecionado;
  DateTime? _dataCadastro;
  DateTime? _dataProtocolo;
  DateTime? _autorizacaoData;
  DateTime? _reconhecimentoData;

  // Opções dos dropdowns
  final List<String> _modalidades = ['Presencial', 'EaD', 'Híbrido'];
  final List<String> _grausConferidos = ['Bacharel', 'Licenciado', 'Tecnólogo'];
  final List<String> _tiposAutorizacao = ['Portaria MEC', 'Decreto', 'Resolução'];

  bool get _isEditing => widget.curso != null;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _populateFieldsIfEditing();
  }

  void _initializeControllers() {
    _nomeCursoController = TextEditingController();
    _codigoCursoEMECController = TextEditingController();
    _numeroProcessoController = TextEditingController();
    _tituloConferidoController = TextEditingController();
    _logradouroController = TextEditingController();
    _bairroController = TextEditingController();
    _codigoMunicipioController = TextEditingController();
    _nomeMunicipioController = TextEditingController();
    _ufController = TextEditingController();
    _cepController = TextEditingController();
    _autorizacaoNumeroController = TextEditingController();
    _reconhecimentoNumeroController = TextEditingController();
  }

  void _populateFieldsIfEditing() {
    if (_isEditing) {
      final curso = widget.curso!;
      _nomeCursoController.text = curso.nomeCurso;
      _codigoCursoEMECController.text = curso.codigoCursoEMEC?.toString() ?? '';
      _numeroProcessoController.text = curso.numeroProcesso ?? '';
      _tituloConferidoController.text = curso.tituloConferido;
      _logradouroController.text = curso.logradouro;
      _bairroController.text = curso.bairro;
      _codigoMunicipioController.text = curso.codigoMunicipio.toString();
      _nomeMunicipioController.text = curso.nomeMunicipio;
      _ufController.text = curso.uf;
      _cepController.text = curso.cep;
      _autorizacaoNumeroController.text = curso.autorizacaoNumero;
      _reconhecimentoNumeroController.text = curso.reconhecimentoNumero;

      _modalidadeSelecionada = curso.modalidade;
      _grauConferidoSelecionado = curso.grauConferido;
      _tipoProcessoSelecionado = curso.tipoProcesso;
      _autorizacaoTipoSelecionado = curso.autorizacaoTipo;
      _reconhecimentoTipoSelecionado = curso.reconhecimentoTipo;
      _dataCadastro = curso.dataCadastro;
      _dataProtocolo = curso.dataProtocolo;
      _autorizacaoData = curso.autorizacaoData;
      _reconhecimentoData = curso.reconhecimentoData;
    } else {
      // Valores padrão para criação
      _autorizacaoData = DateTime.now();
      _reconhecimentoData = DateTime.now();
    }
  }

  @override
  void dispose() {
    _nomeCursoController.dispose();
    _codigoCursoEMECController.dispose();
    _numeroProcessoController.dispose();
    _tituloConferidoController.dispose();
    _logradouroController.dispose();
    _bairroController.dispose();
    _codigoMunicipioController.dispose();
    _nomeMunicipioController.dispose();
    _ufController.dispose();
    _cepController.dispose();
    _autorizacaoNumeroController.dispose();
    _reconhecimentoNumeroController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_modalidadeSelecionada == null || _grauConferidoSelecionado == null ||
          _autorizacaoTipoSelecionado == null || _reconhecimentoTipoSelecionado == null ||
          _autorizacaoData == null || _reconhecimentoData == null) {
        _showErrorMessage('Por favor, preencha todos os campos obrigatórios');
        return;
      }

      final curso = Cursos(
        cursoID: _isEditing ? widget.curso!.cursoID : DateTime.now().millisecondsSinceEpoch,
        nomeCurso: _nomeCursoController.text.trim(),
        codigoCursoEMEC: _codigoCursoEMECController.text.isEmpty ? null : int.tryParse(_codigoCursoEMECController.text),
        numeroProcesso: _numeroProcessoController.text.isEmpty ? null : _numeroProcessoController.text.trim(),
        tipoProcesso: _tipoProcessoSelecionado,
        dataCadastro: _dataCadastro,
        dataProtocolo: _dataProtocolo,
        modalidade: _modalidadeSelecionada!,
        tituloConferido: _tituloConferidoController.text.trim(),
        grauConferido: _grauConferidoSelecionado!,
        logradouro: _logradouroController.text.trim(),
        bairro: _bairroController.text.trim(),
        codigoMunicipio: int.parse(_codigoMunicipioController.text),
        nomeMunicipio: _nomeMunicipioController.text.trim(),
        uf: _ufController.text.trim().toUpperCase(),
        cep: _cepController.text.trim(),
        autorizacaoTipo: _autorizacaoTipoSelecionado!,
        autorizacaoNumero: _autorizacaoNumeroController.text.trim(),
        autorizacaoData: _autorizacaoData!,
        reconhecimentoTipo: _reconhecimentoTipoSelecionado!,
        reconhecimentoNumero: _reconhecimentoNumeroController.text.trim(),
        reconhecimentoData: _reconhecimentoData!,
      );

      widget.onSubmit(curso);
      Navigator.of(context).pop();
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.customColorTheme.destructive,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.customColorTheme.primary,
              onPrimary: context.customColorTheme.primaryForeground,
              surface: context.customColorTheme.card,
              onSurface: context.customColorTheme.cardForeground,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Selecionar data';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.customColorTheme.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 600),
        child: Column(
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
                    _isEditing ? Icons.edit : Icons.add,
                    size: 24,
                    color: context.customColorTheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _isEditing ? 'Editar Curso' : 'Criar Novo Curso',
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

            // Form Content
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Informações Básicas
                      _buildSectionHeader(context, 'Informações Básicas'),
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildTextFormField(
                              context,
                              controller: _nomeCursoController,
                              label: 'Nome do Curso *',
                              hint: 'Ex: Engenharia de Software',
                              validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextFormField(
                              context,
                              controller: _codigoCursoEMECController,
                              label: 'Código e-MEC',
                              hint: 'Ex: 123456',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdownFormField(
                              context,
                              value: _modalidadeSelecionada,
                              items: _modalidades,
                              label: 'Modalidade *',
                              hint: 'Selecionar modalidade',
                              onChanged: (value) => setState(() => _modalidadeSelecionada = value),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildDropdownFormField(
                              context,
                              value: _grauConferidoSelecionado,
                              items: _grausConferidos,
                              label: 'Grau Conferido *',
                              hint: 'Selecionar grau',
                              onChanged: (value) => setState(() => _grauConferidoSelecionado = value),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      _buildTextFormField(
                        context,
                        controller: _tituloConferidoController,
                        label: 'Título Conferido *',
                        hint: 'Ex: Bacharel em Engenharia de Software',
                        validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
                      ),

                      const SizedBox(height: 20),

                      // Endereço
                      _buildSectionHeader(context, 'Endereço'),
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildTextFormField(
                              context,
                              controller: _logradouroController,
                              label: 'Logradouro *',
                              hint: 'Ex: Rua das Palmeiras, 123',
                              validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextFormField(
                              context,
                              controller: _bairroController,
                              label: 'Bairro *',
                              hint: 'Ex: Centro',
                              validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildTextFormField(
                              context,
                              controller: _nomeMunicipioController,
                              label: 'Município *',
                              hint: 'Ex: São Paulo',
                              validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextFormField(
                              context,
                              controller: _ufController,
                              label: 'UF *',
                              hint: 'Ex: SP',
                              validator: (value) {
                                if (value?.isEmpty ?? true) return 'Campo obrigatório';
                                if (value!.length != 2) return 'UF deve ter 2 caracteres';
                                return null;
                              },
                              textCapitalization: TextCapitalization.characters,
                              maxLength: 2,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextFormField(
                              context,
                              controller: _cepController,
                              label: 'CEP *',
                              hint: 'Ex: 01234-567',
                              validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      _buildTextFormField(
                        context,
                        controller: _codigoMunicipioController,
                        label: 'Código do Município *',
                        hint: 'Ex: 3550308',
                        keyboardType: TextInputType.number,
                        validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
                      ),

                      const SizedBox(height: 20),

                      // Autorização
                      _buildSectionHeader(context, 'Autorização'),
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdownFormField(
                              context,
                              value: _autorizacaoTipoSelecionado,
                              items: _tiposAutorizacao,
                              label: 'Tipo *',
                              hint: 'Selecionar tipo',
                              onChanged: (value) => setState(() => _autorizacaoTipoSelecionado = value),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextFormField(
                              context,
                              controller: _autorizacaoNumeroController,
                              label: 'Número *',
                              hint: 'Ex: 123/2020',
                              validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      _buildDateField(
                        context,
                        label: 'Data da Autorização *',
                        selectedDate: _autorizacaoData,
                        onDateSelected: (date) => setState(() => _autorizacaoData = date),
                      ),

                      const SizedBox(height: 20),

                      // Reconhecimento
                      _buildSectionHeader(context, 'Reconhecimento'),
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdownFormField(
                              context,
                              value: _reconhecimentoTipoSelecionado,
                              items: _tiposAutorizacao,
                              label: 'Tipo *',
                              hint: 'Selecionar tipo',
                              onChanged: (value) => setState(() => _reconhecimentoTipoSelecionado = value),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextFormField(
                              context,
                              controller: _reconhecimentoNumeroController,
                              label: 'Número *',
                              hint: 'Ex: 456/2023',
                              validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      _buildDateField(
                        context,
                        label: 'Data do Reconhecimento *',
                        selectedDate: _reconhecimentoData,
                        onDateSelected: (date) => setState(() => _reconhecimentoData = date),
                      ),
                    ],
                  ),
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
                      'Cancelar',
                      style: context.customTextTheme.textSmMedium.copyWith(
                        color: context.customColorTheme.mutedForeground,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.customColorTheme.primary,
                      foregroundColor: context.customColorTheme.primaryForeground,
                    ),
                    child: Text(
                      _isEditing ? 'Salvar Alterações' : 'Criar Curso',
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

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: context.customTextTheme.textLgSemibold.copyWith(
        color: context.customColorTheme.cardForeground,
      ),
    );
  }

  Widget _buildTextFormField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.customTextTheme.textSmMedium.copyWith(
            color: context.customColorTheme.cardForeground,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: context.customTextTheme.textSm.copyWith(
              color: context.customColorTheme.mutedForeground,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.customColorTheme.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.customColorTheme.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.customColorTheme.ring, width: 2),
            ),
            filled: true,
            fillColor: context.customColorTheme.input,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            counterText: '',
          ),
          style: context.customTextTheme.textSm.copyWith(
            color: context.customColorTheme.foreground,
          ),
          validator: validator,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          maxLength: maxLength,
        ),
      ],
    );
  }

  Widget _buildDropdownFormField(
    BuildContext context, {
    required String? value,
    required List<String> items,
    required String label,
    required String hint,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.customTextTheme.textSmMedium.copyWith(
            color: context.customColorTheme.cardForeground,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: context.customColorTheme.input,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.customColorTheme.border),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            hint: Text(
              hint,
              style: context.customTextTheme.textSm.copyWith(
                color: context.customColorTheme.mutedForeground,
              ),
            ),
            style: context.customTextTheme.textSm.copyWith(
              color: context.customColorTheme.foreground,
            ),
            dropdownColor: context.customColorTheme.card,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: context.customTextTheme.textSm.copyWith(
                    color: context.customColorTheme.cardForeground,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(
    BuildContext context, {
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.customTextTheme.textSmMedium.copyWith(
            color: context.customColorTheme.cardForeground,
          ),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: () => _selectDate(context, onDateSelected),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: context.customColorTheme.input,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.customColorTheme.border),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: context.customColorTheme.mutedForeground,
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDate(selectedDate),
                  style: context.customTextTheme.textSm.copyWith(
                    color: selectedDate != null 
                        ? context.customColorTheme.foreground
                        : context.customColorTheme.mutedForeground,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_drop_down,
                  color: context.customColorTheme.mutedForeground,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}