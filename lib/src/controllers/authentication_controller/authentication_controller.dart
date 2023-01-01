import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_health_assistant/src/const_variables.dart';
import 'package:my_health_assistant/src/widgets/snack_bar.dart';

class AuthenticationController {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> createNewAccount(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          log('error');
        }
      }
    }
  }

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar('Not defined');
      }
    }
    return user;
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static Future<void> resetPassword({required String email}) async {
    auth.sendPasswordResetEmail(email: email);
  }

  static Stream<DocumentSnapshot> getAdminAccount() {
    return FirebaseFirestore.instance
        .collection("admin")
        .doc(AdminValues.adminId)
        .snapshots();
  }
}