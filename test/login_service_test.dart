import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studie/pages/authetication/login_service.dart';

import 'login_service_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late LoginService loginService;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    loginService = LoginService(firebaseAuth: mockFirebaseAuth);
  });

  test('Successful login returns null', () async {
    when(mockFirebaseAuth.signInWithEmailAndPassword(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => MockUserCredential());

    final result = await loginService.login('test@example.com', 'password123');

    expect(result, isNull);
    verify(mockFirebaseAuth.signInWithEmailAndPassword(
      email: 'test@example.com',
      password: 'password123',
    )).called(1);
  });

  test('Login fails with user-not-found error', () async {
    when(mockFirebaseAuth.signInWithEmailAndPassword(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenThrow(FirebaseAuthException(code: 'user-not-found'));

    final result = await loginService.login('test@example.com', 'password123');

    expect(result, 'No user found for that email.');
    verify(mockFirebaseAuth.signInWithEmailAndPassword(
      email: 'test@example.com',
      password: 'password123',
    )).called(1);
  });

  test('Login fails with wrong-password error', () async {
    when(mockFirebaseAuth.signInWithEmailAndPassword(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenThrow(FirebaseAuthException(code: 'wrong-password'));

    final result = await loginService.login('test@example.com', 'password123');

    expect(result, 'Wrong password provided for that user.');
    verify(mockFirebaseAuth.signInWithEmailAndPassword(
      email: 'test@example.com',
      password: 'password123',
    )).called(1);
  });

  test('Login fails with a general error', () async {
    when(mockFirebaseAuth.signInWithEmailAndPassword(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenThrow(FirebaseAuthException(code: 'unknown-error'));

    final result = await loginService.login('test@example.com', 'password123');

    expect(result, 'An error occurred, please try again');
    verify(mockFirebaseAuth.signInWithEmailAndPassword(
      email: 'test@example.com',
      password: 'password123',
    )).called(1);
  });
}
