import 'package:mastering_tests/domain/models/curso_model.dart';
import 'package:mastering_tests/utils/result.dart';

/// Repository abstrato para operações com Cursos
/// Define o contrato que deve ser implementado por todas as implementações concretas
abstract interface class CursoRepository {
  /// 1. Buscar todos os cursos
  Future<Result<List<Cursos>>> getAllCursos();

  /// 2. Buscar curso por ID específico
  Future<Result<Cursos>> getCursoById({required int cursoId});

  /// 3. Criar novo curso
  Future<Result<Cursos>> createCurso({required Cursos curso});

  /// 4. Atualizar curso existente
  Future<Result<Cursos>> updateCurso({required Cursos curso});

  /// 5. Deletar curso
  Future<Result<bool>> deleteCurso({required int cursoId});
}