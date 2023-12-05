// ignore_for_file: avoid_print, unused_import

import 'package:flutter/material.dart';
import 'package:projetomobile/_comum/snackbar_authentication.dart';
import 'package:projetomobile/_comum/minhascores.dart';
import 'package:projetomobile/components/decoration_camp_authentication.dart';
import 'package:projetomobile/services/autenticacao_services.dart';
import 'package:projetomobile/pages/tela_home.dart';

class AutenticacaoTela extends StatefulWidget {
  const AutenticacaoTela({super.key});

  @override
  State<AutenticacaoTela> createState() => _AutenticacaoTelaState();
}

class _AutenticacaoTelaState extends State<AutenticacaoTela> {
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  final AutenticacaoServico _autenServico = AutenticacaoServico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  MinhasCores.fundotopo,
                  MinhasCores.fundobaixo,
                ])),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: 128,
                      ),
                      const Text(
                        "NutriFit",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: getAuthenticationInputDecoration("E-mail"),
                        validator: (String? value) {
                          if (value == null) {
                            return "O e-mail não pode ser vazio";
                          }
                          if (value.length < 5) {
                            return "O e-mail é muito curto";
                          }
                          if (!value.contains("@")) {
                            return "O e-mail não é válido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _senhaController,
                        decoration: getAuthenticationInputDecoration("Senha"),
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null) {
                            return "A senha não pode ser vazio";
                          }
                          if (value.length < 5) {
                            return "A senha é muito curto";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      Visibility(
                        visible: !queroEntrar,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: getAuthenticationInputDecoration(
                                  "Confirme Senha"),
                              validator: (String? value) {
                                if (value == null) {
                                  return "A confirmação de senha não pode ser vazio";
                                }
                                if (value.length < 5) {
                                  return "A confirmação de senha é muito curta";
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _nomeController,
                              decoration:
                                  getAuthenticationInputDecoration("Nome"),
                              validator: (String? value) {
                                if (value == null) {
                                  return "O nome não pode ser vazio";
                                }
                                if (value.length < 5) {
                                  return "O nome é muito curto";
                                }

                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          botaoPrincipalClicado();
                        },
                        child: Text((queroEntrar) ? "Entrar" : "Cadastrar"),
                      ),
                      const Divider(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            queroEntrar = !queroEntrar;
                          });
                        },
                        child: Text(
                          (queroEntrar) ? "Registrar agora" : "Fazer login",
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  botaoPrincipalClicado() {
    String nome = _nomeController.text;
    String senha = _senhaController.text;
    String email = _emailController.text;

    if (_formKey.currentState!.validate()) {
      if (queroEntrar) {
        print("Entrada validada");

        _autenServico.logarUsuarios(email: email, senha: senha).then(
          (String? erro) {
            if (erro != null) {
              showSnackbar(context: context, texto: erro);
            }
          },
        );

        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaHome(),
          ),
        ); */
      } else {
        print("Cadastro validado");
        print(
            "${_emailController.text},${_senhaController.text},${_nomeController.text},");
        _autenServico
            .cadastroUsuario(nome: nome, senha: senha, email: email)
            .then(
          (String? erro) {
            if (erro != null) {
              showSnackbar(context: context, texto: erro);
            } else {
              showSnackbar(
                context: context,
                texto: "Cadastro com sucesso",
                isErro: false,
              );
            }
          },
        );
      }
    } else {
      print("invalido");
    }
  }
}
