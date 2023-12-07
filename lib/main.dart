// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetomobile/database/app_database.dart';
import 'package:projetomobile/models/refeicao.dart';
import 'package:projetomobile/pages/autenticacao_tela.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projetomobile/pages/form_refeicao.dart';
import 'package:projetomobile/pages/tela_home.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuple/tuple.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /* 
  final Refeicao refeicao = Refeicao(
    id: 0,
    nomeRefeicao: 'Teste',
    nomeAlimento: 'Arroz',
    qtdAlimento: 10,
    kcal: calcularKcal('Arroz', 10),
  );
  save(refeicao); 
  */
  
  runApp(const MyApp());
  findAll().then((refeicoes) => debugPrint(refeicoes.toString()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'NUTRIFIT',
      home: RoteadorTela(),
    );
  }
}

/* Verificador de login */
class RoteadorTela extends StatelessWidget {
  const RoteadorTela({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const TelaHome();
          } else {
            return const AutenticacaoTela();
          }
        });
  }
}

double calcularKcal(String nomeAlimento, int quantidade) {
  // Encontre o item correspondente no arrayItems
  var item = arrayItems.firstWhere(
    (element) => element.item1 == nomeAlimento,
    orElse: () =>
        const Tuple2('Não encontrado', 0.0), // Valor padrão se não encontrado
  );

  // Calcule as calorias
  double caloriasPorGrama = item.item2;
  return quantidade * caloriasPorGrama;
}

final arrayItems = [
  const Tuple2('Arroz', 2.0),
  const Tuple2('Feijão', 1.5),
  const Tuple2('Batata', 1.0),
  const Tuple2('Frango', 3.0),
  const Tuple2('Pão', 2.5),
  const Tuple2('Requeijão', 4.0),
  const Tuple2('Banana', 1.2),
  const Tuple2('Ovo', 2.8),
];
