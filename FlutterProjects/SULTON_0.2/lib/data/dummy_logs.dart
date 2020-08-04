//import 'package:flutter_crud/models/ca.dart';
import 'package:flutter_crud/models/log.dart';

/*
//tentativa de converter GET HTTP em Map Chave/Valor


import 'dart:convert';
import 'package:http/http.dart' as http;

Future<CA> fetchUsers() async {
  const _baseUrl = "https://dev-sulton.firebaseio.com/";

  final response = await http.get("$_baseUrl/users.json");

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CA.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


*/

const DUMMY_LOGS = {
  '1': const Log(
    id: "1",
    name: "Janela",
    mac: "dsfdfsdfsdf",
    codErro: "12",
    sensor1: true,
  ),
  '2': const Log(
    id: "2",
    name: "Janela",
    mac: "dsfdfsdfsdf",
    codErro: "12",
    sensor1: true,
  ),
  '3': const Log(
    id: "3",
    name: "Janela",
    mac: "dsfdfsdfsdf",
    codErro: "12",
    sensor1: true,
  )
};
