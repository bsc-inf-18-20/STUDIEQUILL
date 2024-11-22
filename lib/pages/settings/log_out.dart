import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Logs the user out by signing out from Firebase and navigating to the Login page.
Future<void> logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed('/login');
  } catch (e) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout failed: $e')),
    );
  }
}
