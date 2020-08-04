import 'dart:async';
import 'dart:convert';
//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_cas.dart';
import 'package:flutter_crud/models/cas.dart';
import 'package:http/http.dart' as http;

class CAS with ChangeNotifier {
  static const _baseUrl = "https://dev-sulton.firebaseio.com/";

  final Map<String, CA> _items = {...DUMMY_CAS};

  List<CA> get all {
    return [
      ..._items.values
    ]; //retorna clone dos dados através do operador "..." spread
  }

  int get count {
    return _items.length;
  } //retorna a quantidade de items

  CA byIndex(int i) {
    return _items.values.elementAt(i);
  }

  //ALTERA OU ADICIONA
  //void put(CA ca) { //Foi adicionado o metodo "async" que permite gravação assincrona na database
  Future<void> put(CA ca) async {
    if (ca == null) {
      return;
    }
    //altera --- Este IF verifica se o ID já existe, caso exita ele edita, caso contrario ele adiciona
    if (ca.id != null && ca.id.trim().isNotEmpty && _items.containsKey(ca.id)) {
      //ATUALIZA ---------- cria uma string e envia via post na tabela cas.json do firebase
      final response = await http.patch(
        "$_baseUrl/cas/${ca.id}.json",
        body: json.encode(
          {
            'name': ca.name,
            'mac': ca.mac,
            'avatarUrl': ca.avatarUrl,
          },
        ),
      );

      //TESTE --- impressão do retorno da requisição do firebase
      //captura o ID da resposta http do firebase
      /*
      final id = json.decode(response.body)['name'];
      print(json.decode(response.body)); 
      */
      // RETORNO ----> {name: -MCy6aM5P2EZtSR8eDih}

      _items.update(
        ca.id,
        (_) => CA(
          id: ca.id,
          name: ca.name,
          mac: ca.mac,
          avatarUrl: ca.avatarUrl,
        ),
      );
    } else {
      //ADICIONA -----------cria uma string e envia via post na tabela cas.json do firebase
      final response = await http.post(
        "$_baseUrl/cas.json",
        body: json.encode({
          'name': ca.name,
          'mac': ca.mac,
          'avatarUrl': ca.avatarUrl,
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
        () => CA(
          id: id,
          name: ca.name,
          mac: ca.mac,
          avatarUrl: ca.avatarUrl,
        ),
      );
    }

    notifyListeners(); //atualiza tela - provider notificado
  }

  //remove o usuario
  void remove(CA ca) {
    if (ca != null && ca.id != null) {
      _items.remove(ca.id);
      notifyListeners();
    }
  }
}
