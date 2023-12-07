// ignore_for_file: unused_import, unnecessary_null_comparison, unnecessary_import
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:projetomobile/models/refeicao.dart';
import 'package:projetomobile/database/app_database.dart';
import 'package:projetomobile/pages/tela_alimento_edit.dart';

class EditRefeicao extends StatefulWidget {
  final String nomeRefeicao;

  const EditRefeicao(this.nomeRefeicao, {super.key});

  @override
  State<EditRefeicao> createState() => _EditRefeicaoState();
}

class _EditRefeicaoState extends State<EditRefeicao> {
  late TextEditingController _refeicaoController;
  late Map<String, List<Refeicao>> groupedRefeicoes;

  @override
  void initState() {
    super.initState();
    _refeicaoController = TextEditingController(text: widget.nomeRefeicao);
    groupedRefeicoes = {};
  }

  @override
  Widget build(BuildContext context) {
    String nomeRefeicao = widget.nomeRefeicao;
    return Scaffold(
      backgroundColor: const Color(0xFF364E7B),
      appBar: AppBar(
        title: const Text('Editar Refeição'),
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
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: FutureBuilder<List<Refeicao>>(
                    future: findAllByRefeicaoNome(nomeRefeicao),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(),
                              Text(
                                'Loading...',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Erro: ${snapshot.error}');
                      } else {
                        final List<Refeicao> refeicoes = snapshot.data ?? [];
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final Refeicao refeicao = refeicoes[index];
                            return _AlimentoBlockClickable(
                              refeicao: refeicao,
                              onEditComplete: () {
                                setState(
                                  () {},
                                );
                              },
                            );
                          },
                          itemCount: refeicoes.length,
                        );
                      }
                    },
                  ),
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
                              final String newnomeRefeicao =
                                  _refeicaoController.text;

                              if (newnomeRefeicao != nomeRefeicao) {
                                updateRefeicaoNome(
                                    nomeRefeicao, newnomeRefeicao);
                              }
                              Navigator.pop(context, true);
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('Salvar'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              deleteRefeicao(nomeRefeicao);
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

class _AlimentoBlock extends StatelessWidget {
  final Refeicao refeicao;

  const _AlimentoBlock(this.refeicao);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              children: [
                const TableRow(
                  children: [
                    Center(
                      child: Text(
                        'Alimento',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Quantidade',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Kcal',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Center(
                      child: Text(
                        refeicao.nomeAlimento,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        refeicao.qtdAlimento.toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        refeicao.kcal.toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AlimentoBlockClickable extends StatelessWidget {
  final Refeicao refeicao;
  final VoidCallback onEditComplete;

  const _AlimentoBlockClickable({
    required this.refeicao,
    required this.onEditComplete, 
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditAlimento(
                refeicao.id,
                refeicao.nomeAlimento,
                refeicao.qtdAlimento),
          ),
        );
        if (result != null && result == true) {
          onEditComplete();
          print('deu certo');
        }
      },
      child: _AlimentoBlock(refeicao),
    );
  }
}
