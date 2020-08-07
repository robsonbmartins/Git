import 'package:flutter/material.dart';
import 'package:flutter_crud/services/auth.dart';
import 'package:flutter_crud/views/ca_list.dart';
import 'package:provider/provider.dart';

class AUTHUser extends StatefulWidget {
  AUTHUser({Key key}) : super(key: key);
  @override
  _AUTHUserState createState() => _AUTHUserState();
}

class _AUTHUserState extends State<AUTHUser> {
  @override
  Widget build(context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Inicia con Google'),
          onPressed: () async {
            await authService.googleSignIn();
          },
        ),
      ),
    );
  }
}

/*  
    Substituido a partir do momento que se passou a ustilizar o provider
    final ca = {...DUMMY_USERS}; //operador spred ...
    
    return Consumer(
      builder: (context, AuthService authService, _) {
        switch (authService.status) {
          case AuthStatus.Uninitialized:
            return Text('Carregando');
          case AuthStatus.Authenticated:
            return CAList();
          case AuthStatus.Authenticating:
            return AUTHUser();
          case AuthStatus.Unauthenticated:
            return AUTHUser();
        }
        return null;
      },
    );
*/
//final authService = Provider.of<AuthService>(context);
//final CA ca = Provider.of(context, listen: false);//Não notifica esta interface listen: false
