// authentication service

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //get instance of the auth
  final _auth = FirebaseAuth.instance;

  //get current user and uid
  User? getCUrrentUser() => _auth.currentUser;
  String getCurrentUid() => _auth.currentUser!.uid;

  //login email and password
  Future<UserCredential> loginEmailPassword(String email, password) async {
    //attempt login
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential;
    }

    //catcha any errors
    on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'auth/invalid-email':
          throw 'Invalid email address.';
        case 'auth/user-not-found':
          throw 'User not found.';
        case 'auth/wrong-password':
          throw 'Incorrect password.';
        default:
          throw 'Authentication failed.';
      }
    }
  }

  //register email and password
  Future<UserCredential> registerEmailPassword(String email, password) async {
    //attempt to register new user
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return userCredential;
    }
    //catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //logout
  Future<void> logout() async {
    await _auth.signOut();
  }
  //delete account
}
