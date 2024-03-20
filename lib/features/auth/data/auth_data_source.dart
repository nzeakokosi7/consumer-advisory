import 'package:consumable_advisory/config/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthDataSource {
  final FirebaseAuth _firebaseAuth;

  // final Ref _ref; // use for reading other providers

  AuthDataSource(this._firebaseAuth);

  Future<Either<String, bool>> signup({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(response.user != null);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Signup.');
    }
  }

  Future<Either<String, bool>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(response.user != null);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Login');
    }
  }
}

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) => AuthDataSource(ref.read(firebaseAuthProvider)),
);
