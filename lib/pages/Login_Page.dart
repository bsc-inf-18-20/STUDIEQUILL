import 'package:flutter/material.dart';
import 'package:studie/components/my_button.dart';
import 'package:studie/components/mytexts.dart';
import 'package:studie/components/squar_tile.dart';
import 'package:studie/pages/HomePage.dart';
// import 'package:studie/pages/HomePage.dart';
import 'package:studie/pages/Sign_Up.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  // Signing user in
  void signUserIn(BuildContext context) {
    // For now, i will assume sign-in is successful and navigate to HomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          isDarkMode: false, // Pass initial dark mode state
          onThemeChange: (bool value) {
            // Handle theme changes if necessary
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 244, 244),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // SquarTile(
              //   imagePath: 'lib/images/lock.png',
              // ),
              // SizedBox(width: 25),

              // // logo
              const Icon(
                Icons.mic,
                size: 100,
              ),
              const SizedBox(height: 50),

              // welcome
              const Text(
                'STUDIE APP ',
                style: TextStyle(
                  color: Color.fromARGB(255, 51, 124, 112),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),

              // username
              Mytexts(
                controller: usernameController,
                hintText: 'Enter username',
                obscureText: false,
              ),
              const SizedBox(height: 10),

              // password
              Mytexts(
                controller: passwordController,
                hintText: 'Enter password',
                obscureText: true,
              ),

              // forgot password
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 124, 112),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: () => signUserIn(context), // Call signUserIn
              ),
              const SizedBox(height: 50),

              // continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // google or apple buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquarTile(imagePath: 'lib/images/google.png'),

                  SizedBox(width: 25),

                  // apple button
                  SquarTile(imagePath: 'lib/images/apple.png'),
                ],
              ),

              const SizedBox(height: 50),

              // not a member?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a Member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),

                  // register now
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
