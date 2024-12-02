import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core for initialization
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:studie/pages/authetication/auth_service.dart';

// Mock classes
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockFirebaseCore extends Mock implements Firebase {}

void main() {
  group('AuthService', () {
    late AuthService authService;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUserCredential mockUserCredential;
    late MockUser mockUser;

    // Initialize Firebase in test setup
    setUpAll(() async {
      // Mock Firebase.initializeApp so that it doesn't try to establish a real connection
      Firebase.initializeApp =
          () async {}; // No-op mock for Firebase initialization
    });

    setUp(() {
      // Create instances for each test
      mockFirebaseAuth = MockFirebaseAuth();
      mockUserCredential = MockUserCredential();
      mockUser = MockUser();
      authService = AuthService();
    });

    test('signUpWithEmailPassword successfully signs up user', () async {
      // Arrange
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'strongpassword',
      )).thenAnswer((_) async => mockUserCredential);

      when(mockUserCredential.user).thenReturn(mockUser); // Return mocked user
      when(mockUser.uid)
          .thenReturn('mocked-uid'); // Mock user properties as needed

      // Act
      final result = await authService.signUpWithEmailPassword(
        'test@example.com',
        'strongpassword',
      );

      // Assert
      expect(result, isNotNull);
      expect(result, isA<User>());
    });

    test('signUpWithEmailPassword throws error when email is already in use',
        () async {
      // Arrange
      final firebaseAuthException = FirebaseAuthException(
        code: 'email-already-in-use',
        message: 'The account already exists for that email.',
      );
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password',
      )).thenThrow(firebaseAuthException);

      // Act
      final result = authService.signUpWithEmailPassword(
        'test@example.com',
        'password',
      );

      // Assert
      expect(result, throwsA(isA<String>()));
      try {
        await result;
      } catch (e) {
        expect(e, 'The account already exists for that email.');
      }
    });

    test('signUpWithEmailPassword throws error on weak password', () async {
      // Arrange
      final firebaseAuthException = FirebaseAuthException(
        code: 'weak-password',
        message: 'The password provided is too weak.',
      );
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'weak',
      )).thenThrow(firebaseAuthException);

      // Act
      final result = authService.signUpWithEmailPassword(
        'test@example.com',
        'weak',
      );

      // Assert
      expect(result, throwsA(isA<String>()));
      try {
        await result;
      } catch (e) {
        expect(e, 'The password provided is too weak.');
      }
    });

    test('signUpWithEmailPassword returns generic error for unknown errors',
        () async {
      // Arrange
      final firebaseAuthException = FirebaseAuthException(
        code: 'unknown',
        message: 'An unknown error occurred.',
      );
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password',
      )).thenThrow(firebaseAuthException);

      // Act
      final result = authService.signUpWithEmailPassword(
        'test@example.com',
        'password',
      );

      // Assert
      expect(result, throwsA(isA<String>()));
      try {
        await result;
      } catch (e) {
        expect(e, 'An error occurred. Please try again.');
      }
    });
  });
}
