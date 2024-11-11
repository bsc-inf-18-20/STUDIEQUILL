import 'package:flutter/material.dart';
import 'package:studie/pages/localisation/app_localizations.dart';
import 'package:studie/pages/authetication/Sign_Up.dart';
import 'package:studie/pages/home/HomePage.dart';
import 'login_service.dart';
import 'auth_service.dart';
import 'validation_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  final LoginService _loginService = LoginService();
  final AuthService _authService = AuthService();
  final ValidationService _validationService = ValidationService();

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    String? error = await _loginService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
      _errorMessage = error;
    });

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(
            isDarkMode: false,
            onThemeChange: (value) {},
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String loginTitle =
        AppLocalizations.of(context)?.getString('login_title') ??
            'Login to Your Account';
    String emailLabel =
        AppLocalizations.of(context)?.getString('email_label') ?? 'Email';
    String passwordLabel =
        AppLocalizations.of(context)?.getString('password_label') ?? 'Password';
    String loginButton =
        AppLocalizations.of(context)?.getString('login_button') ?? 'Login';
    String signupPrompt =
        AppLocalizations.of(context)?.getString('signup_prompt') ??
            'Don\'t have an account?';
    String signupButton =
        AppLocalizations.of(context)?.getString('signup_button') ?? 'Sign Up';

    final locale = Localizations.localeOf(context);
    final isChichewa = locale.languageCode == 'ny';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'STUDIE APP',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 103, 58, 182),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Card(
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
                  Text(
                    loginTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isChichewa ? 18 : 24,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 103, 58, 182),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: emailLabel,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 103, 58, 182),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: passwordLabel,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 103, 58, 182),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 103, 58, 182),
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                          ),
                          child: Text(
                            loginButton,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                  const SizedBox(height: 10),
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        signupPrompt,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(
                                authService: _authService,
                                validationService: _validationService,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          signupButton,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 103, 58, 182)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
