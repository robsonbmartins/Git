import 'package:flutter/material.dart';
import 'package:flutter_crud/models/users.dart';

class UserTile extends StatelessWidget {
  //Tile = Tijolo

  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null ||
            user.avatarUrl.isEmpty //Inicializa "avatar" conforme expressão
        ? CircleAvatar(
            child: Icon(
                Icons.person)) // Se expressão for verdaderia coloca "Icone"
        : CircleAvatar(
            backgroundImage: NetworkImage(
                user.avatarUrl)); // Se não for faz adiciona imagem URL.

    return ListTile(
        leading: avatar,
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.orange,
                onPressed: () {}, //Função vazia para setar depois
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {},
              )
            ],
          ),
        )); //ListTile - Tijolo com posições pré definidas
  }
}
