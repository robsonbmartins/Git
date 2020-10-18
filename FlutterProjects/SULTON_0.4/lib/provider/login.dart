import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signInEmailSenha(String email, String senha);
  Future<String> criarUsuario(String email, String senha);
  Future<FirebaseUser> usuarioAtual();
  FirebaseUser getUsuario();
  Future<void> signOut();
  Future<String> usuarioUid();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseUser usuario;

  FirebaseUser getUsuario() {
    return this.usuario;
  }

  void _setUsuario(FirebaseUser user) {
    this.usuario = user;
  }

  Future<String> signInEmailSenha(String email, String senha) async {
    FirebaseUser user = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((value) => value.user);
    _setUsuario(user);
    return user.uid;
  }

  Future<String> criarUsuario(String email, String senha) async {
    FirebaseUser user = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((value) => value.user);
    return user.uid;
  }

  Future<FirebaseUser> usuarioAtual() async {
    if (usuario != null) {
      return usuario;
    } else {
      FirebaseUser user = await _firebaseAuth.currentUser();
      _setUsuario(user);
      return user;
    }
  }

  Future<String> usuarioUid() async {
    if (usuario != null) {
      return usuario.uid;
    } else {
      FirebaseUser user = await _firebaseAuth.currentUser();
      _setUsuario(user);
      return user.uid;
    }
  }

  Future<void> signOut() async {
    _setUsuario(null);
    return _firebaseAuth.signOut();
  }
}
