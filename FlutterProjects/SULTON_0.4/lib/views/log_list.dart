import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/components/log_tile.dart';
import 'package:flutter_crud/models/log.dart';
import 'package:flutter_crud/provider/logs.dart';
import 'package:provider/provider.dart';

import '../models/ca.dart';
import '../models/log.dart';

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
    CA ca = ModalRoute.of(context).settings.arguments;
    var logs = Firestore.instance.collection('logs').document(ca.id).get();
    var events = Firestore.instance
        .collection('logs')
        .document(ca.id)
        .collection('events');
    return Scaffold(
        appBar: AppBar(
          title: Text("Logs"),
          actions: <Widget>[],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: events.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                print(document.data);
                var data = Log(
                    id: document.documentID,
                    mac: document.data['mac'],
                    name: document.data['name'],
                    codErro: document.data['codErro'],
                    sensor1: document.data['sensor1']);
                return LOGTile(data);
              }).toList(),
            );
          },
        ));
  }
}
