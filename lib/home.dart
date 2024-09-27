import "package:flutter/material.dart";
import "package:youtube/CustomSearchDelegate.dart";
import "package:youtube/screens/biblioteca.dart";
import "package:youtube/screens/em_alta.dart";
import "package:youtube/screens/inicio.dart";
import "package:youtube/screens/inscricao.dart";

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

    List <Widget> telas = [
      Inicio( _resultado ),
      EmAlta(),
      Inscricao(),
      Biblioteca(),
    ];


    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1,
        ),
        title: Image.asset(
          "images/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                String res = await showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                ) ?? "";
                setState(() {
                  _resultado = res;
                });
                print("Resultado digitado: " + res );
              },
              icon: Icon(Icons.search_rounded)),

        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice){
          setState(() {
            _indiceAtual = indice;
          });
        },
        fixedColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            label: "Em alta",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: "Inscrições",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: "Biblioteca",
          ),

        ],
      ),
    );
  }
}
