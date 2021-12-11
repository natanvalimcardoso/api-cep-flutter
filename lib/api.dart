import 'dart:convert';
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
