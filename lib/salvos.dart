import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';

class SalvosPage extends StatefulWidget {
  int idUsuario;
  String nomeUsuario;
  SalvosPage({Key? key, required this.idUsuario, required this.nomeUsuario})
      : super(key: key);

  @override
  State<SalvosPage> createState() => _SalvosPageState();
}

class _SalvosPageState extends State<SalvosPage> {
  List<dynamic> tabela = [];

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
    carregarFrases();
    return Scaffold(
        appBar: AppBar(
          title: Text("Hi ${widget.nomeUsuario}!!!"),
        ),
        body: SizedBox(
          child: Container(
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
        ));
  }
}
