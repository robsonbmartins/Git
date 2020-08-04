import 'package:flutter_crud/models/users.dart';

/*
//tentativa de converter GET HTTP em Map Chave/Valor


import 'dart:convert';
import 'package:http/http.dart' as http;

Future<User> fetchUsers() async {
  const _baseUrl = "https://dev-sulton.firebaseio.com/";

  final response = await http.get("$_baseUrl/users.json");

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


*/

const DUMMY_USERS = {
  '1': const User(
      id: "1", name: "Robson", email: "robson@gmai.com", avatarUrl: null),
  '2': const User(
      id: "2",
      name: "Guilherme",
      email: "guilherme@gmai.com",
      avatarUrl:
          "https://img.favpng.com/3/3/25/computer-icons-user-material-design-business-login-png-favpng-XtCyNJTCfVkwab47dcf7ErQuX.jpg"),
  '3': const User(
      id: "3", name: "Marcelo", email: "marcelo@gmai.com", avatarUrl: null)
};
