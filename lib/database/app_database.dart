import 'package:path/path.dart';
import 'package:projetomobile/models/refeicao.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'histRefeicao.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('CREATE TABLE refeicoes('
            'id INTEGER PRIMARY KEY, '
            'nomeRefeicao TEXT, '
            'nomeAlimento TEXT, '
            'qtdAlimento INTEGER, '
            'kcal REAL)');
      },
      version: 1,
      /* onDowngrade: onDatabaseDowngradeDelete, */
    );
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

Future<int> updateRefeicaoNome(String oldNome, String newNome) async {
  final db = await createDatabase();

  // Consulta as refeições que têm o nome antigo
  final List<Map<String, Object?>> refeicoesAntigas = await db.query(
    'refeicoes',
    where: 'nomeRefeicao = ?',
    whereArgs: [oldNome],
  );

  // Atualiza os nomes nas refeições
  for (Map<String, Object?> refeicaoMap in refeicoesAntigas) {
    final int id = refeicaoMap['id'] as int;
    final Map<String, dynamic> newRefeicaoMap = {
      'nomeRefeicao': newNome,
    };

    // Atualiza a refeição com o novo nome
    await db.update(
      'refeicoes',
      newRefeicaoMap,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  return refeicoesAntigas.length;
}

Future<int> updateAlimento(int id, String nomeAlimento, int qtdAlimento) async {
  final db = await createDatabase();
  final Map<String, dynamic> alimentoMap = {
    'nomeAlimento': nomeAlimento,
    'qtdAlimento': qtdAlimento,
  };

  return await db.update(
    'refeicoes', // Nome da tabela
    alimentoMap,
    where: 'id = ?',
    whereArgs: [id],
  );
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

Future<List<Refeicao>> findAllByRefeicaoNome(String nomeRefeicao) {
  return createDatabase().then((db) {
    return db.query('refeicoes', where: 'nomeRefeicao = ?', whereArgs: [nomeRefeicao]).then((maps) {
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

Future<Refeicao?> findById(int id) {
  return createDatabase().then((db) {
    return db.query('refeicoes', where: 'id = ?', whereArgs: [id]).then((maps) {
      if (maps.isNotEmpty) {
        final Map<String, dynamic> map = maps.first;
        return Refeicao(
          id: map['id'],
          nomeRefeicao: map['nomeRefeicao'],
          nomeAlimento: map['nomeAlimento'],
          qtdAlimento: map['qtdAlimento'],
          kcal: map['kcal'] ?? 0.0,
        );
      }
      return null; // Retorna null se não encontrar nenhuma correspondência.
    });
  });
}

Future<int> deleteRefeicao(String nomeRefeicao) async {
  final db = await createDatabase();
  return await db.delete(
    'refeicoes',
    where: 'nomeRefeicao = ?',
    whereArgs: [nomeRefeicao],
  );
}

Future<int> deleteAlimento(int id) async {
  final db = await createDatabase();
  return await db.delete(
    'refeicoes', // Substitua pelo nome da tabela correspondente aos alimentos
    where: 'id = ?',
    whereArgs: [id],
  );
}