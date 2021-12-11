import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future main() async {
  final todo = await fetch();
  print(todo.cidade);
}

Future<Todo> fetch() async {
  var cepDigitado = "95572000";
  var url = 'https://api.postmon.com.br/v1/cep/$cepDigitado';
  var response = await http.get(Uri.parse(url));
  var json = jsonDecode(response.body);
  var todo = Todo.fromJson(json);
  return todo;
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

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Verificador de Cep',
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [Text('Calculadora')],
        ),
      ),
    );
  }
}
