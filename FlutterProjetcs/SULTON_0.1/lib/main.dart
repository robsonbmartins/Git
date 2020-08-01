import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/ca.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/ca_form.dart';
import 'package:flutter_crud/views/ca_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
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
      ],
      child: MaterialApp(
        title: 'SULTON APP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        /*HOME SEM ROUTES
        home: CAList(),
        */
        routes: {
          AppRoutes.HOME: (_) =>
              CAList(), //Não passa nenhum (ctx) "contexto" (_) "sem contexto"
          AppRoutes.CA_FORM: (_) =>
              CAForm() //Não passa nenhum (ctx) "contexto" (_) "sem contexto"
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
