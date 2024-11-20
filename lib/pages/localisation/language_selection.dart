import 'package:flutter/material.dart';
import 'package:studie/main.dart';
import 'package:studie/pages/authetication/Login_Page.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
        backgroundColor: const Color.fromARGB(255, 103, 58, 182),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                MyApp.setLocale(context, const Locale('en', '')); // Set English
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 103, 58, 182),
              ),
              child: const Text('English'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                MyApp.setLocale(
                    context, const Locale('ny', '')); // Set Chichewa
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 103, 58, 182),
              ),
              child: const Text('Chichewa'),
            ),
          ],
        ),
      ),
    );
  }
}
