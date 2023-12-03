import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetomobile/pages/autenticacao_tela.dart';
// ignore: unused_import
import 'package:projetomobile/pages/exercicio_tela.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projetomobile/pages/formRefeicao.dart';
import 'package:projetomobile/pages/telaHome.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
            print('conta existe2');
            return TelaHome();
          } else {
            return AutenticacaoTela();
          }
        });
  }
}
