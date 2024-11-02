import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core
import 'package:studie/pages/Login_Page.dart'; // Adjust this import to your actual login page path

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures Flutter is ready before initializing Firebase

  try {
    await Firebase.initializeApp(); // Initialize Firebase
  } catch (e) {
    print('Firebase initialization error: $e'); // Log initialization errors
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studie APP', // Title of the app
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set primary color theme
      ),
      home: const LoginPage(), // Set LoginPage as the initial screen
    );
  }
}
