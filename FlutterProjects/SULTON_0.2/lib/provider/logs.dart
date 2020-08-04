import 'dart:async';
//import 'dart:convert';
//import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_logs.dart';
import 'package:flutter_crud/models/log.dart';
//import 'package:http/http.dart' as http;

class Logs with ChangeNotifier {
  //static const _baseUrl = "https://dev-sulton.firebaseio.com/";
  final db = Firestore.instance;

  final Map<String, Log> _items = {...DUMMY_LOGS};

  List<Log> get all {
    return [
      ..._items.values
    ]; //retorna clone dos dados através do operador "..." spread
  }

  int get count {
    return _items.length;
  } //retorna a quantidade de items

  Log byIndex(int i) {
    return _items.values.elementAt(i);
  }

  //ALTERA OU ADICIONA
  //void put(log log) { //Foi adicionado o metodo "async" que permite gravação assincrona na database
  /*
  Future<void> put(Log log) async {
    if (log == null) {
      return;
    }
    //altera --- Este IF verifilog se o ID já existe, Logso exita ele edita, Logso contrario ele adiciona
    if (log.mac != null &&
        log.mac.trim().isNotEmpty &&
        _items.containsKey(log.mac)) {
      //ATUALIZA ---------- cria uma string e envia via post na tabela Logs.json do firebase

      final response = await db
          .collection("device-configs")
          .document("log-${log.mac}")
          .setData({
        "id": log.id,
        "name": log.name,
        "mac": log.mac,
        "codErro": log.codErro,
        "sensor1": log.sensor1,
      });
/*
      final response = await http.patch(
        "$_baseUrl/Logs/${log.id}.json",
        body: json.encode(
          {
            'name': log.name,
            'mac': log.mac,
            'avatarUrl': log.avatarUrl,
            'enable': log.enable,
          },
        ),
      );
*/
      //TESTE --- impressão do retorno da requisição do firebase
      //logptura o ID da resposta http do firebase
      /*
      final id = json.decode(response.body)['name'];
      print(json.decode(response.body)); 
      */
      // RETORNO ----> {name: -MCy6aM5P2EZtSR8eDih}

      _items.update(
        log.mac,
        (_) => Log(
          id: log.id,
          name: log.name,
          mac: log.mac,
          codErro: log.codErro,
          sensor1: log.sensor1,
        ),
      );

      notifyListeners();
    } else {
      //ADICIONA -----------cria uma string e envia via post na tabela Logs.json do firebase
      /*final response = await http.post(
        "$_baseUrl/Logs.json",
        body: json.encode({
          'name': log.name,
          'mac': log.mac,
          'avatarUrl': log.avatarUrl,
          'enable': log.enable,
        }),
      );*/

      final response = await db
          .collection("device-configs")
          .document("log-${log.mac}")
          .setData({
        "id": log.id,
        "name": log.name,
        "mac": log.mac,
        "codErro": log.codErro,
        "sensor1": log.sensor1,
      });

      //logptura o ID da resposta http do firebase
      //final mac = log.mac;

      //Teste --- impressão do retorno da requisição do firebase
      //  print(json
      //      .decode(response.body)); // RETORNO ----> {name: -MCy6aM5P2EZtSR8eDih}

      //NAO GERA MAIS ALEATORIAMENTO O ID
      //final id = Random().nextDouble().toString();
      //Gera um ID randomico via "import 'dart:math';"

      _items.putIfAbsent(
        log.mac,
        () => Log(
          id: log.id,
          name: log.name,
          mac: log.mac,
          codErro: log.codErro,
          sensor1: log.sensor1,
        ),
      );
    }

    notifyListeners(); //atualiza tela - provider notifilogdo
  }
*/
  //remove o usuario
  void remove(Log log) {
    if (log != null && log.mac != null) {
      _items.remove(log.mac);
      notifyListeners();
    }
  }
}
