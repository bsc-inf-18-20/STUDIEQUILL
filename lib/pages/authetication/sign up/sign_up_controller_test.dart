// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// // import 'package:studie/pages/authentication/auth_service.dart';
// // import 'package:studie/pages/authentication/sign%20up/sign_up_controller.dart';
// // import 'package:studie/pages/authentication/validation_service.dart';
// import 'package:studie/pages/authetication/auth_service.dart';
// import 'package:studie/pages/authetication/sign%20up/sign_up_controller.dart';
// import 'package:studie/pages/authetication/validation_service.dart';

// // This annotation generates the mocks (do not remove)
// @GenerateMocks([AuthService, ValidationService])

// // Import the generated mocks file
// import 'sign_up_controller_test.mocks.dart';

// void main() {
//   // Declare the mock variables
//   late MockAuthService mockAuthService;
//   late MockValidationService mockValidationService;
//   late SignUpController signUpController;
//   late List<String> snackbarMessages;

//   // Set up the mock instances before each test
//   setUp(() {
//     mockAuthService = MockAuthService();
//     mockValidationService = MockValidationService();
//     snackbarMessages = [];

//     // Initialize the SignUpController with mock services
//     signUpController = SignUpController(
//       authService: mockAuthService,
//       validationService: mockValidationService,
//       showSnackbar: (message) => snackbarMessages.add(message),
//       navigateToLogin: () {}, // Empty function for testing purposes
//     );
//   });

//   test('Sign-up fails with invalid email format', () async {
//     // Arrange
//     signUpController.emailController.text = 'invalid-email';
//     signUpController.passwordController.text = 'ValidPass123';
//     signUpController.confirmPasswordController.text = 'ValidPass123';

//     when(mockValidationService.validateEmail(any))
//         .thenReturn('Invalid email format');

//     // Act
//     await signUpController.signUp();

//     // Assert
//     expect(snackbarMessages, ['Invalid email format']);
//   });

//   test('Sign-up fails with invalid password format', () async {
//     // Arrange
//     signUpController.emailController.text = 'test@example.com';
//     signUpController.passwordController.text = 'short';
//     signUpController.confirmPasswordController.text = 'short';

//     when(mockValidationService.validatePassword(any))
//         .thenReturn('Password too short');

//     // Act
//     await signUpController.signUp();

//     // Assert
//     expect(snackbarMessages, ['Password too short']);
//   });

//   test('Sign-up fails when passwords do not match', () async {
//     // Arrange
//     signUpController.emailController.text = 'test@example.com';
//     signUpController.passwordController.text = 'ValidPass123';
//     signUpController.confirmPasswordController.text = 'DifferentPass123';

//     when(mockValidationService.confirmPassword(any, any))
//         .thenReturn('Passwords do not match');

//     // Act
//     await signUpController.signUp();

//     // Assert
//     expect(snackbarMessages, ['Passwords do not match']);
//   });

//   test('Sign-up succeeds with valid credentials', () async {
//     // Arrange
//     signUpController.emailController.text = 'test@example.com';
//     signUpController.passwordController.text = 'ValidPass123';
//     signUpController.confirmPasswordController.text = 'ValidPass123';

//     when(mockValidationService.validateEmail(any)).thenReturn(null);
//     when(mockValidationService.validatePassword(any)).thenReturn(null);
//     when(mockValidationService.confirmPassword(any, any)).thenReturn(null);
//     when(mockAuthService.signUpWithEmailPassword(any, any))
//         .thenAnswer((_) async => 'user123');

//     bool loginNavigated = false;
//     signUpController = SignUpController(
//       authService: mockAuthService,
//       validationService: mockValidationService,
//       showSnackbar: (message) => snackbarMessages.add(message),
//       navigateToLogin: () => loginNavigated = true,
//     );

//     // Act
//     await signUpController.signUp();

//     // Assert
//     expect(snackbarMessages, ['Account created successfully. Please log in.']);
//     expect(loginNavigated, isTrue);
//   });

//   test('Sign-up shows error message when AuthService throws an error',
//       () async {
//     // Arrange
//     signUpController.emailController.text = 'test@example.com';
//     signUpController.passwordController.text = 'ValidPass123';
//     signUpController.confirmPasswordController.text = 'ValidPass123';

//     when(mockValidationService.validateEmail(any)).thenReturn(null);
//     when(mockValidationService.validatePassword(any)).thenReturn(null);
//     when(mockValidationService.confirmPassword(any, any)).thenReturn(null);
//     when(mockAuthService.signUpWithEmailPassword(any, any))
//         .thenThrow(Exception('Sign-up failed'));

//     // Act
//     await signUpController.signUp();

//     // Assert
//     expect(snackbarMessages, ['Exception: Sign-up failed']);
//   });
// }
