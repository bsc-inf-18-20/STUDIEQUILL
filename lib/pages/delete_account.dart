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

      // Delete the user account
      await user.delete();

      // Navigate to login or home page after deletion
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account: $e')),
      );
    }
  }
}
