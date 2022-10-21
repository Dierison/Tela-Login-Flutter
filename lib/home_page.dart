import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:tela_login/informacoes.dart';
import 'package:tela_login/salvos.dart';
import 'dart:convert';
import 'dart:async';

class HomePage extends StatefulWidget {
  int idUsuario;
  String nomeUsuario;
  HomePage({Key? key, required this.idUsuario, required this.nomeUsuario})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> tabela = [];
  List<dynamic> tabelaTemp = [];
  final controllerFrase = TextEditingController();
  String fraseFinal = "";

  Future<void> gostei() async {
    setState(() {
      fraseFinal = controllerFrase.text;
      tabelaTemp.add(controllerFrase.text);
    });

    await Dio().post('http://localhost:3001/frases',
        data: {'idUsuario': widget.idUsuario, 'frase': fraseFinal});

    carregarFrases();
  }

  Future<void> trocar() async {
    try {
      var response = await Dio().get('https://api.adviceslip.com/advice');
      Map<String, dynamic> responseMap = json.decode(response.toString());
      var slipData = responseMap['slip'];
      var quote = slipData['advice'];
      setState(() {
        controllerFrase.text = quote;
      });
    } catch (e) {}
  }

  Future<void> carregarFrases() async {
    var frasesAtualizadas = await Dio()
        .get('http://localhost:3001/frases/usuario/${widget.idUsuario}');
    Map<String, dynamic> responseMap =
        json.decode(frasesAtualizadas.toString());
    setState(() {
      tabela = responseMap['listaFrases'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi ${widget.nomeUsuario}!!!"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(children: [
          Container(
            color: Colors.white,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(children: [
                  TextFormField(
                    controller: controllerFrase,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Next advice',
                    ),
                  )
                ])),
          ),
          Container(
              color: Colors.white,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    onPressed: trocar,
                    child: const Text('Next...'),
                  ),
                  OutlinedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.green,
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    onPressed: gostei,
                    child: const Text('I liked!'),
                  ),
                ],
              )),
          Container(
            height: 500,
            child: ListView.separated(
                itemBuilder: (BuildContext context, int frase) {
                  return ListTile(
                    title: Text(tabelaTemp[frase]),
                  );
                },
                padding: EdgeInsets.all(16),
                separatorBuilder: (_, ___) => Divider(),
                itemCount: tabelaTemp.length),
          ),
        ]),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: const Text("Home"),
              onTap: (() => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage(
                      idUsuario: widget.idUsuario,
                      nomeUsuario: widget.nomeUsuario)))),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: const Text("Saved"),
              onTap: (() => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SalvosPage(
                        idUsuario: widget.idUsuario,
                        nomeUsuario: widget.nomeUsuario,
                      )))),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: const Text("Sobre nós"),
              onTap: (() => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => InformacoesPage()))),
            )
          ],
        ),
      ),
    );
  }
}
