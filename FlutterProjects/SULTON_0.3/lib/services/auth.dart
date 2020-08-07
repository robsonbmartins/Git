import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  Uninitialized,
  Authenticated,
  Authenticating, //enquanto esta carregando a sessão
  Unauthenticated
}

class AuthService with ChangeNotifier {
  final authService = Provider.of<AuthService>(context);

  static BuildContext context;
  final FirebaseAuth _auth;
  GoogleSignInAccount _googleUser;
  User _user = new User();

  final Firestore _db = Firestore.instance;
  AuthStatus _status = AuthStatus.Uninitialized;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

//Monitora alteração da autenticação atualizando o statos
  AuthService.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser = null) {
      _status = AuthStatus.Unauthenticated;
    } else {
      DocumentSnapshot userSnap =
          await _db.collection('users').document(firebaseUser.uid).get();
      _user.setFromFirestore(userSnap); //Carrega usuário no Firestore
      _status = AuthStatus.Authenticated; //Atualiza o status do usuário
    }
    notifyListeners();
  }

  Future<FirebaseUser> googleSignIn() async {
    _status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      GoogleSignInAccount googleUser = await _googleSignIn
          .signIn(); //Popup Para escolher usuário que irá iniciar a sessão
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      this._googleUser = googleUser;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      AuthResult authResult = await _auth.signInWithCredential(credential);

      FirebaseUser user = authResult.user;

      await updateUserData(user);
    } catch (e) {
      _status = AuthStatus.Uninitialized;
      notifyListeners();
      return null;
    }
  }

  Future<DocumentSnapshot> updateUserData(FirebaseUser user) async {
    DocumentReference userRef = _db.collection("users").document(user.uid);
    userRef.setData({
      'uid': user.uid,
      'email': user.email,
      'lastSign': DateTime.now(),
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
    }, merge: true);

    DocumentSnapshot userData = await userRef.get();

    return userData;
  }

  void signOut() {
    _auth.signOut();
    _status = AuthStatus.Authenticated;
    notifyListeners();
  }

  AuthStatus get status => _status;
  User get user => _user;
  GoogleSignInAccount get googleUser => _googleUser;
}
