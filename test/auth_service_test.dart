// import 'package:flutter_test/flutter_test.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:studie/pages/authetication/auth_service.dart';

// void main() {
//   // Ensure the Flutter binding is initialized for the test environment
//   TestWidgetsFlutterBinding.ensureInitialized();

//   // Initialize Firebase before running the tests
//   setUpAll(() async {
//     await Firebase.initializeApp();

//     // Initialize the Firebase Auth Emulator (if needed)
//     FirebaseAuth.instance.useAuthEmulator(
//         'localhost', 9099); // Port is typically 9099 for Firebase Auth emulator
//   });

//   group('AuthService Tests', () {
//     late AuthService authService;

//     // Initialize AuthService before each test
//     setUp(() {
//       authService = AuthService();
//     });

//     test('SignUp with valid email and password should succeed', () async {
//       final email = 'test@example.com';
//       final password = 'validPassword123';

//       final user = await authService.signUpWithEmailPassword(email, password);

//       expect(user, isNotNull);
//       expect(user?.email, equals(email));
//     });

//     test('SignUp with existing email should throw error', () async {
//       final email = 'test@example.com';
//       final password = 'validPassword123';

//       try {
//         await authService.signUpWithEmailPassword(email, password);
//         fail('Expected FirebaseAuthException but no exception was thrown.');
//       } catch (e) {
//         expect(e, isA<FirebaseAuthException>());
//         expect(
//             (e as FirebaseAuthException).code, equals('email-already-in-use'));
//       }
//     });

//     test('SignUp with weak password should throw error', () async {
//       final email = 'test@example.com';
//       final password = '123';

//       try {
//         await authService.signUpWithEmailPassword(email, password);
//         fail('Expected FirebaseAuthException but no exception was thrown.');
//       } catch (e) {
//         expect(e, isA<FirebaseAuthException>());
//         expect((e as FirebaseAuthException).code, equals('weak-password'));
//       }
//     });
//   });
// }
