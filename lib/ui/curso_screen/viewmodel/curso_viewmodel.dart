import 'package:flutter/widgets.dart';
import 'package:mastering_tests/data/repositories/curso/curso_repository.dart';
import 'package:mastering_tests/domain/models/curso_model.dart';
import 'package:mastering_tests/utils/command.dart';
import 'package:mastering_tests/utils/result.dart';

final class CursoViewModel extends ChangeNotifier {
  CursoViewModel({required CursoRepository cursoRepository}) : _cursoRepository = cursoRepository {
    
    // Inicializar os 5 commands obrigatórios
    _getAllCursosCommand = Command0<List<Cursos>>(_getAllCursos);
    _getCursoByIdCommand = Command1<Cursos, int>(_getCursoById);
    _createCursoCommand = Command1<Cursos, Cursos>(_createCurso);
    _updateCursoCommand = Command1<Cursos, Cursos>(_updateCurso);
    _deleteCursoCommand = Command1<bool, int>(_deleteCurso);
  }

  final CursoRepository _cursoRepository;

  // Os 5 Commands obrigatórios
  late final Command0<List<Cursos>> _getAllCursosCommand;
  late final Command1<Cursos, int> _getCursoByIdCommand;
  late final Command1<Cursos, Cursos> _createCursoCommand;
  late final Command1<Cursos, Cursos> _updateCursoCommand;
  late final Command1<bool, int> _deleteCursoCommand;

  // Getters públicos para os commands
  Command0<List<Cursos>> get getAllCursosCommand => _getAllCursosCommand;
  Command1<Cursos, int> get getCursoByIdCommand => _getCursoByIdCommand;
  Command1<Cursos, Cursos> get createCursoCommand => _createCursoCommand;
  Command1<Cursos, Cursos> get updateCursoCommand => _updateCursoCommand;
  Command1<bool, int> get deleteCursoCommand => _deleteCursoCommand;

  // Estado interno
  List<Cursos> _cursos = [];
  List<Cursos> get cursos => _cursos;

  // Implementações dos métodos que serão chamados pelos commands

  /// 1. Buscar todos os cursos
  Future<Result<List<Cursos>>> _getAllCursos() async {
    final result = await _cursoRepository.getAllCursos();
    
    if (result case Ok(:final value)) {
      _cursos = value;
      notifyListeners();
    }
    
    return result;
  }

  /// 2. Buscar curso por ID
  Future<Result<Cursos>> _getCursoById(int cursoId) async {
    return await _cursoRepository.getCursoById(cursoId: cursoId);
  }

  /// 3. Criar curso
  Future<Result<Cursos>> _createCurso(Cursos curso) async {
    final result = await _cursoRepository.createCurso(curso: curso);
    
    if (result case Ok(:final value)) {
      _cursos.add(value);
      notifyListeners();
    }
    
    return result;
  }

  /// 4. Atualizar curso
  Future<Result<Cursos>> _updateCurso(Cursos curso) async {
    final result = await _cursoRepository.updateCurso(curso: curso);
    
    if (result case Ok(:final value)) {
      final index = _cursos.indexWhere((c) => c.cursoID == value.cursoID);
      if (index != -1) {
        _cursos[index] = value;
        notifyListeners();
      }
    }
    
    return result;
  }

  /// 5. Deletar curso
  Future<Result<bool>> _deleteCurso(int cursoId) async {
    final result = await _cursoRepository.deleteCurso(cursoId: cursoId);
    
    if (result case Ok()) {
      _cursos.removeWhere((curso) => curso.cursoID == cursoId);
      notifyListeners();
    }
    
    return result;
  }

  // Métodos públicos para execução dos commands

  /// Executa busca de todos os cursos
  Future<void> getAllCursos() async {
    await _getAllCursosCommand.execute();
  }

  /// Executa busca de curso por ID
  Future<void> getCursoById(int cursoId) async {
    await _getCursoByIdCommand.execute(cursoId);
  }

  /// Executa criação de curso
  Future<void> createCurso(Cursos curso) async {
    await _createCursoCommand.execute(curso);
  }

  /// Executa atualização de curso
  Future<void> updateCurso(Cursos curso) async {
    await _updateCursoCommand.execute(curso);
  }

  /// Executa exclusão de curso
  Future<void> deleteCurso(int cursoId) async {
    await _deleteCursoCommand.execute(cursoId);
  }

  // Estado de loading geral
  bool get isLoading {
    return _getAllCursosCommand.running ||
           _getCursoByIdCommand.running ||
           _createCursoCommand.running ||
           _updateCursoCommand.running ||
           _deleteCursoCommand.running;
  }

  // Estado de erro geral
  bool get hasError {
    return _getAllCursosCommand.error ||
           _getCursoByIdCommand.error ||
           _createCursoCommand.error ||
           _updateCursoCommand.error ||
           _deleteCursoCommand.error;
  }

  // Mensagem de erro geral
  String? get errorMessage {
    if (_getAllCursosCommand.error) return _getAllCursosCommand.errorMessage;
    if (_getCursoByIdCommand.error) return _getCursoByIdCommand.errorMessage;
    if (_createCursoCommand.error) return _createCursoCommand.errorMessage;
    if (_updateCursoCommand.error) return _updateCursoCommand.errorMessage;
    if (_deleteCursoCommand.error) return _deleteCursoCommand.errorMessage;
    return null;
  }

  // Limpar todos os resultados
  void clearResults() {
    _getAllCursosCommand.clearResult();
    _getCursoByIdCommand.clearResult();
    _createCursoCommand.clearResult();
    _updateCursoCommand.clearResult();
    _deleteCursoCommand.clearResult();
  }
}