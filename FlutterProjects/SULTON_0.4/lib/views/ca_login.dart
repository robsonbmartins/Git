import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../provider/login.dart';
import 'dart:async';

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
          print(userid);
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        }).catchError((onError) {
          onSignedInError();
        });
        widget.onSignedIn();
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
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Login'),
          leading: new FlatButton(
            child: new Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: _voltar,
          ),
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
    showDialog(context: context, child: alert);
    widget.onSignedOut();
  }
}
