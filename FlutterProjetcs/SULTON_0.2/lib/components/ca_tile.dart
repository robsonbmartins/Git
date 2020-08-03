//import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/ca.dart';
import 'package:flutter_crud/provider/cas.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';
//import 'package:http/http.dart' as http;

class CATile extends StatelessWidget {
  //Tile = Tijolo

  //static const _baseUrl = "https://dev-sulton.firebaseio.com/";

  final CA ca;

  const CATile(this.ca);

/*
Tentativa
  Future<CA> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUsers();
  }
*/

  @override
  Widget build(BuildContext context) {
    final avatar = ca.avatarUrl == null ||
            ca.avatarUrl.isEmpty //Inicializa "avatar" conforme expressão
        ? CircleAvatar(
            child: Icon(Icons
                .important_devices)) // Se expressão for verdaderia coloca "Icone"
        : CircleAvatar(
            backgroundImage: NetworkImage(
                ca.avatarUrl)); // Se não for faz adiciona imagem URL.

    return ListTile(
      leading: avatar,
      title: Text(ca.name),
      subtitle: Text(ca.mac),
      trailing: Container(
        width: 150,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.library_books),
              color: Colors.lightGreen,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.CA_LOGS,
                  arguments: ca,
                ); //Coloca a nova tela acima da tela anterior
              }, //Função vazia para setar depois
            ),
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.CA_FORM,
                  arguments: ca,
                ); //Coloca a nova tela acima da tela anterior
              }, //Função vazia para setar depois
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir Central'),
                    content: Text('Tem certeza?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Não'),
                        //.pop Fecha o Popup ****** essa "=>" é uma aeron function e substitui o {xxxx;}
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      FlatButton(
                        child: Text('Sim'),
                        // ADICIONADO "async"
                        onPressed: () async {
                          //REMOVE -----------cria uma string e envia via post na tabela users.json do firebase
                          await Firestore.instance
                              .collection("device-configs")
                              .document("CA-${ca.mac}")
                              .delete();

                          // await http.delete("$_baseUrl/cas/${ca.id}.json");

                          Navigator.of(context).pop(true); //.pop Fecha o Popup

                          /*remove o ca da lista do provider (DA ERRO SE O LISTEN TIVER REPORTANDO)
                            Como o showDialog é um future ele pode executar uma ação conforme retorno do .pop que anteriormente nem passava nada

                            Provider.of<CA>(context, listen: false)
                                .remove(ca);
                            Navigator.of(context).pop(); //.pop Fecha o Popup
                            
                            */
                        },
                      ),
                    ],
                  ),
                ).then(
                  (confirmed) {
                    if (confirmed) {
                      Provider.of<CAS>(context, listen: false).remove(ca);
                    } //<CA> força a importação pelo generics
                  },
                );
              },
            ),
          ],
        ),
      ),
    ); //ListTile - Tijolo com posições pré definidas
  }
}
