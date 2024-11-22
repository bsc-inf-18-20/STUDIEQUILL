import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studie/pages/authetication/Login_Page.dart';
import 'package:studie/pages/home/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    if (kDebugMode) {
      print('Firebase initialization error: $e');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studie APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthStateHandler(), // Authentication state handler
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => HomePage(
              isDarkMode: false,
              onThemeChange: (value) {},
            ),
      },
    );
  }
}

class AuthStateHandler extends StatelessWidget {
  const AuthStateHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // If user is signed in, navigate to HomePage
          return HomePage(
            isDarkMode: false,
            onThemeChange: (value) {},
          );
        } else {
          // If user is not signed in, navigate to LoginPage
          return const LoginPage();
        }
      },
    );
  }
}
