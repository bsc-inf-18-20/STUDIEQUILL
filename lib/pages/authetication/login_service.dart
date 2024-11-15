// import 'package:firebase_auth/firebase_auth.dart';

// class LoginService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<String?> login(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return null; // No error
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         return 'No user found for that email.';
//       } else if (e.code == 'wrong-password') {
//         return 'Wrong password provided for that user.';
//       }
//       return 'An error occurred, please try again';
//     }
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  final FirebaseAuth _firebaseAuth;

  LoginService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<String?> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return 'An error occurred, please try again';
    }
  }
}
