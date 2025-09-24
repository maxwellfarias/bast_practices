import 'package:mastering_tests/domain/models/curso_model.dart';
import 'package:mastering_tests/utils/mocks/curso_mock.dart';
import 'package:mastering_tests/utils/result.dart';
import 'curso_repository.dart';

class CursoRepositoryImpl implements CursoRepository {
  CursoRepositoryImpl();
  
  @override
  Future<Result<List<Cursos>>> getAllCursos() async {
    return await CursoMock.getAllCursos();
  }

  @override
  Future<Result<Cursos>> getCursoById({required int cursoId}) async {
    return await CursoMock.getCursoById(cursoId: cursoId);
  }

  @override
  Future<Result<Cursos>> createCurso({required Cursos curso}) async {
    return await CursoMock.createCurso(curso: curso);
  }

  @override
  Future<Result<Cursos>> updateCurso({required Cursos curso}) async {
    return await CursoMock.updateCurso(curso: curso);
  }

  @override
  Future<Result<bool>> deleteCurso({required int cursoId}) async {
    return await CursoMock.deleteCurso(cursoId: cursoId);
  }
}