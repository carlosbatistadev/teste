import 'dart:convert';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class FrasesApi {
  List<Map<String, dynamic>?> frases = [
    {'id': 1, 'content': 'O tempo funciona com o relógio'},
    {'id': 2, 'content': 'Programar hoje, Programar amanhã, Programar Sempre'},
    {'id': 3, 'content': 'Vamos comer uma pizza?'},
    {'id': 4, 'content': 'Testador de testes'}
  ];

  List<Map<String, dynamic>?> favoritas = [];

  final defaultHeaders = {'Content-Type': 'application/json'};

  Router get router {
    final router = Router();

    router.get('/favoritas/<id|.*>', (Request request, String id) {
      final _id = int.tryParse(id);

      final frase = favoritas.firstWhere(
        (e) => e!['id'] == _id,
        orElse: () => null,
      );

      if (frase != null) {
        return Response.ok(json.encode(frase), headers: defaultHeaders);
      } else if (_id == null) {
        return Response.ok(json.encode(favoritas), headers: defaultHeaders);
      } else {
        return Response.notFound(
          'A frase não está em favoritas',
          headers: defaultHeaders,
        );
      }
    });

    router.post('/favoritar/<id>', (Request request, String id) {
      final _id = int.tryParse(id);

      final frase = frases.firstWhere(
        (e) => e!['id'] == _id,
        orElse: () => null,
      );

      if (frase != null) {
        favoritas.add(frase);
        return Response.ok('Frase adicionada aos favoritos');
      }

      return Response.notFound('Frase não encontrada');
    });

    router.get('/<id|.*>', (Request request, String id) {
      final _id = int.tryParse(id);

      final frase = frases.firstWhere(
        (e) => e!['id'] == _id,
        orElse: () => null,
      );

      if (frase != null) {
        return Response.ok(json.encode(frase), headers: defaultHeaders);
      } else if (_id == null) {
        return Response.ok(json.encode(frases), headers: defaultHeaders);
      } else {
        return Response.notFound(
          'Frase não encontrada!',
          headers: defaultHeaders,
        );
      }
    });

    return router;
  }
}
