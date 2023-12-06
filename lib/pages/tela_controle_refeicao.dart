// ignore_for_file: unused_import, unnecessary_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projetomobile/models/refeicao.dart';
import 'package:projetomobile/pages/form_refeicao.dart';
import 'package:projetomobile/pages/tela_home.dart';
import 'package:projetomobile/services/autenticacao_services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:projetomobile/models/exercicio_modelo.dart';
import 'package:projetomobile/models/sentimento_modelo.dart';

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
  final List<Refeicao> refeicoes = [];
  @override
  Widget build(BuildContext context) {
    refeicoes.add(
      Refeicao(
        id: 0,
        nomeRefeicao: 'Teste111',
        nomeAlimento: 'Arroz',
        qtdAlimento: 1234,
      ),
    );
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
        body: ListView.builder(
          itemBuilder: (context, index) {
            final Refeicao refeicao = refeicoes[index];
            return _RefeicaoItem(refeicao);
          },
          itemCount: refeicoes.length,
        )

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
        );
  }
}

class _RefeicaoItem extends StatelessWidget {
  final Refeicao refeicao;

  const _RefeicaoItem(this.refeicao);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
