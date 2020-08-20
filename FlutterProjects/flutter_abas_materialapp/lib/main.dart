import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, //remove debug banner
        title: "App Simples",
        theme: ThemeData(
          primaryColor: Colors.blue, // appbar e todos os detalhes
          //backgroundColor: Colors.amber,
        ),
        home: new DefaultTabController(
          //antes eu tinha um container aqui
          length: 2,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.yellow,
            ),
            appBar: AppBar(
              title: Text("bora"),
              actions: [
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
              ],
              bottom: TabBar(tabs: <Widget>[
                // para usar o tabbar tem de usar o DefaultTabController
                Tab(
                  icon: Icon(Icons.camera),
                  text: "XXXXXXXXXX",
                ),
                Tab(
                  icon: Icon(Icons.camera),
                ),
              ]),
            ),
            body: TabBarView(children: [
              Center(
                child: Text("texto 1"),
              ),
              Center(
                child: Text("texto 2"),
              ),
            ]),
            drawerScrimColor: Colors.black,
            backgroundColor: Color.fromARGB(120, 34, 233, 33),
          ),
        ));
  }
}
