// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> cadastroUsuario({
    required String nome,
    required String senha,
    required String email,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      await userCredential.user!.updateDisplayName(nome);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "O usuário já está cadastrado";
      }
      return "Erro desconhecido";
    }
  }

  Future<String?> logarUsuarios(
    {required String email, required String senha}) async {
  try {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: senha);
    print('Conta existe');
    return null;
  } catch (e) {
    print('Erro ao tentar logar: $e');
    return 'Login incorreto. Verifique seu email e senha.';
  }
}
  Future<void> deslogar() async {
    return _firebaseAuth.signOut();
  }
}
