import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
    } on FirebaseAuthException catch (e) {
      print('Erro de autenticação: ${e.code}, ${e.message}');
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        // Trate os erros de usuário não encontrado ou senha incorreta
        return 'Credenciais inválidas. Por favor, verifique seu email e senha.';
      } else {
        // Trate outros erros de autenticação de maneira geral
        return 'Erro de autenticação: ${e.message}';
      }
    } catch (e) {
      // Capturar outras exceções não relacionadas ao Firebase Authentication
      print('Erro desconhecido: $e');
      return 'Erro desconhecido: $e';
    }
  }

  Future<void> deslogar() async {
    return _firebaseAuth.signOut();
  }
}
