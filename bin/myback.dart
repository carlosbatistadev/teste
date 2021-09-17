import 'package:shelf_router/shelf_router.dart';
import 'apis/frases_api.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  final app = Router();

  app.mount('/frases/', FrasesApi().router);

  await io.serve(app, 'localhost', 8081);
}
