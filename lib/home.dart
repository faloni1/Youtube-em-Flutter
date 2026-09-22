import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/telas/biblioteca.dart';
import 'package:youtube/telas/em_alta.dart';
import 'package:youtube/telas/inicio.dart';
import 'package:youtube/telas/inscricoes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual = 0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      Inicio(_resultado),
      EmAlta(),
      Inscricoes(),
      Biblioteca()
    ];
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "images/youtube.png",
          width: 100,
          height: 24,
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.videocam)
          ),
          IconButton(
              onPressed: () async {
                String? res = await showSearch(context: context, delegate: CustomSearchDelegate());
                setState(() {
                  _resultado = res as String;
                });
              },
              icon: Icon(Icons.search)
          ),
          IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.account_circle)
          ),
        ],
      ),
      body: Container(
        child: telas[_indiceAtual]
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indiceAtual,
          onTap: (indice){
            setState(() {
              _indiceAtual = indice;
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
          items: [
            BottomNavigationBarItem(
                label: 'Início',
                icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
                label: 'Em alta',
                icon: Icon(Icons.whatshot)
            ),
            BottomNavigationBarItem(
                label: 'Inscrições',
                icon: Icon(Icons.subscriptions)
            ),
            BottomNavigationBarItem(
                label: 'Biblioteca',
                icon: Icon(Icons.video_library)
            ),
          ],
      ),
    );
  }
}
