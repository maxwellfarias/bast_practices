import 'package:flutter/material.dart';
import 'package:mastering_tests/domain/models/curso_model.dart';
import 'package:mastering_tests/ui/core/extensions/build_context_extension.dart';

class CursoFormDialog extends StatefulWidget {
  final String title;
  final String? description;
  final Cursos? initialCurso;
  final Function(Cursos) onSubmit;
  final bool isEdit;

  const CursoFormDialog({
    super.key,
    required this.title,
    this.description,
    this.initialCurso,
    required this.onSubmit,
    this.isEdit = false,
  });

  @override
  State<CursoFormDialog> createState() => _CursoFormDialogState();
}

class _CursoFormDialogState extends State<CursoFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeCursoController;
  late TextEditingController _codigoCursoEMECController;
  late TextEditingController _tituloConferidoController;
  late TextEditingController _logradouroController;
  late TextEditingController _bairroController;
  late TextEditingController _codigoMunicipioController;
  late TextEditingController _nomeMunicipioController;
  late TextEditingController _ufController;
  late TextEditingController _cepController;
  late TextEditingController _autorizacaoNumeroController;
  late TextEditingController _reconhecimentoNumeroController;
  
  String _selectedModalidade = '';
  String _selectedGrauConferido = '';
  String _selectedAutorizacaoTipo = '';
  String _selectedReconhecimentoTipo = '';
  DateTime? _autorizacaoData;
  DateTime? _reconhecimentoData;

  final List<String> _modalidades = ["Presencial", "EaD", "Híbrido"];
  final List<String> _grausConferidos = ["Bacharel", "Licenciado", "Tecnólogo"];
  final List<String> _tiposAutorizacao = ["Portaria MEC", "Decreto", "Resolução"];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _populateFields();
  }

  void _initializeControllers() {
    _nomeCursoController = TextEditingController();
    _codigoCursoEMECController = TextEditingController();
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

  void _populateFields() {
    if (widget.initialCurso != null) {
      final curso = widget.initialCurso!;
      _nomeCursoController.text = curso.nomeCurso;
      _codigoCursoEMECController.text = curso.codigoCursoEMEC?.toString() ?? '';
      _tituloConferidoController.text = curso.tituloConferido;
      _logradouroController.text = curso.logradouro;
      _bairroController.text = curso.bairro;
      _codigoMunicipioController.text = curso.codigoMunicipio.toString();
      _nomeMunicipioController.text = curso.nomeMunicipio;
      _ufController.text = curso.uf;
      _cepController.text = curso.cep;
      _autorizacaoNumeroController.text = curso.autorizacaoNumero;
      _reconhecimentoNumeroController.text = curso.reconhecimentoNumero;
      _selectedModalidade = curso.modalidade;
      _selectedGrauConferido = curso.grauConferido;
      _selectedAutorizacaoTipo = curso.autorizacaoTipo;
      _selectedReconhecimentoTipo = curso.reconhecimentoTipo;
      _autorizacaoData = curso.autorizacaoData;
      _reconhecimentoData = curso.reconhecimentoData;
    }
  }

  @override
  void dispose() {
    _nomeCursoController.dispose();
    _codigoCursoEMECController.dispose();
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

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final curso = widget.isEdit && widget.initialCurso != null
          ? widget.initialCurso!.copyWith(
              nomeCurso: _nomeCursoController.text,
              codigoCursoEMEC: _codigoCursoEMECController.text.isNotEmpty ? int.tryParse(_codigoCursoEMECController.text) : null,
              modalidade: _selectedModalidade,
              tituloConferido: _tituloConferidoController.text,
              grauConferido: _selectedGrauConferido,
              logradouro: _logradouroController.text,
              bairro: _bairroController.text,
              codigoMunicipio: int.parse(_codigoMunicipioController.text),
              nomeMunicipio: _nomeMunicipioController.text,
              uf: _ufController.text,
              cep: _cepController.text,
              autorizacaoTipo: _selectedAutorizacaoTipo,
              autorizacaoNumero: _autorizacaoNumeroController.text,
              autorizacaoData: _autorizacaoData!,
              reconhecimentoTipo: _selectedReconhecimentoTipo,
              reconhecimentoNumero: _reconhecimentoNumeroController.text,
              reconhecimentoData: _reconhecimentoData!,
            )
          : Cursos(
              cursoID: DateTime.now().millisecondsSinceEpoch,
              nomeCurso: _nomeCursoController.text,
              codigoCursoEMEC: _codigoCursoEMECController.text.isNotEmpty ? int.tryParse(_codigoCursoEMECController.text) : null,
              numeroProcesso: null,
              tipoProcesso: null,
              dataCadastro: DateTime.now(),
              dataProtocolo: null,
              modalidade: _selectedModalidade,
              tituloConferido: _tituloConferidoController.text,
              grauConferido: _selectedGrauConferido,
              logradouro: _logradouroController.text,
              bairro: _bairroController.text,
              codigoMunicipio: int.parse(_codigoMunicipioController.text),
              nomeMunicipio: _nomeMunicipioController.text,
              uf: _ufController.text,
              cep: _cepController.text,
              autorizacaoTipo: _selectedAutorizacaoTipo,
              autorizacaoNumero: _autorizacaoNumeroController.text,
              autorizacaoData: _autorizacaoData!,
              reconhecimentoTipo: _selectedReconhecimentoTipo,
              reconhecimentoNumero: _reconhecimentoNumeroController.text,
              reconhecimentoData: _reconhecimentoData!,
            );

      widget.onSubmit(curso);
      Navigator.of(context).pop();
    }
  }

  Future<void> _selectDate(BuildContext context, bool isAutorizacao) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isAutorizacao 
          ? (_autorizacaoData ?? DateTime.now()) 
          : (_reconhecimentoData ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: context.customColorTheme.primary,
              brightness: Theme.of(context).brightness,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isAutorizacao) {
          _autorizacaoData = picked;
        } else {
          _reconhecimentoData = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.customColorTheme.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: context.customTextTheme.textLgSemibold.copyWith(
                            color: context.customColorTheme.primaryForeground,
                          ),
                        ),
                        if (widget.description != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            widget.description!,
                            style: context.customTextTheme.textSm.copyWith(
                              color: context.customColorTheme.primaryForeground.withOpacity(0.8),
                            ),
                          ),
                        ],
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
            
            // Form content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Basic Information
                      Text(
                        'Informações Básicas',
                        style: context.customTextTheme.textBaseMedium.copyWith(
                          color: context.customColorTheme.cardForeground,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _nomeCursoController,
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.foreground,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Nome do Curso *',
                                labelStyle: context.customTextTheme.textSm.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                hintText: 'Ex: Engenharia de Software',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: context.customColorTheme.border),
                                ),
                                filled: true,
                                fillColor: context.customColorTheme.input,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nome é obrigatório';
                                }
                                if (value.length > 100) {
                                  return 'Nome deve ter no máximo 100 caracteres';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _codigoCursoEMECController,
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.foreground,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Código e-MEC',
                                labelStyle: context.customTextTheme.textSm.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                hintText: 'Ex: 123456',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: context.customColorTheme.border),
                                ),
                                filled: true,
                                fillColor: context.customColorTheme.input,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedModalidade.isEmpty ? null : _selectedModalidade,
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.foreground,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Modalidade *',
                                labelStyle: context.customTextTheme.textSm.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: context.customColorTheme.border),
                                ),
                                filled: true,
                                fillColor: context.customColorTheme.input,
                              ),
                              items: _modalidades.map((modalidade) {
                                return DropdownMenuItem<String>(
                                  value: modalidade,
                                  child: Text(modalidade),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() => _selectedModalidade = value ?? '');
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Modalidade é obrigatória';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedGrauConferido.isEmpty ? null : _selectedGrauConferido,
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.foreground,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Grau Conferido *',
                                labelStyle: context.customTextTheme.textSm.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: context.customColorTheme.border),
                                ),
                                filled: true,
                                fillColor: context.customColorTheme.input,
                              ),
                              items: _grausConferidos.map((grau) {
                                return DropdownMenuItem<String>(
                                  value: grau,
                                  child: Text(grau),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() => _selectedGrauConferido = value ?? '');
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Grau conferido é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      TextFormField(
                        controller: _tituloConferidoController,
                        style: context.customTextTheme.textBase.copyWith(
                          color: context.customColorTheme.foreground,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Título Conferido *',
                          labelStyle: context.customTextTheme.textSm.copyWith(
                            color: context.customColorTheme.mutedForeground,
                          ),
                          hintText: 'Ex: Bacharel em Engenharia de Software',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: context.customColorTheme.border),
                          ),
                          filled: true,
                          fillColor: context.customColorTheme.input,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Título conferido é obrigatório';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Address Information
                      Text(
                        'Endereço',
                        style: context.customTextTheme.textBaseMedium.copyWith(
                          color: context.customColorTheme.cardForeground,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _logradouroController,
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.foreground,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Logradouro *',
                                labelStyle: context.customTextTheme.textSm.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                hintText: 'Ex: Rua das Palmeiras, 123',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: context.customColorTheme.border),
                                ),
                                filled: true,
                                fillColor: context.customColorTheme.input,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Logradouro é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _bairroController,
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.foreground,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Bairro *',
                                labelStyle: context.customTextTheme.textSm.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                hintText: 'Ex: Centro',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: context.customColorTheme.border),
                                ),
                                filled: true,
                                fillColor: context.customColorTheme.input,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Bairro é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _nomeMunicipioController,
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.foreground,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Município *',
                                labelStyle: context.customTextTheme.textSm.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                hintText: 'Ex: São Paulo',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: context.customColorTheme.border),
                                ),
                                filled: true,
                                fillColor: context.customColorTheme.input,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Município é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _ufController,
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.foreground,
                              ),
                              decoration: InputDecoration(
                                labelText: 'UF *',
                                labelStyle: context.customTextTheme.textSm.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                hintText: 'Ex: SP',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: context.customColorTheme.border),
                                ),
                                filled: true,
                                fillColor: context.customColorTheme.input,
                              ),
                              maxLength: 2,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'UF é obrigatória';
                                }
                                if (value.length != 2) {
                                  return 'UF deve ter 2 caracteres';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _cepController,
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.foreground,
                              ),
                              decoration: InputDecoration(
                                labelText: 'CEP *',
                                labelStyle: context.customTextTheme.textSm.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                hintText: 'Ex: 01234-567',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: context.customColorTheme.border),
                                ),
                                filled: true,
                                fillColor: context.customColorTheme.input,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'CEP é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      TextFormField(
                        controller: _codigoMunicipioController,
                        style: context.customTextTheme.textBase.copyWith(
                          color: context.customColorTheme.foreground,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Código do Município *',
                          labelStyle: context.customTextTheme.textSm.copyWith(
                            color: context.customColorTheme.mutedForeground,
                          ),
                          hintText: 'Ex: 3550308',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: context.customColorTheme.border),
                          ),
                          filled: true,
                          fillColor: context.customColorTheme.input,
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Código do município é obrigatório';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Código deve ser numérico';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Authorization Information
                      Text(
                        'Autorização',
                        style: context.customTextTheme.textBaseMedium.copyWith(
                          color: context.customColorTheme.cardForeground,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedAutorizacaoTipo.isEmpty ? null : _selectedAutorizacaoTipo,
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.foreground,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Tipo *',
                                labelStyle: context.customTextTheme.textSm.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: context.customColorTheme.border),
                                ),
                                filled: true,
                                fillColor: context.customColorTheme.input,
                              ),
                              items: _tiposAutorizacao.map((tipo) {
                                return DropdownMenuItem<String>(
                                  value: tipo,
                                  child: Text(tipo),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() => _selectedAutorizacaoTipo = value ?? '');
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tipo é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _autorizacaoNumeroController,
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.foreground,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Número *',
                                labelStyle: context.customTextTheme.textSm.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                hintText: 'Ex: 123/2020',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: context.customColorTheme.border),
                                ),
                                filled: true,
                                fillColor: context.customColorTheme.input,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Número é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      GestureDetector(
                        onTap: () => _selectDate(context, true),
                        child: AbsorbPointer(
                          child: TextFormField(
                            style: context.customTextTheme.textBase.copyWith(
                              color: context.customColorTheme.foreground,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Data da Autorização *',
                              labelStyle: context.customTextTheme.textSm.copyWith(
                                color: context.customColorTheme.mutedForeground,
                              ),
                              hintText: _autorizacaoData != null 
                                  ? '${_autorizacaoData!.day.toString().padLeft(2, '0')}/${_autorizacaoData!.month.toString().padLeft(2, '0')}/${_autorizacaoData!.year}'
                                  : 'Selecione a data',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: context.customColorTheme.border),
                              ),
                              filled: true,
                              fillColor: context.customColorTheme.input,
                              suffixIcon: Icon(
                                Icons.calendar_today,
                                color: context.customColorTheme.mutedForeground,
                              ),
                            ),
                            validator: (value) {
                              if (_autorizacaoData == null) {
                                return 'Data da autorização é obrigatória';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Recognition Information
                      Text(
                        'Reconhecimento',
                        style: context.customTextTheme.textBaseMedium.copyWith(
                          color: context.customColorTheme.cardForeground,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedReconhecimentoTipo.isEmpty ? null : _selectedReconhecimentoTipo,
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.foreground,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Tipo *',
                                labelStyle: context.customTextTheme.textSm.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: context.customColorTheme.border),
                                ),
                                filled: true,
                                fillColor: context.customColorTheme.input,
                              ),
                              items: _tiposAutorizacao.map((tipo) {
                                return DropdownMenuItem<String>(
                                  value: tipo,
                                  child: Text(tipo),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() => _selectedReconhecimentoTipo = value ?? '');
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tipo é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _reconhecimentoNumeroController,
                              style: context.customTextTheme.textBase.copyWith(
                                color: context.customColorTheme.foreground,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Número *',
                                labelStyle: context.customTextTheme.textSm.copyWith(
                                  color: context.customColorTheme.mutedForeground,
                                ),
                                hintText: 'Ex: 456/2023',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: context.customColorTheme.border),
                                ),
                                filled: true,
                                fillColor: context.customColorTheme.input,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Número é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      GestureDetector(
                        onTap: () => _selectDate(context, false),
                        child: AbsorbPointer(
                          child: TextFormField(
                            style: context.customTextTheme.textBase.copyWith(
                              color: context.customColorTheme.foreground,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Data do Reconhecimento *',
                              labelStyle: context.customTextTheme.textSm.copyWith(
                                color: context.customColorTheme.mutedForeground,
                              ),
                              hintText: _reconhecimentoData != null 
                                  ? '${_reconhecimentoData!.day.toString().padLeft(2, '0')}/${_reconhecimentoData!.month.toString().padLeft(2, '0')}/${_reconhecimentoData!.year}'
                                  : 'Selecione a data',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: context.customColorTheme.border),
                              ),
                              filled: true,
                              fillColor: context.customColorTheme.input,
                              suffixIcon: Icon(
                                Icons.calendar_today,
                                color: context.customColorTheme.mutedForeground,
                              ),
                            ),
                            validator: (value) {
                              if (_reconhecimentoData == null) {
                                return 'Data do reconhecimento é obrigatória';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Footer with buttons
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
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.customColorTheme.primary,
                      foregroundColor: context.customColorTheme.primaryForeground,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text(widget.isEdit ? 'Salvar Alterações' : 'Criar Curso'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}