import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("The password provided is too weak.");
    } else if (e.code == 'email-already-in-use') {
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
        documentReference.set({'schoolName': schoolName});
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
    print(schoolName);
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
