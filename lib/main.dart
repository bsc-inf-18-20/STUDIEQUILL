import 'package:flutter/material.dart';
import 'package:studie/pages/LoginPage.dart';
import 'package:studie/pages/Sign_Up.dart';
// import 'pages/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',

      home: LoginPage(),
      routes: {
        '/signup': (context) => SignUp(),
      },

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LoginPage(), // Use LoginPage as home
    );
  }
}
