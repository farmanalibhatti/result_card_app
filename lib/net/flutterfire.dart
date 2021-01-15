import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rc_app/utility/dialog.dart';

Future<bool> signIn(BuildContext context, String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    if (e.code == 'wrong-password') {
      showErrorDialog(context, "Pasword Error!", "Invalid Password!");
    }
    if (e.code == 'user-not-found') {
      showErrorDialog(context, "Pasword Error!", "No user found!");
    }
    print(e);
    print(e.code);
    return false;
  }
}

Future<bool> register(
    BuildContext context, String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("The password provided is too weak.");
      showErrorDialog(
          context, "Pasword Error!", "The password provided is too weak.");
    } else if (e.code == 'email-already-in-use') {
      showErrorDialog(
          context, "Email Error!", "Account already exists for that email!");
      print("Account already exists for that email.");
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

// Add School
Future<bool> addSchool(String schoolName) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Schools")
        .doc(schoolName);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        List<String> keywords = [];
        for (int i = 0; i <= schoolName.length; i++) {
          keywords.add(schoolName.substring(0, i).toLowerCase());
        }
        documentReference.set({'schoolName': schoolName, 'keywords': keywords});
        return true;
      }
      // For updating
      // transaction.update(documentReference, {"schoolName": schoolName});
      return false;
    });
  } catch (e) {
    return false;
  }
}

// Remove school
Future<bool> removeSchool(String schoolName) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Schools")
        .doc(schoolName)
        .delete();
    return true;
  } catch (e) {
    return false;
  }
}
