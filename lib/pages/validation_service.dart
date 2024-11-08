// lib/services/validation_service.dart

class ValidationService {
  String? validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email))
      return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? confirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) return 'Passwords do not match';
    return null;
  }
}
