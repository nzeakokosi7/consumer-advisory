import 'package:consumable_advisory/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  /// Sign in with Google
  Future<Either<String, bool>> signInWithGoogle();

  /// Sign in with Email And Password
  Future<Either<String, bool>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign up with Email And Password
  Future<Either<String, bool>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign out
  Future<Either<String, bool>> signOut();

  /// Listen to auth changes
  void authStateChange(
    void Function(UserEntity? userEntity) authCallBack,
  );
}
