import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tela_login/login_page.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final controllerNome = TextEditingController();
  final controllerUsuario = TextEditingController();
  final controllerSenha = TextEditingController();

  Future<void> cadastrar() async {
    try {
      await Dio().post('http://localhost:3001/users', data: {
        'nome': controllerNome.text,
        'username': controllerUsuario.text,
        'senha': controllerSenha.text
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginPage()));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255,149,186,168),
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Container(
                  width: 300,
                  height: 300,
                  child: Image.network(
                    'https://static.vecteezy.com/ti/vetor-gratis/p1/665318-mulher-negocio-com-anjo-diabo-ligado-ombro-gr%C3%A1tis-vetor.jpg'
                  ),
                ),
              const SizedBox(height: 55),

              //Seja Bem Vindo!
              Text(
                'Wellcome!',
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Type your name and password to regiter!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 50),

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
                    child: TextField(
                      controller: controllerNome,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

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
                    child: TextField(
                      controller: controllerUsuario,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              //Campo Senha2
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
                    child: TextField(
                      controller: controllerSenha,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              //Botão login
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      OutlinedButton(
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.blue,
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        onPressed: cadastrar,
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              //Já tem cadastro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have registration? ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                      onPressed: (() => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()))),
                      child: const Text(
                        "login now",
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
