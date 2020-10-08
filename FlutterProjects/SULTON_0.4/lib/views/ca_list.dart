import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/components/ca_tile.dart';
import 'package:flutter_crud/provider/login.dart';
import 'package:flutter_crud/routes/app_routes.dart';
/* 
Substituido a partir do momento que se passou a ustilizar o provider
import 'package:flutter_crud/data/dummy_users.dart';
*/
import 'package:provider/provider.dart';
import 'package:flutter_crud/provider/cas.dart';

import '../models/ca.dart';

class CAList extends StatelessWidget {
  final BaseAuth auth;

  CAList({this.auth});

  @override
  Widget build(BuildContext context) {
    var user = auth.getUsuario();
/*  
    Substituido a partir do momento que se passou a ustilizar o provider
    final ca = {...DUMMY_USERS}; //operador spred ...
*/
    // if (auth.getUsuario() == null) {
    //   Navigator.of(context).pushNamed(
    //     AppRoutes.CA_LOGIN,
    //     arguments: null,
    //   );
    // }
    final CAS ca = Provider.of(context);
    //final CA ca = Provider.of(context, listen: false);//Não notifica esta interface listen: false
    var cas = Firestore.instance
        .collection('device-configs')
        .where('userId', isEqualTo: '123')
        .getDocuments();
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista Centrais de Alarme"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes
                      .CA_FORM); //Coloca a nova tela acima da tela anterior

                  /* SIMULACAO DE EDICAO - Passando User com mesmo ID para via ca.put
                ca.put(
                  User(
                    id: '2',
                    name: "Roberto",
                    email: "cabe@gmail.com",
                    avatarUrl: null,
                  ),
                );
                */

                  /* SIMULACAO DE REMOÇÃO
                ca.remove(ca.byIndex(0));
                */

                  /* SIMULACAO DE INCERÇÃO FIXA
                ca.put(User(
                  name: "Roberto",
                  email: "cabe@gmail.com",
                  avatarUrl: null,
                ));
                */
                })
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: cas.asStream(),
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
                var data = CA(
                    id: document.documentID,
                    mac: document.data['mac'],
                    name: document.data['name'],
                    avatarUrl: document.data['avatarUrl'],
                    enable: document.data['enable']);
                return CATile(data);
              }).toList(),
            );
          },
        ));
  }
}
