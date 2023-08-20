import 'package:consumable_advisory/config/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingController extends StateNotifier<bool> {
  final FirebaseAuth firebaseAuth;

  OnboardingController(this.firebaseAuth) : super(true);


  Future<void> initialize({String? fullName}) async {
    if(fullName !=null && fullName.isNotEmpty) {
      firebaseAuth.currentUser!.updateDisplayName(fullName);
      await firebaseAuth.currentUser!.reload();
    }
    state = false;
  }
}

final onboardingControllerProvider = StateNotifierProvider.autoDispose<OnboardingController, bool>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return OnboardingController(firebaseAuth);
});
