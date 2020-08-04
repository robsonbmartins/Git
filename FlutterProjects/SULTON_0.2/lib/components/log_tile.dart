//import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/log.dart';
import 'package:flutter_crud/models/log.dart';
import 'package:flutter_crud/provider/logs.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';
//import 'package:http/http.dart' as http;

class LOGTile extends StatelessWidget {
  //Tile = Tijolo

  //static const _baseUrl = "https://dev-sulton.firebaseio.com/";

  final Log log;

  const LOGTile(this.log);

/*
Tentativa
  Future<log> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUsers();
  }
*/

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(log.name),
      subtitle: Text(log.mac),
    ); //ListTile - Tijolo com posições pré definidas
  }
}
