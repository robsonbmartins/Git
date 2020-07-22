import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
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
        home: UserList(),
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
