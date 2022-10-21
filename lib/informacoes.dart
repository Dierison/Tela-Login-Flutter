import 'package:flutter/material.dart';

class InformacoesPage extends StatelessWidget {
  const InformacoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sobre nós"),
        ),
        body: SizedBox(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Text("Dierison Sousa e Higor Bueno")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                    "API's públicas utilizadas: https://api.adviceslip.com/advice")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                    "Para login e armazenar frases nós construímos uma API própria em Node.js e NestJS")
              ],
            )
          ]),
        ));
  }
}
