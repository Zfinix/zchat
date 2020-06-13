import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zchat/models/user_model.dart';

abstract class BaseAuth {
  Future<FirebaseUser> signIn(String email, String password);
  Future<FirebaseUser> signUp(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> signOut(BuildContext context);
  Future<void> resetPassword(String email, BuildContext context);
  Future<UserModel> getUserProfile(String userID);
  createUserProfile(UserModel userModel);
  updateUserProfile(UserModel userModel);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    return user;
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }

  Future<FirebaseUser> deleteAccount() async {
    FirebaseUser user = (await _firebaseAuth.currentUser());
    await user.delete();
    return user;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut(context) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Password Reset"),
              content: new Text("Password Reset Email Sent"),
            ));
    return _firebaseAuth.signOut();
  }

  Future<void> resetPassword(email, context) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Password Reset"),
              content: new Text("Password Reset Email Sent"),
            ));

    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<UserModel> getUserProfile(userID) async {
    var querySnapshot =
        await Firestore.instance.collection("users").document('$userID').get();

    return (querySnapshot.data != null)
        ? UserModel.fromSnapshot(querySnapshot)
        : null;
  }

  createUserProfile(UserModel userModel) async {
    await Firestore.instance.collection("users").document(userModel.userId).setData(userModel.toJson());
  }

  updateUserProfile(UserModel userModel) async {
    await Firestore.instance
        .collection("users")
        .document(userModel.userId)
        .updateData(userModel.toJson());
  }

  void updatePhoto({
    bool isCustomer = false,
    bool isAdmin = false,
    @required String photo,
  }) async {
    FirebaseUser user = await getCurrentUser();

    await Firestore.instance
        .collection( 'users')
        .document('${user.uid}')
        .updateData({'imageUrl': '$photo'});
  }
}
