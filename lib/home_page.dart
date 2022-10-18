import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
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
  final controllerFrase = TextEditingController();
  String fraseFinal = "";

  Future<void> gostei() async {
    setState(() {
      fraseFinal = controllerFrase.text;
    });

    await Dio().post('http://localhost:3001/frases',
        data: {'idUsuario': widget.idUsuario, 'frase': fraseFinal});

    carregarFrases();
  }

  Future<void> trocar() async {
    try {
      var response = await Dio().get('https://api.adviceslip.com\advice');
      Map<String, dynamic> responseMap = json.decode(response.toString());
      setState(() {
        controllerFrase.text = responseMap['slip'];
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
                            fontWeight: FontWeight.bold, fontSize: 18),
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
                      title: Text(tabela[frase]),
                    );
                  },
                  padding: EdgeInsets.all(16),
                  separatorBuilder: (_, ___) => Divider(),
                  itemCount: tabela.length),
            ),
          ]),
        ));
  }
}
