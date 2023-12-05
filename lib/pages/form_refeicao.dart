// ignore_for_file: unused_import, unnecessary_null_comparison
// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NovaRefeicao extends StatefulWidget {
  const NovaRefeicao({super.key});

  @override
  State<NovaRefeicao> createState() => _NovaRefeicaoState();
}

class _NovaRefeicaoState extends State<NovaRefeicao> {
  final TextEditingController _refeicaoController = TextEditingController();
  String? nomeAlimento1;
  final TextEditingController _qtd1Controller = TextEditingController();
  String? nomeAlimento2;
  final TextEditingController _qtd2Controller = TextEditingController();
  String? nomeAlimento3;
  final TextEditingController _qtd3Controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Defina o valor inicial desejado para nomeAlimento1
    nomeAlimento1 = 'Selecionar Alimento';
    nomeAlimento2 = 'Selecionar Alimento';
    nomeAlimento3 = 'Selecionar Alimento';
  }

  final items = [
    'Selecionar Alimento',
    'Arroz',
    'Feijão',
    'Batata',
    'Frango',
    'Pão',
    'Requeijão',
    'Banana',
    'Ovo'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF364E7B),
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Registrar Nova Refeição",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3),
              ),
              child: Column(
                children: [
                  /* Nome Central da refeição */
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _refeicaoController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nome da Refeição',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),

                  /* Nome do Primeiro Alimento */
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        color: Colors.white70,
                      ),
                      child: DropdownButton<String>(
                        value: nomeAlimento1,
                        isExpanded: true,
                        items: items.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              // Centraliza o texto dentro do DropdownMenuItem
                              child: Text(value, textAlign: TextAlign.center),
                            ),
                          );
                        }).toList(),
                        onChanged: (nomeAlimento1) =>
                            setState(() => this.nomeAlimento1 = nomeAlimento1),
                      ),
                    ),
                  ),

                  /* Quantidade do 1º Alimento */
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _qtd1Controller,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Quantidade(g)',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),

                  /* Nome 2º Alimento */
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        color: Colors.white70,
                      ),
                      child: DropdownButton<String>(
                        value: nomeAlimento2,
                        isExpanded: true,
                        items: items.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              // Centraliza o texto dentro do DropdownMenuItem
                              child: Text(value, textAlign: TextAlign.center),
                            ),
                          );
                        }).toList(),
                        onChanged: (nomeAlimento2) =>
                            setState(() => this.nomeAlimento2 = nomeAlimento2),
                      ),
                    ),
                  ),
                  /* Qtd 2º Alimento */
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _qtd2Controller,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Quantidade(g)',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),

                  /* Nome 3º Alimento */
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        color: Colors.white70,
                      ),
                      child: DropdownButton<String>(
                        value: nomeAlimento3,
                        isExpanded: true,
                        items: items.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              // Centraliza o texto dentro do DropdownMenuItem
                              child: Text(value, textAlign: TextAlign.center),
                            ),
                          );
                        }).toList(),
                        onChanged: (nomeAlimento3) =>
                            setState(() => this.nomeAlimento3 = nomeAlimento3),
                      ),
                    ),
                  ),
                  /* Qtd 3º Alimento */
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _qtd3Controller,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Quantidade(g)',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                          height: 25.0), // Adiciona espaço acima da Row
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal:
                                30.0), // Adiciona espaçamento horizontal
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Alinha os botões nas extremidades
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                final String nomeRefeicao =
                                    _refeicaoController.text;

                                final String? nomedoAlimento1 = nomeAlimento1;
                                final int? qtd1 =
                                    int.tryParse(_qtd1Controller.text);
                                final String? nomedoAlimento2 = nomeAlimento2;
                                final int? qtd2 =
                                    int.tryParse(_qtd2Controller.text);
                                final String? nomedoAlimento3 = nomeAlimento3;
                                final int? qtd3 =
                                    int.tryParse(_qtd3Controller.text);

                                if (nomeRefeicao != null &&
                                    (nomedoAlimento1 != 'Selecionar Alimento' ||
                                        nomedoAlimento2 !=
                                            'Selecionar Alimento' ||
                                        nomedoAlimento3 !=
                                            'Selecionar Alimento')) {
                                  print(_refeicaoController.text);

                                  if (nomedoAlimento1 !=
                                          'Selecionar Alimento' &&
                                      qtd1 != null) {
                                    print(nomedoAlimento1);
                                    print(qtd1);
                                  }
                                  if (nomedoAlimento2 !=
                                          'Selecionar Alimento' &&
                                      qtd2 != null) {
                                    print(nomedoAlimento2);
                                    print(qtd2);
                                  }
                                  if (nomedoAlimento3 !=
                                          'Selecionar Alimento' &&
                                      qtd3 != null) {
                                    print(nomedoAlimento3);
                                    print(qtd3);
                                  }
                                }
                              },
                              child: const Text('Adicionar'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancelar'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );
}