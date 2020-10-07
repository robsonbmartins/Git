import 'package:flutter_crud/models/ca.dart';

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
  '5C-CD-5B-65-C1-D3': const CA(
      id: "1",
      name: "Empresa",
      mac: "5C-CD-5B-65-C1-D3",
      avatarUrl: null,
      enable: false),
  '00-15-5D-E1-45-1D': const CA(
      id: "2",
      name: "Casa da Praia",
      mac: "00-15-5D-E1-45-1D",
      avatarUrl:
          "https://blog.gigasecurity.com.br/wp-content/uploads/2018/11/252360-7-dicas-para-manter-a-seguranca-da-casa-de-praia.jpg"),
  '00-15-5D-E1-45-1B': const CA(
      id: "3", name: "Apartamento", mac: "00-15-5D-E1-45-1B", avatarUrl: null)
};
