import 'package:flutter/material.dart';
import 'package:studie/main.dart';
import 'package:studie/pages/Login_Page.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Language',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 103, 58, 182),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Set locale to English and navigate to login page
                _setLocale(context, const Locale('en', ''));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 103, 58, 182),
              ),
              child: const Text(
                'English',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Set locale to Chichewa and navigate to login page
                _setLocale(context, const Locale('ny', ''));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 103, 58, 182),
              ),
              child: const Text(
                'Chichewa',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setLocale(BuildContext context, Locale locale) {
    // Change the locale of the app and navigate to the Login page
    MyApp.setLocale(context, locale); // Set the locale
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
