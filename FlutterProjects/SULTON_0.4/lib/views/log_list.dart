import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/components/log_tile.dart';
import 'package:flutter_crud/models/log.dart';
import 'package:flutter_crud/provider/logs.dart';
import 'package:provider/provider.dart';

class CALogs extends StatelessWidget {
  /*
  var db = Firestore.instance;

  StreamSubscription<QuerySnapshot> logInscricao;

  @override
  void initState() {
    super.initState();
  }
*/
  @override
  Widget build(BuildContext context) {
    final Logs log = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Logs"),
        actions: <Widget>[],
      ),
      body: ListView.builder(
        itemCount: log.count,
        // itemBuilder: (ctx, i) => Text(ca.values.elementAt(i).name)), //Exibe o nome do usuário pelo indice
        itemBuilder: (ctx, i) => LOGTile(log.byIndex(i)),
      ),
    );
  }
}
