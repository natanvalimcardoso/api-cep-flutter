import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController valorController = TextEditingController();

  String resultado = "Seu cep aparecerá aqui";

  fetch(String teste) async {
  var url = 'https://api.postmon.com.br/v1/cep/$teste';
  var response = await http.get(Uri.parse(url));
  var json = jsonDecode(response.body);
  var todo = Todo.fromJson(json);
  setState(() {
    resultado = "${todo.cep}\n${todo.cidade}\n${todo.estado}";
  });
}

  //* Widgets //-----------------
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          'Verificador de Cep',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        actions: <Widget>[
          IconButton(
            color: Colors.black,
            icon: const Icon(Icons.refresh),
            onPressed: () {
              valorController.clear();
            },
          )
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Digite o Cep',
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
                onPressed: () {
                  fetch(valorController.text);
                }, child: const Text('Pesquisar')),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(resultado),
          )
        ],
      )),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////95800-000
class ValorController {
  final String? valorClasse;
  ValorController({this.valorClasse});
}

class Todo {
  final String? cidade;
  final String? estado;
  final String cep;

  Todo({this.cidade, this.estado, required this.cep});

  factory Todo.fromJson(Map json) {
    return Todo(
      cep: json['cep'],
      estado: json['estado'],
      cidade: json['cidade'],
    );
  }
}
// *!
// *
// *?
// TODO 
