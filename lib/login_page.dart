import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tela_login/cadastro.dart';
import 'package:tela_login/home_page.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerUsuario = TextEditingController();
  final controllerSenha = TextEditingController();

  Future<void> login() async {
    try {
      var response = await Dio().post('http://localhost:3001/users/login',
          data: {
            'username': controllerUsuario.text,
            'senha': controllerSenha.text
          });
      Map<String, dynamic> responseMap = json.decode(response.toString());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage(idUsuario: responseMap["id"], nomeUsuario: responseMap["nome"])));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 167, 208, 231),
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.android,
                size: 200,
              ),
              SizedBox(height: 55),

              //Olá Novamente!
              Text(
                'Olá Novamente!',
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Seja bem vindo, sentimos a sua falta!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 50),

              //Campo Nome
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: controllerUsuario,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nome',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              //Campo Senha
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: controllerSenha,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Senha',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              //Botão login
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        onPressed: login,
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 10),
                    ]),
              ),
              SizedBox(height: 10),

              //Não tem cadastro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Crie o seu',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                      onPressed: (() => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const Cadastro()))),
                      child: Text(
                        "cadastro",
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
        )));
  }
}
