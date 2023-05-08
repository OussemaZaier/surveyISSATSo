import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey/service/AuthFailure.dart';
import 'package:survey/service/Ifirestore.dart';
import 'package:survey/service/ImFirestore.dart';
import 'package:survey/service/Storage.dart';

import '../models/Student.dart';
import 'IAuthRepository.dart';

class AuthRepository implements IAuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final secureStorage = const FlutterSecureStorage();
  final _storage = Storage();
  @override
  Future<Either<AuthFailure, User>> login(String email, String password) async {
    // Authenticate user using Firebase Authentication

    final Student student;

    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await secureStorage.write(
          key: 'token', value: userCredential.user!.email);

      student = await FirestoreRepository()
          .getStudentByEmail('students', id: userCredential.user!.email);
      Storage().saveFiliere(student.filiere);
      return right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else if (e.code == "invalid-email") {
        return left(const AuthFailure.invaliEmail());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<void> logout() async {
    // Remove authentication token from secure storage
    await secureStorage.delete(key: 'token');

    // Sign out user from Firebase Authentication
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> isAuthenticated() async {
    // Check if authentication token exists in secure storage
    final String? token = await secureStorage.read(key: 'token');
    return token != null;
  }

  @override
  Stream<User> getAuthState() {
    // Return stream of authenticated user from Firebase Authentication
    return _firebaseAuth.authStateChanges().map((User? user) => user!);
  }
}
