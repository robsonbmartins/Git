import 'package:flutter/material.dart';
import 'package:flutter_crud/components/ca_tile.dart';
import 'package:flutter_crud/routes/app_routes.dart';
/* 
Substituido a partir do momento que se passou a ustilizar o provider
import 'package:flutter_crud/data/dummy_users.dart';
*/
import 'package:provider/provider.dart';
import 'package:flutter_crud/provider/cas.dart';

class CAList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
/*  
    Substituido a partir do momento que se passou a ustilizar o provider
    final ca = {...DUMMY_USERS}; //operador spred ...
*/
    final CAS ca = Provider.of(context);
    //final CA ca = Provider.of(context, listen: false);//Não notifica esta interface listen: false

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista Centrais de Alarme"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes
                    .CA_FORM); //Coloca a nova tela acima da tela anterior

                /* SIMULACAO DE EDICAO - Passando User com mesmo ID para via ca.put
                ca.put(
                  User(
                    id: '2',
                    name: "Roberto",
                    email: "cabe@gmail.com",
                    avatarUrl: null,
                  ),
                );
                */

                /* SIMULACAO DE REMOÇÃO
                ca.remove(ca.byIndex(0));
                */

                /* SIMULACAO DE INCERÇÃO FIXA
                ca.put(User(
                  name: "Roberto",
                  email: "cabe@gmail.com",
                  avatarUrl: null,
                ));
                */
              })
        ],
      ),
      body: ListView.builder(
        itemCount: ca.count,
        // itemBuilder: (ctx, i) => Text(ca.values.elementAt(i).name)), //Exibe o nome do usuário pelo indice
        itemBuilder: (ctx, i) => CATile(ca.byIndex(i)),
      ),
    );
  }
}
