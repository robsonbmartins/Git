import 'dart:async';
//import 'dart:convert';
//import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_cas.dart';
import 'package:flutter_crud/models/ca.dart';
//import 'package:http/http.dart' as http;

class CAS with ChangeNotifier {
  //static const _baseUrl = "https://dev-sulton.firebaseio.com/";
  final db = Firestore.instance;

  Map<String, CA> _items;

  List<CA> get all {
    db
        .collection('')
        .where('userId', isEqualTo: '')
        .getDocuments()
        .then((value) => value.documents.map((e) => print(e)));

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
    if (ca.mac != null && ca.mac.trim().isNotEmpty) {
      //ATUALIZA ---------- cria uma string e envia via post na tabela cas.json do firebase

      final response = await db
          .collection("device-configs")
          .document("CA-${ca.mac}")
          .setData({
        "name": ca.name,
        "mac": ca.mac,
        "avatarUrl": ca.avatarUrl,
        "enable": ca.enable,
      }, merge: true);
/*
      final response = await http.patch(
        "$_baseUrl/cas/${ca.id}.json",
        body: json.encode(
          {
            'name': ca.name,
            'mac': ca.mac,
            'avatarUrl': ca.avatarUrl,
            'enable': ca.enable,
          },
        ),
      );
*/
      //TESTE --- impressão do retorno da requisição do firebase
      //captura o ID da resposta http do firebase
      /*
      final id = json.decode(response.body)['name'];
      print(json.decode(response.body)); 
    
      // RETORNO ----> {name: -MCy6aM5P2EZtSR8eDih}

      _items.update(
        ca.mac,
        (_) => CA(
          id: ca.id,
          name: ca.name,
          mac: ca.mac,
          avatarUrl: ca.avatarUrl,
          enable: ca.enable,
        ),
      );
  */
      notifyListeners();
    } else {
      //ADICIONA -----------cria uma string e envia via post na tabela cas.json do firebase
      /*final response = await http.post(
        "$_baseUrl/cas.json",
        body: json.encode({
          'name': ca.name,
          'mac': ca.mac,
          'avatarUrl': ca.avatarUrl,
          'enable': ca.enable,
        }),
      );*/

      final response = await db
          .collection("device-configs")
          .document("CA-${ca.mac}")
          .setData({
        "name": ca.name,
        "mac": ca.mac,
        "avatarUrl": ca.avatarUrl,
        "enable": ca.enable,
      }, merge: true);

      //captura o ID da resposta http do firebase
      //final mac = ca.mac;

      //Teste --- impressão do retorno da requisição do firebase
      //  print(json
      //      .decode(response.body)); // RETORNO ----> {name: -MCy6aM5P2EZtSR8eDih}

      //NAO GERA MAIS ALEATORIAMENTO O ID
      //final id = Random().nextDouble().toString();
      //Gera um ID randomico via "import 'dart:math';"

      /* _items.putIfAbsent(
        ca.mac,
      () => CA(
          id: ca.id,
          name: ca.name,
          mac: ca.mac,
          avatarUrl: ca.avatarUrl,
          enable: ca.enable,
        ),
      );
      */
    }

    notifyListeners(); //atualiza tela - provider notificado
  }

  //remove o usuario
  void remove(CA ca) {
    if (ca != null && ca.mac != null) {
      _items.remove(ca.mac);
      notifyListeners();
    }
  }
}
