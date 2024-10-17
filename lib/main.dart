// import 'package:flutter/material.dart';
// import 'package:studie/pages/Login_Page.dart';
// import 'package:studie/pages/Sign_Up.dart';
// // import 'pages/LoginPage.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login App',

//       home: LoginPage(),
//       routes: {
//         '/signup': (context) => SignUp(),
//       },

//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // home: LoginPage(), // Use LoginPage as home
//     );
//   }
// }

// main.dart
import 'package:flutter/material.dart';
import 'package:studie/pages/HomePage.dart';
// import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(), // Default light theme
      darkTheme: ThemeData.dark(), // Dark theme
      home: const HomePage(), // Main app entry point
    );
  }
}
