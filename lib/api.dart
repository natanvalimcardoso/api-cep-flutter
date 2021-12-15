import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);
  TextEditingController valorController = TextEditingController();
  String resultado = "Seu cep aparecerá aqui";

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
                onPressed: () async {}, child: const Text('Pesquisar')),
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

//////////////////////////////////////////////////////////////////////////////////////////////
Future main() async {
  final todo = await fetch();
  print(todo.cidade);
}

Future<Todo> fetch() async {
  var url = 'https://api.postmon.com.br/v1/cep/95800-000';
  var response = await http.get(Uri.parse(url));
  var json = jsonDecode(response.body);
  var todo = Todo.fromJson(json);
  return todo;
}

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



//valor.valorClasse.toString()

 /*  Future<String> _getCep(String cep) async {

    String cep = valorController.text;
    var url = "https://viacep.com.br/ws/$cep/json/";
    var response = await http.get(Uri.parse(url));
      Map<String, dynamic> dados = json.decode(response.body);
      String logradoura = dados['logradouro'];
      String bairro = dados['bairro'];
      String localidade = dados['localidade'];
      String uf = dados['uf'];
      String endereco = "$logradoura, $bairro - $localidade - $uf";
      return endereco;
  
  } */