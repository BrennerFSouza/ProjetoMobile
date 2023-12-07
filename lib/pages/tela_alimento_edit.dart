// ignore_for_file: unused_import, unnecessary_null_comparison, unnecessary_import

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:projetomobile/models/refeicao.dart';
import 'package:projetomobile/database/app_database.dart';

class EditAlimento extends StatefulWidget {
  final int id;
  final String nomeAlimento;
  final int qtdAlimento;

  const EditAlimento(this.id, this.nomeAlimento, this.qtdAlimento, {super.key});

  @override
  State<EditAlimento> createState() => _EditAlimentoState();
}

class _EditAlimentoState extends State<EditAlimento> {
  late TextEditingController _qtdController = TextEditingController();
  String? newnomeAlimento;

  @override
  void initState() {
    super.initState();
    _qtdController = TextEditingController(text: widget.qtdAlimento.toString());
    newnomeAlimento = widget.nomeAlimento;
  }

  final items = [
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
    final int id = widget.id;

    return Scaffold(
      backgroundColor: const Color(0xFF364E7B),
      appBar: AppBar(
        title: const Text('Editar Alimento'),
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
                      value: newnomeAlimento,
                      isExpanded: true,
                      items: items.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                            child: Text(value, textAlign: TextAlign.center),
                          ),
                        );
                      }).toList(),
                      onChanged: (newnomeAlimento) => setState(
                          () => this.newnomeAlimento = newnomeAlimento),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _qtdController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Quantidade(g)',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              final String nomedoNovoAlimento =
                                  newnomeAlimento!;
                              final int? newqtd =
                                  int.tryParse(_qtdController.text);

                              print(nomedoNovoAlimento);
                              print(newqtd);
                              if (nomedoNovoAlimento != null && newqtd != null ) {
                              updateAlimento(id, nomedoNovoAlimento, newqtd);
                                
                              }

                              Navigator.pop(context, true);
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('Salvar'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              deleteAlimento(id);
                              Navigator.pop(context, true);
                            },
                            icon: const Icon(Icons.delete),
                            label: const Text('Deletar'),
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
      ),
    );
  }
}
