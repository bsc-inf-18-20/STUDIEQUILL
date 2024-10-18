import 'package:flutter/material.dart';
import 'package:studie/pages/Login_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // Global state for theme mode

  // Method to toggle theme
  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: _isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light, // Switch based on state
      home: LoginPage(), // Set LoginPage as the initial screen
    );
  }
}
