import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/components/arc_banner_image.dart';
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
  final CA ca;

  bool status = false;
  CALogs({this.ca});
  @override
  Widget build(BuildContext context) {
    final Logs log = Provider.of(context);

    var events = Firestore.instance
        .collection('logs')
        .document(ca.id)
        .collection('events');

    return Scaffold(
      appBar: AppBar(
        title: Text("Logs"),
        actions: <Widget>[],
      ),
      body: StreamBuilder<Map>(
        stream: _buildDataStream(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasError) {
            return Text('Não foi possível carregar registros');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return new ListView(
            children: _buildLogList(
                snapshot.data['events'],
                Theme.of(context).textTheme,
                snapshot.data['log'] != null &&
                    snapshot.data['log']['sensor1']),
          );
        },
      ),
    );
  }

  Stream<Map> _buildDataStream() async* {
    // Stores any partial line from the previous chunk.
    var partial = new Map();

    var events = Firestore.instance
        .collection('logs')
        .document(ca.id)
        .collection('events')
        .getDocuments();

    await events.then((value) {
      print(value.documents);
      partial['events'] = value.documents;
    });

    var log = Firestore.instance.collection('logs').document(ca.id).get();

    await log.then((value) {
      print(value.data);
      partial['log'] = value.data;
    });

    // Add final partial line to output stream, if any.
    yield partial;
  }

  _buildLogList(List<DocumentSnapshot> documents, TextTheme textTheme, active) {
    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ca.name,
          style: textTheme.headline5,
        ),
        Text(
          ca.mac,
          style: textTheme.subtitle2,
        ),
        SizedBox(height: 8.0),
        // RatingInformation(movie),
        // SizedBox(height: 12.0),
        // Row(children: _buildCategoryChips(textTheme)),
      ],
    );

    print(active);

    var header = [
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: ArcBannerImage(ca.avatarUrl),
      ),
      Positioned(
        bottom: 0.0,
        left: 16.0,
        right: 16.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Poster(
            //   movie.posterUrl,
            //   height: 180.0,
            // ),
            CircleAvatar(
              radius: 30.0,
              child: new Icon(
                Icons.emoji_objects_outlined,
                color: Colors.white,
              ),
              backgroundColor: active ? Colors.green : Colors.red,
            ),
            SizedBox(width: 16.0),
            Expanded(child: movieInformation),
          ],
        ),
      ),
    ];
    var tiles = documents.map((DocumentSnapshot document) {
      print(document.data);
      var data = Log(
          id: document.documentID,
          mac: document.data['mac'],
          name: document.data['name'],
          codErro: document.data['codErro'],
          sensor1: document.data['sensor1']);
      return LOGTile(data);
    }).toList();
    return [...header, ...tiles];
  }
}
