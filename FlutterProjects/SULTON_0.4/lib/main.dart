import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/cas.dart';
import 'package:flutter_crud/provider/login.dart';
import 'package:flutter_crud/provider/logs.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/ca_form.dart';
import 'package:flutter_crud/views/ca_list.dart';
import 'package:flutter_crud/views/ca_login.dart';
import 'package:flutter_crud/views/log_list.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());

/*
  var db = Firestore.instance;

  db.collection("device-configs").document("CA-5C-CD-5B-65-C1-D3").setData({
    "id": "1",
    "name": "Robson",
    "mac": "5C-CD-5B-65-C1-D3",
    "avatarUrl": null,
    "enable": false
  });
*/
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //MultiProvider Monitora multiplos providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => CAS(), //Aqui esta um provider monitorado
        ),
        ChangeNotifierProvider(
          create: (ctx) => Logs(), //Aqui esta um provider monitorado
        ),
      ],
      child: MaterialApp(
        title: 'SULTON APP',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        /*HOME SEM ROUTES
        home: CAList(),
        */
        routes: {
          AppRoutes.CA_LOGIN: (_) => CALogin(auth: new Auth()),
          AppRoutes.HOME: (_) => CAList(
                auth: new Auth(),
              ), //Não passa nenhum (ctx) "contexto" (_) "sem contexto"
          AppRoutes.CA_FORM: (_) =>
              CAForm(), //Não passa nenhum (ctx) "contexto" (_) "sem contexto"
          AppRoutes.CA_LOGS: (_) =>
              CALogs() //Não passa nenhum (ctx) "contexto" (_) "sem contexto"
        },
      ),
    );

    /* Monitora apenas um Provider de CAs ---- 
    return ChangeNotifierProvider( //Esta classe monitora mudanças que ocorrem no "ChangeNotifier"
      create: (ctx) => CAs(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CAList(),
      ),
    );
    */
  }
}
