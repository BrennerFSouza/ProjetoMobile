
import 'package:flutter/material.dart';
import 'package:projetomobile/pages/tela_controle_refeicao.dart';
import 'package:projetomobile/services/autenticacao_services.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

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
    //final ThemeData theme = Theme.of(context);
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
                      const TelaControleRefeicao(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                  
                    return child;
                  },
                  transitionDuration: Duration
                      .zero, 
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
      body: <Widget>[
        const Card(
          shadowColor: Colors.transparent,
          margin: EdgeInsets.all(8.0),
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
