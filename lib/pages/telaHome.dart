// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projetomobile/pages/telaControleRefeicao.dart';
import 'package:projetomobile/services/autenticacao_services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:projetomobile/models/exercicio_modelo.dart';
import 'package:projetomobile/models/sentimento_modelo.dart';

class TelaHome extends StatelessWidget {
  TelaHome({super.key});

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
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(0xFF364E7B),
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
            icon: Icon(Icons.logout),
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

          // Adicione a lógica para navegar para a página correspondente
          switch (index) {
            /* 
            Não fazer nada caso já esteja na tela Home
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaHome(),
                ),
              );
              break; */
            case 1:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      TelaControleRefeicao(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // Aqui definimos uma transição que não realiza nenhuma animação visível
                    return child;
                  },
                  transitionDuration: Duration
                      .zero, // Define a duração da transição como zero para desativar a animação
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
      body: <Widget>[
        /// Home page
        const Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Text('Dados Dashboard')),
              Center(child: Text('Em produção...')),
            ],
          ),
        ),
      ][currentPageIndex],
    );
  }
}
