import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/users.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  static const _baseUrl = "https://dev-sulton.firebaseio.com/";

  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [
      ..._items.values
    ]; //retorna clone dos dados através do operador "..." spread
  }

  int get count {
    return _items.length;
  } //retorna a quantidade de items

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  //void put(User user) { //Foi adicionado o metodo "async" que permite gravação assincrona na database
  Future<void> put(User user) async {
    if (user == null) {
      return;
    }
    //altera
    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      //ATUALIZA ---------- cria uma string e envia via post na tabela users.json do firebase
      final response = await http.patch(
        "$_baseUrl/users/${user.id}.json",
        body: json.encode(
          {
            'name': user.name,
            'email': user.email,
            'avatarUrl': user.avatarUrl,
          },
        ),
      );

      //captura o ID da resposta http do firebase
      final id = json.decode(response.body)['name'];

      //Teste --- impressão do retorno da requisição do firebase
      print(json
          .decode(response.body)); // RETORNO ----> {name: -MCy6aM5P2EZtSR8eDih}

      _items.update(
        user.id,
        (_) => User(
          id: user.id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    } else {
      //adicionar

      //ADICIONA -----------cria uma string e envia via post na tabela users.json do firebase
      final response = await http.post(
        "$_baseUrl/users.json",
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl,
        }),
      );

      //captura o ID da resposta http do firebase
      final id = json.decode(response.body)['name'];

      //Teste --- impressão do retorno da requisição do firebase
      print(json
          .decode(response.body)); // RETORNO ----> {name: -MCy6aM5P2EZtSR8eDih}

      //NAO GERA MAIS ALEATORIAMENTO O ID
      //final id = Random().nextDouble().toString();
      //Gera um ID randomico via "import 'dart:math';"

      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }

    notifyListeners(); //atualiza tela - provider notificado
  }

  //remove o usuario
  void remove(User user) {
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
