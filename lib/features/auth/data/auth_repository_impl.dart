import 'package:consumable_advisory/config/providers.dart';
import 'package:consumable_advisory/features/auth/data/auth_data_source.dart';
import 'package:consumable_advisory/features/auth/domain/entities/user_entity.dart';
import 'package:consumable_advisory/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(this.authDataSource, this.firebaseAuth);

  @override
  void authStateChange(void Function(UserEntity? userEntity) authCallBack) {
    // TODO: implement authStateChange
  }

  @override
  Future<Either<String, bool>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<String, bool>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return authDataSource.login(email: email, password: password);
  }

  @override
  Future<Either<String, bool>> signInWithGoogle() async {
    try{
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if(googleUser !=null) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final response = await firebaseAuth.signInWithCredential(credential);
        return right(response.user!=null);
      } else {
        return left('Unknown Error');
      }

    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<Either<String, bool>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return authDataSource.signup(email: email, password: password);
  }
}

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final authDataSource = ref.watch(authDataSourceProvider);
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthRepositoryImpl(
    authDataSource,
    firebaseAuth,
  );
});
