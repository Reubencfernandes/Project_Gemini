import 'package:ayumi/entities/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _singleton = AuthService._internal();
  factory AuthService() {
    return _singleton;
  }
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyUser _user = MyUser(
    id: "",
    email: "user@domain.com",
    name: "User",
    photoUrl: "https://via.placeholder.com/150",
  );

  MyUser _mapMyUserFromFirebaseUser(User user) {
    return MyUser(
        id: user.uid,
        email: user.email ?? "user@domain.com",
        name: user.displayName ?? "User",
        photoUrl: user.photoURL ?? "https://via.placeholder.com/150");
  }

  Stream<MyUser?> get authStateChanges =>
      _auth.authStateChanges().map((firebaseUser) {
        if (firebaseUser == null) {
          return null;
        } else {
          _user = _mapMyUserFromFirebaseUser(firebaseUser);
          return _user;
        }
      });

  Future<void> signOut() async {
    return _auth.signOut();
  }

  MyUser getCurrentUser() {
    return _user;
  }

  signInWithGoogle() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(googleAuthProvider);
    } catch (err) {
      // TODO: show error to user
      print(err);
    }
  }
}
