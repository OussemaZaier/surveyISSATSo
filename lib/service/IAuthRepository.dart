import 'package:firebase_auth/firebase_auth.dart';
import 'package:survey/service/AuthFailure.dart';

import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<AuthFailure, User>> login(String email, String password);
  Future<void> logout();
  Future<bool> isAuthenticated();
  Stream<User> getAuthState();
}
