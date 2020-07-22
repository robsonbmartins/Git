import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
//import 'package:flutter_crud/models/users.dart';
/* Substituido a partir do momento que se passou a ustilizar o provider
import 'package:flutter_crud/data/dummy_users.dart';
*/
import 'package:provider/provider.dart';
import 'package:flutter_crud/provider/users.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
/* Substituido a partir do momento que se passou a ustilizar o provider
    final users = {...DUMMY_USERS}; //operador spred ...
*/
    final Users users = Provider.of(context);
    //final Users users = Provider.of(context, listen: false);//Não notifica esta interface listen: false

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Usuários"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                /* SIMULACAO DE INCERÇÃO FIXA
                users.put(User(
                  name: "Roberto",
                  email: "cabe@gmail.com",
                  avatarUrl: null,
                ));
                */
              })
        ],
      ),
      body: ListView.builder(
          itemCount: users.count,
          // itemBuilder: (ctx, i) => Text(users.values.elementAt(i).name)), //Exibe o nome do usuário pelo indice
          itemBuilder: (ctx, i) => UserTile(users.byIndex(i))),
    );
  }
}
