// import 'package:flutter/material.dart';
// import 'package:studie/components/MyTexts.dart';
// import 'package:studie/components/SButton';
// import 'package:studie/pages/Login_Page.dart';
// // import 'package:studie/pages/Login_Page.dart';
// // import 'package:studie/pages/Login_Page.dart';

// class SignUp extends StatelessWidget {
//   SignUp({super.key});

//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController =
//       TextEditingController(); // Added for confirm password

//   // Signing user up
//   void signUserUp(BuildContext context) {
//     // Simple validation example
//     final username = usernameController.text.trim();
//     final password = passwordController.text.trim();
//     final confirmPassword = confirmPasswordController.text.trim();

//     if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
//       showErrorMessage(context, 'Please fill in all fields.');
//       return;
//     }

//     if (password != confirmPassword) {
//       showErrorMessage(context, 'Passwords do not match.');
//       return;
//     }

//     // After successful validation or sign-up process, navigate to SignInPage
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LoginPage(), // Navigate to SignInPage
//       ),
//     );
//   }

//   // Method to show error messages
//   void showErrorMessage(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 248, 244, 244),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             // Added scroll for better small screen support
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 50),

//                 const Text(
//                   'SIGN UP FOR STUDIE APP',
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 51, 124, 112),
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 70),

//                 // Email input
//                 Mytexts(
//                   controller: usernameController,
//                   hintText: 'Enter email',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 20),

//                 // Password input
//                 Mytexts(
//                   controller: passwordController,
//                   hintText: 'Enter password',
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 20),

//                 // Confirm password input
//                 Mytexts(
//                   controller: confirmPasswordController, // Separate controller
//                   hintText: 'Confirm password',
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 20),

//                 // Sign up button
//                 SButton(
//                   onTap: () =>
//                       signUserUp(context), // Pass context for navigation
//                 ),
//                 const SizedBox(height: 50),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:studie/components/MyTexts.dart';
import 'package:studie/components/SButton';
import 'package:studie/pages/Login_Page.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController =
      TextEditingController(); // Added for confirm password

  // Signing user up
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

    // After successful validation or sign-up process, navigate to SignInPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(), // Navigate to SignInPage
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
                  icon: Icons.email, // Added email icon
                ),
                const SizedBox(height: 20),

                // Password input
                Mytexts(
                  controller: passwordController,
                  hintText: 'Enter password',
                  obscureText: true,
                  icon: Icons.lock, // Added lock icon
                ),
                const SizedBox(height: 20),

                // Confirm password input
                Mytexts(
                  controller: confirmPasswordController, // Separate controller
                  hintText: 'Confirm password',
                  obscureText: true,
                  icon: Icons.lock, // Added lock icon
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
