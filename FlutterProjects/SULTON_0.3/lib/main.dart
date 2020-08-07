import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/Auths.dart';
import 'package:flutter_crud/provider/cas.dart';
import 'package:flutter_crud/provider/logs.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/services/auth.dart';
import 'package:flutter_crud/views/auth_user.dart';
import 'package:flutter_crud/views/auth_user.dart';
import 'package:flutter_crud/views/ca_form.dart';
import 'package:flutter_crud/views/ca_list.dart';
import 'package:flutter_crud/views/log_list.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(
          create: (_) => Auths(), //Aqui esta um provider monitorado
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SULTON APP',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        /*HOME SEM ROUTES
        home: CAList(),


          AppRoutes.HOME: (_) => //CAList(),
              (),
          AppRoutes.AUTH_USER: (_) => //CAList(),
              AUTHUser(), //Não passa nenhum (ctx) "contexto" (_) "sem contexto"
          AppRoutes.CA_LIST: (_) =>
              CAList(), //Não passa nenhum (ctx) "contexto" (_) "sem contexto"
          AppRoutes.CA_FORM: (_) =>
              CAForm(), //Não passa nenhum (ctx) "contexto" (_) "sem contexto"
          AppRoutes.CA_LOGS: (_) =>
              CALogs() //Não passa nenhum (ctx) "contexto" (_) "sem contexto"
  }

        */
        routes: {},
        initialRoute: '/',
        home: Consumer(
          builder: (context, authService, _) {
            switch (authService.status) {
              case AuthStatus.Uninitialized:
                return Text('Carregando');
              case AuthStatus.Authenticated:
                return MyApp();
              case AuthStatus.Authenticating:
                return AUTHUser();
              case AuthStatus.Unauthenticated:
                return AUTHUser();
            }
            return null;
          },
        ),
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
