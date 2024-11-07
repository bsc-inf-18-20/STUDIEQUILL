import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> deleteAccount(BuildContext context) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      // Optionally, delete user data from Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();
      print("User data deleted from Firestore.");

      // Delete the user account
      await user.delete();
      print("User account deleted.");

      // Sign out the user after deletion
      await FirebaseAuth.instance.signOut();
      print("User signed out.");

      // Navigate to login or home page after deletion
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      // Print out the error for debugging
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account: $e')),
      );
    }
  } else {
    print("No user is currently signed in.");
  }
}



// rules_version = '2';

// service cloud.firestore {
//   match /databases/{database}/documents {
//     match /{document=**} {
//       allow read, write: if false;
//     }
//   }
// }