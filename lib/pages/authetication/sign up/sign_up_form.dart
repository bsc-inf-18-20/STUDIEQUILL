import 'package:flutter/material.dart';
import 'package:studie/pages/authetication/auth_service.dart';
import 'package:studie/pages/authetication/validation_service.dart';
import 'sign_up_controller.dart';

class SignUpForm extends StatefulWidget {
  final AuthService authService;
  final ValidationService validationService;

  const SignUpForm({
    Key? key,
    required this.authService,
    required this.validationService,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late SignUpController _controller;
  bool _isLoading = false;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _controller = SignUpController(
      authService: widget.authService,
      validationService: widget.validationService,
      showSnackbar: _showSnackbar,
      navigateToLogin: _navigateToLogin,
    );
  }

  Future<void> _signUp() async {
    setState(() => _isLoading = true);
    await _controller.signUp();
    setState(() => _isLoading = false);
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Create an Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 103, 58, 182),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _controller.emailController,
              label: 'Email',
              icon: Icons.email,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _controller.passwordController,
              label: 'Password',
              icon: Icons.lock,
              obscureText: _obscurePassword,
              toggleObscureText: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              hasToggle: true,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _controller.confirmPasswordController,
              label: 'Confirm Password',
              icon: Icons.lock_outline,
              obscureText: _obscureConfirmPassword,
              toggleObscureText: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              hasToggle: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 103, 58, 182),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    VoidCallback? toggleObscureText,
    bool hasToggle = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 103, 58, 182)),
        border: const OutlineInputBorder(),
        suffixIcon: hasToggle
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: const Color.fromARGB(255, 103, 58, 182),
                ),
                onPressed: toggleObscureText,
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
