import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/cas.dart';
import 'package:flutter_crud/provider/logs.dart';
import 'package:flutter_crud/routes/app_routes.dart' as router;
import 'package:provider/provider.dart';

void main() {
  runApp(SultonApp());
}

class SultonApp extends StatelessWidget {
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
        onGenerateRoute: router.generateRoute,
        initialRoute: router.AppRoutes.CA_LOGIN,
      ),
    );
  }
}
