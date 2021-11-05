import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_bloc_login_example/models/user_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    // ignore: avoid_print
    print("signInWithEmailAndPassword Fonksiyonu Çalıştı");
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      debugPrint("HATA: ${e.toString()}");
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    // ignore: avoid_print
    print("signUpWithEmailAndPassword Fonksiyonu Çalıştı");
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      debugPrint("HATA: ${e.toString()}");
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint("HATA: ${e.toString()}");
    }
  }

  Future signOut() async {
    // ignore: avoid_print
    print("signOut Fonksiyonu Çalıştı");
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint("HATA: ${e.toString()}");
    }
  }
}
