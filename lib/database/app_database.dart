import 'package:path/path.dart';
import 'package:projetomobile/models/refeicao.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'histRefeicao.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE refeicoes('
          'id INTEGER PRIMARY KEY, '
          'nomeRefeicao TEXT, '
          'nomeAlimento TEXT, '
          'qtdAlimento INTEGER, '
          'kcal REAL)');
    }, version: 3);
  });
}

Future<int> save(Refeicao refeicao) {
  return createDatabase().then((db) {
    final Map<String, dynamic> refeicaoMap = {};
    refeicaoMap['nomeRefeicao'] = refeicao.nomeRefeicao;
    refeicaoMap['nomeAlimento'] = refeicao.nomeAlimento;
    refeicaoMap['qtdAlimento'] = refeicao.qtdAlimento;
    refeicaoMap['kcal'] = refeicao.kcal;
    return db.insert('refeicoes', refeicaoMap);
  });
}

Future<List<Refeicao>> findAll() {
  return createDatabase().then((db) {
    return db.query('refeicoes').then((maps) {
      final List<Refeicao> refeicoes = [];
      for (Map<String, dynamic> map in maps) {
        final Refeicao refeicao = Refeicao(
          id: map['id'],
          nomeRefeicao: map['nomeRefeicao'],
          nomeAlimento: map['nomeAlimento'],
          qtdAlimento: map['qtdAlimento'],
          kcal: map['kcal'] ?? 0.0,
        );
        refeicoes.add(refeicao);
      }
      return refeicoes;
    });
  });
}

Future<void> dropTables(Database db) async {
  await db.execute('DROP TABLE IF EXISTS refeicoes');
  // Adicione outras tabelas que você deseja dropar, se houver mais de uma
}