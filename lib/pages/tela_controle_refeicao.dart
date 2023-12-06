// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_import, unnecessary_import
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
        title: const Text(
          "Dashboard",
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
          // Switch da tela
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
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
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
                      Text('Loading...'),
                    ],
                  ),
                ); // ou outro widget de carregamento
              } else if (snapshot.hasError) {
                return const Text('Erro ao carregar os dados.');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Text('Sem dados disponíveis.');
              } else {
                final List<Refeicao> refeicoes = snapshot.data!;
                final Map<String, List<Refeicao>> groupedRefeicoes = groupBy(
                    refeicoes, (Refeicao refeicao) => refeicao.nomeRefeicao);

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final List<String> keys = groupedRefeicoes.keys.toList();
                    final String key = keys[index];
                    final List<Refeicao> blocos = groupedRefeicoes[key]!;

                    // Aqui, você pode criar um widget para exibir o bloco de itens
                    return _RefeicaoBlock(key, blocos);
                  },
                  itemCount: groupedRefeicoes.length,
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
    // Controle de Refeições
    /* Stack(
        children: [
          const Card(
            shadowColor: Colors.transparent,
            margin: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: Text('Tela com as refeições salvas no Firebase')),
                Center(
                    child:
                        Text('Esperando fazer conexão com o Banco de Dados.')),
                Center(child: Text('Em produção...')),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NovaRefeicao(),
                  ),
                ).then(
                  (newRefeicao) => debugPrint(newRefeicao.toString()),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ), */
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
          const SizedBox(
              height: 8.0), // Adiciona espaço entre o nomeRefeicao e a tabela
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
          const SizedBox(
              height: 8.0),],
      ),
    );
  }
}

/* 
class _RefeicaoItem extends StatelessWidget {
  final Refeicao refeicao;

  const _RefeicaoItem(
    Key? key,
    this.refeicao,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          refeicao.nomeRefeicao,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              refeicao.nomeAlimento,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            Text(
              refeicao.qtdAlimento.toString(),
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */