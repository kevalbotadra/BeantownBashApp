import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthProvider({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  Future<User?> registerUser({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;

    return userCredential.user;
  }

  Future<User?> registerUserFully(
      {required String name,
      required String email,
      required String password, 
      required String phoneNumber}) async {

        UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;
    
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    User? theUser = _firebaseAuth.currentUser;
    print(theUser?.displayName);
    users.doc(theUser!.uid).set({
      "uid": theUser.uid,
      "email": theUser.email,
      "profilePic": "https://robohash.org/" + theUser.uid,
      "name": name,
      "phoneNumber": phoneNumber,
    });

    return user;
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
