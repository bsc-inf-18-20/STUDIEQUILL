// import 'package:flutter/material.dart';
// import 'package:studie/components/SButton';
// import 'package:studie/components/mytexts.dart';

// class SignUp extends StatelessWidget {
//   SignUp({super.key});
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();

//   //signing user in
//   void signUserUp() {}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color.fromARGB(255, 248, 244, 244),
//         body: SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 50),

//                 // //logo
//                 // const Icon(
//                 //   Icons.lock,
//                 //   size: 50,
//                 // ),
//                 // const SizedBox(height: 120),

//                 const Text(
//                   'SIGN UP FOR STUDIE APP ',
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 51, 124, 112),
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 70),

//                 //username
//                 Mytexts(
//                   controller: usernameController,
//                   hintText: 'enter email',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 20),

//                 //password
//                 Mytexts(
//                   controller: passwordController,
//                   hintText: 'enter password',
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 20),
//                 //password
//                 Mytexts(
//                   controller: passwordController,
//                   hintText: 'confirm pass',
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 20),
//                 //sign in button
//                 SButton(
//                   onTap: signUserUp,
//                 ),
//                 const SizedBox(height: 50),
//               ],
//             ),
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:studie/components/SButton';
import 'package:studie/components/mytexts.dart';
import 'package:studie/pages/HomePage.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController =
      TextEditingController(); // Added for confirm password

  //signing user up
  void signUserUp(BuildContext context) {
    // Simple validation example
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showErrorMessage(context, 'Please fill in all fields.');
      return;
    }

    if (password != confirmPassword) {
      showErrorMessage(context, 'Passwords do not match.');
      return;
    }

    // After successful validation or sign-up process, navigate to HomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(), // Navigate to the HomePage
      ),
    );
  }

  // Method to show error messages
  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 244, 244),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            // Added scroll for better small screen support
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                const Text(
                  'SIGN UP FOR STUDIE APP',
                  style: TextStyle(
                    color: Color.fromARGB(255, 51, 124, 112),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 70),

                // Email input
                Mytexts(
                  controller: usernameController,
                  hintText: 'Enter email',
                  obscureText: false,
                ),
                const SizedBox(height: 20),

                // Password input
                Mytexts(
                  controller: passwordController,
                  hintText: 'Enter password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),

                // Confirm password input
                Mytexts(
                  controller: confirmPasswordController, // Separate controller
                  hintText: 'Confirm password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),

                // Sign up button
                SButton(
                  onTap: () =>
                      signUserUp(context), // Pass context for navigation
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
