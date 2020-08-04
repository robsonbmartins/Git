import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/user_form.dart';
import 'package:flutter_crud/views/user_list.dart';
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
          create: (ctx) => Users(), //Aqui esta um provider monitorado
        ),
      ],
      child: MaterialApp(
        title: 'Flutter - App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        /*HOME SEM ROUTES
        home: UserList(),
        */
        routes: {
          AppRoutes.HOME: (_) =>
              UserList(), //Não passa nenhum (ctx) "contexto" (_) "sem contexto"
          AppRoutes.USER_FORM: (_) =>
              UserForm() //Não passa nenhum (ctx) "contexto" (_) "sem contexto"
        },
      ),
    );

    /* Monitora apenas um Provider de Users ---- 
    return ChangeNotifierProvider( //Esta classe monitora mudanças que ocorrem no "ChangeNotifier"
      create: (ctx) => Users(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: UserList(),
      ),
    );
    */
  }
}
