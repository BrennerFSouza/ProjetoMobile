import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void createDatabase() {
  getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'historicoRefeicoes.db');
    openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE refeicoes('
          'id INTEGER PRIMARY KEY, '
          'nomeRefeicao TEXT '
          'nomeAlimento TEXT '
          'qtdAlimento INTEGER)');
    }, version: 1);
  });
}
