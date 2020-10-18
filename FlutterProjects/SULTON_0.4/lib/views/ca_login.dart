import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../provider/login.dart';

class CALogin extends StatefulWidget {
  CALogin({this.auth, this.onSignedIn, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  final VoidCallback onSignedOut;
  State<StatefulWidget> createState() => new _LoginState();
}

class _LoginState extends State<CALogin> {
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _senha;
  bool usuario = false;

  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      if (Platform.isAndroid) {
        _fcm.requestNotificationPermissions();
        _fcm.configure(onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: ListTile(
                title: Text(message['notification']['title']),
                subtitle: Text(message['notification']['body']),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
          return;
        }, onBackgroundMessage: (Map<String, dynamic> message) async {
          print("onBackgroundMessage: $message");
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: ListTile(
                title: Text(message['notification']['title']),
                subtitle: Text(message['notification']['body']),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
          return;
        }, onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          //_navigateToItemDetail(message);
          return;
        }, onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          //_navigateToItemDetail(message);
          return;
        });
      }
    });
  }

  Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        setState(() {
          usuario = true;
        });
        await widget.auth.signInEmailSenha(_email, _senha).then((userid) async {
          setState(() {
            usuario = false;
          });
          var user = await widget.auth.usuarioAtual();
          String fcmToken = await _fcm.getToken();

          _db.collection('users').document(user.uid).setData({
            'token': fcmToken,
            'createdAt': FieldValue.serverTimestamp(), // optional
            'platform': Platform.operatingSystem // optional
          }, merge: true);
          Navigator.of(context).pushNamed('home', arguments: user);
        }).catchError((onError) {
          onSignedInError();
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void _voltar() {
    widget.onSignedOut();
    Navigator.maybePop(context);
  }

  Widget build(BuildContext context) {
    widget.auth.usuarioAtual().then((user) async {
      if (user != null) {
        Navigator.of(context).pushNamed('home', arguments: user);
      }
    });
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Login'),
        ),
        body: ModalProgressHUD(
          child: new Container(
            padding: new EdgeInsets.all(20.0),
            child: new Form(
              key: formKey,
              child: new ListView(shrinkWrap: true, children: <Widget>[
                _sizedBox(50.0),
                // _logo(),
                _sizedBox(100.0),
                _buildEmailInput(),
                _sizedBox(15.0),
                _buildSenhaInput(),
                _sizedBox(30.0),
                _buildSubmitButtons(),
              ]),
            ),
          ),
          inAsyncCall: usuario,
        ));
  }

  Widget _logo() {
    return new Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/avatar.jpg'),
      ),
    );
  }

  Widget _buildEmailInput() {
    return new TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: new InputDecoration(
          hintText: 'Email',
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          )),
      validator: (value) =>
          value.isEmpty ? 'Email não pode estar vazio.' : null,
      onSaved: (value) => _email = value,
    );
  }

  Widget _buildSenhaInput() {
    return new TextFormField(
      obscureText: true,
      autofocus: false,
      decoration: new InputDecoration(
          hintText: 'Senha',
          icon: new Icon(
            Icons.lock,
            color: Colors.grey,
          )),
      validator: (value) =>
          value.isEmpty ? 'Senha não pode estar vazia.' : null,
      onSaved: (value) => _senha = value,
    );
  }

  Widget _sizedBox(_height) {
    return new SizedBox(height: _height);
  }

  Widget _buildSubmitButtons() {
    return new Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: new Material(
            borderRadius: BorderRadius.circular(30.0),
            shadowColor: Colors.lightGreenAccent.shade100,
            elevation: 15.0,
            child: new MaterialButton(
              minWidth: 200.0,
              height: 50.0,
              color: Colors.green,
              child: new Text('Login',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: validateAndSubmit,
            )));
  }

  void onSignedInError() {
    var alert = new AlertDialog(
      title: new Text("Erro ao entrar"),
      content: new Text("Verifique suas credenciais e tente novamente."),
    );
    setState(() {
      usuario = false;
    });
    showDialog(context: context, child: alert);
    //widget.onSignedOut();
  }
}
