import 'package:flutter/material.dart';
import 'package:mastering_tests/data/repositories/curso/curso_repository_impl.dart';
import 'package:mastering_tests/ui/curso_screen/viewmodel/curso_viewmodel.dart';
import 'package:mastering_tests/ui/curso_screen/widget/curso_screen.dart';

/// Exemplo de como usar a CursoScreen
/// Este arquivo demonstra a integração completa da arquitetura de 6 camadas
class CursoScreenExample extends StatelessWidget {
  const CursoScreenExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Instanciar as dependências seguindo a arquitetura
    final cursoRepository = CursoRepositoryImpl();
    final cursoViewModel = CursoViewModel(cursoRepository: cursoRepository);

    return CursoScreen(viewModel: cursoViewModel);
  }
}

/// Exemplo de integração no MaterialApp
class CursoApp extends StatelessWidget {
  const CursoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão de Cursos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CursoScreenExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Para usar no main.dart:
/// ```dart
/// void main() {
///   runApp(const CursoApp());
/// }
/// ```