import 'package:flutter/material.dart';
import 'package:studie/pages/authetication/auth_service.dart';
import 'package:studie/pages/authetication/validation_service.dart';

class SignUpController {
  final AuthService authService;
  final ValidationService validationService;
  final void Function(String) showSnackbar;
  final VoidCallback navigateToLogin;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  SignUpController({
    required this.authService,
    required this.validationService,
    required this.showSnackbar,
    required this.navigateToLogin,
  });

  Future<void> signUp() async {
    final emailError = validationService.validateEmail(emailController.text);
    final passwordError =
        validationService.validatePassword(passwordController.text);
    final confirmPasswordError = validationService.confirmPassword(
      passwordController.text,
      confirmPasswordController.text,
    );

    if (emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      showSnackbar(emailError ?? passwordError ?? confirmPasswordError!);
      return;
    }

    try {
      final user = await authService.signUpWithEmailPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (user != null) {
        showSnackbar('Account created successfully. Please log in.');
        navigateToLogin();
      }
    } catch (e) {
      showSnackbar(e.toString());
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
