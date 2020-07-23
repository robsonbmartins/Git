import 'package:flutter/material.dart';
import 'package:flutter_crud/models/users.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

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
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
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
                    title: Text('Excluir Usuário'),
                    content: Text('Tem certeza?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Não'),
                        //.pop Fecha o Popup ****** essa "=>" é uma aeron function e substitui o {xxxx;}
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      FlatButton(
                        child: Text('Sim'),
                        onPressed: () {
                          Navigator.of(context).pop(true); //.pop Fecha o Popup

                          /*remove o user da lista do provider (DA ERRO SE O LISTEN TIVER REPORTANDO)
                            Como o showDialog é um future ele pode executar uma ação conforme retorno do .pop que anteriormente nem passava nada

                            Provider.of<Users>(context, listen: false)
                                .remove(user);
                            Navigator.of(context).pop(); //.pop Fecha o Popup
                            
                            */
                        },
                      ),
                    ],
                  ),
                ).then(
                  (confirmed) {
                    if (confirmed) {
                      Provider.of<Users>(context, listen: false).remove(user);
                    } //<Users> força a importação pelo generics
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
