// test/validation_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:studie/pages/authetication/validation_service.dart';
// import 'package:studie/services/validation_service.dart';

void main() {
  late ValidationService validationService;

  setUp(() {
    // Initialize the ValidationService before each test
    validationService = ValidationService();
  });

  group('Email Validation', () {
    test('returns error when email is empty', () {
      expect(validationService.validateEmail(''), 'Email is required');
    });

    test('returns error when email is invalid', () {
      expect(validationService.validateEmail('invalid-email'),
          'Enter a valid email');
    });

    test('returns null when email is valid', () {
      expect(validationService.validateEmail('test@example.com'), null);
    });
  });

  group('Password Validation', () {
    test('returns error when password is empty', () {
      expect(validationService.validatePassword(''), 'Password is required');
    });

    test('returns error when password is too short', () {
      expect(validationService.validatePassword('123'),
          'Password must be at least 6 characters');
    });

    test('returns null when password is valid', () {
      expect(validationService.validatePassword('validPassword123'), null);
    });
  });

  group('Confirm Password Validation', () {
    test('returns error when passwords do not match', () {
      expect(validationService.confirmPassword('password', 'differentPassword'),
          'Passwords do not match');
    });

    test('returns null when passwords match', () {
      expect(validationService.confirmPassword('password123', 'password123'),
          null);
    });
  });
}
