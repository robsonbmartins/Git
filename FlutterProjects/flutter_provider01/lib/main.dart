import 'package:flutter/material.dart';
import 'package:flutter_provider01/heroes_controler.dart';
import 'package:flutter_provider01/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HeroesControler>.value(
          value: HeroesControler(),
        )
        //<HeroesControler> permite recuperar os valores "tipando"
        //"extends ChangeNotifier" ------ permite notificar a tela das alterações do provider

        /* *********** porem é necessario usar um tipo especifico de "provider" ----- "ChangeNofifierProvider"       
        Provider<HeroesControler>.value(
          value: HeroesControler(),
        ) 
        */
      ],
      child: MaterialApp(
        title: 'Flutter Provider',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
