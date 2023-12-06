// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetomobile/database/app_database.dart';
import 'package:projetomobile/models/refeicao.dart';
import 'package:projetomobile/pages/autenticacao_tela.dart';
import 'package:projetomobile/pages/exercicio_tela.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projetomobile/pages/form_refeicao.dart';
import 'package:projetomobile/pages/tela_home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

  /* save(Refeicao(
    id: 1,
    nomeRefeicao: 'teste',
    nomeAlimento: 'Arroz',
    qtdAlimento: 111,
  )).then((id) {
    findAll().then((refeicoes) => debugPrint(refeicoes.toString()));
  }); */
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
