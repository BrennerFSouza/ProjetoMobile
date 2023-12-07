// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_import, unnecessary_import
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projetomobile/pages/tela_refeicao_edit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:projetomobile/database/app_database.dart';
import 'package:projetomobile/models/refeicao.dart';
import 'package:projetomobile/pages/form_refeicao.dart';
import 'package:projetomobile/pages/tela_home.dart';
import 'package:projetomobile/services/autenticacao_services.dart';

class TelaControleRefeicao extends StatelessWidget {
  const TelaControleRefeicao({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF364E7B),
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: Colors.grey[200],
            height: 2.0,
          ),
        ),
        title: const Text(
          "Controle de Refeições",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AutenticacaoServico().deslogar();
            },
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const TelaHome(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return child;
                  },
                  transitionDuration: Duration.zero,
                ),
              );
              break;
          }
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.local_dining),
            icon: Icon(Icons.local_dining),
            label: 'Controle de Refeições',
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Refeicao>>(
            future: findAll(),
            builder: (context, AsyncSnapshot<List<Refeicao>?> snapshot) {
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
                return const Text('Erro ao carregar os dados.');
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final List<Refeicao> refeicoes = snapshot.data!;
                final Map<String, List<Refeicao>> groupedRefeicoes = groupBy(
                    refeicoes, (Refeicao refeicao) => refeicao.nomeRefeicao);
                final double totalCalorias = refeicoes.fold(
                  0.0,
                  (double sum, Refeicao refeicao) => sum + refeicao.kcal,
                );
                final double kcalArredondado = double.parse(totalCalorias.toStringAsFixed(2));
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(0.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 2.0),
                          const Text(
                            'Total de Calorias',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Kcal: $kcalArredondado',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final List<String> keys =
                              groupedRefeicoes.keys.toList();
                          final String key = keys[index];
                          final List<Refeicao> blocos = groupedRefeicoes[key]!;

                          return _RefeicaoBlockClickable(
                            nomeRefeicao: key,
                            refeicoes: blocos,
                            onEditComplete: () {
                              setState(() {});
                            },
                          );
                        },
                        itemCount: groupedRefeicoes.length,
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: const Icon(Icons.info, color: Colors.white),
                      ),
                      const SizedBox(width: 8.0),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Tabela Vazia',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(width: 8.0),
                          Text('Insira novas refeições',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NovaRefeicao(),
                  ),
                );
                if (result != null && result == true) {
                  setState(() {});
                }
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class _RefeicaoBlock extends StatelessWidget {
  final String nomeRefeicao;
  final List<Refeicao> refeicoes;

  const _RefeicaoBlock(this.nomeRefeicao, this.refeicoes);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            nomeRefeicao,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(),
              children: [
                const TableRow(
                  children: [
                    TableCell(
                      child: Center(
                        child: Text(
                          'Alimento',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          'Quantidade',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          'Kcal',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ...refeicoes.map((refeicao) {
                  return TableRow(
                    children: [
                      TableCell(
                        child: Center(
                          child: Text(
                            refeicao.nomeAlimento,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            refeicao.qtdAlimento.toString(),
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            refeicao.kcal.toString(),
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}

class _RefeicaoBlockClickable extends StatelessWidget {
  final String nomeRefeicao;
  final List<Refeicao> refeicoes;
  final VoidCallback onEditComplete;

  const _RefeicaoBlockClickable({
    required this.nomeRefeicao,
    required this.refeicoes,
    required this.onEditComplete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditRefeicao(nomeRefeicao),
          ),
        );
        if (result != null && result == true) {
          onEditComplete();
        }
      },
      child: _RefeicaoBlock(nomeRefeicao, refeicoes),
    );
  }
}
