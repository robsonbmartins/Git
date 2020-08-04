import 'package:flutter_crud/models/cas.dart';

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

const DUMMY_CAS = {
  '1': const CA(
      id: "1", name: "Robson", mac: "robson@gmai.com", avatarUrl: null),
  '2': const CA(
      id: "2",
      name: "Guilherme",
      mac: "guilherme@gmai.com",
      avatarUrl:
          "https://img.favpng.com/3/3/25/computer-icons-user-material-design-business-login-png-favpng-XtCyNJTCfVkwab47dcf7ErQuX.jpg"),
  '3': const CA(
      id: "3", name: "Marcelo", mac: "marcelo@gmai.com", avatarUrl: null)
};
