import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String email = ''; // Variable to store the email
String name = ''; // Variable to store the name
String password = ''; // Variable to store the password

class AuthServices {
  static final _firebaseAuth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  Future<String> getUserID() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final String userId = user?.uid ?? '';
    return userId;
  }

  static Future<String> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "Something went wrong";
    try {
      UserCredential _cred = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      _firestore.collection('users').doc(_cred.user!.uid).set({
        "name": name,
        "email": email,
        "password": password,
      });
      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  static Future<String> login(
      {required String email, required String password}) async {
    String res = "Something went wrong";
    try {
      UserCredential _cred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  static Future<List> getUser() async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      if (doc.data() != null) {
        String name = doc.data()!["name"];
        String email = doc.data()!["email"];

        return ["success", name, email];
      }
    } catch (e) {
      return [e.toString()];
    }
    return ["failed"];
  }
}
