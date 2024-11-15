import 'package:flutter/material.dart';
import 'package:studie/pages/authetication/auth_service.dart';
import 'package:studie/pages/authetication/validation_service.dart';
import 'sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  final AuthService authService;
  final ValidationService validationService;

  const SignUpPage({
    Key? key,
    required this.authService,
    required this.validationService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Account'),
        backgroundColor: const Color.fromARGB(255, 103, 58, 182),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SignUpForm(
            authService: authService,
            validationService: validationService,
          ),
        ),
      ),
    );
  }
}
