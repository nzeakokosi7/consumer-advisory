import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumable_advisory/config/app_logger.dart';
import 'package:consumable_advisory/features/auth/presentation/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firebaseFireStoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final firebaseStorageProvider =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

final cameraProvider =
    FutureProvider.autoDispose<CameraController?>((ref) async {
  try {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    final controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await controller.initialize();

    ref.onDispose(() {
      controller.dispose();
    });

    return controller;
  } catch (e) {
    AppLogger.log("Camera error $e");
    return null;
  }
});

/// Provides a [ValueNotifier] to the app router to redirect on auth state change
final authStateListenable = ValueNotifier<bool>(false);

/// Triggered from common() to complete futures
Future<void> initializeProviders(ProviderContainer container) async {
  /// Firebase
  container.read(firebaseAuthProvider);

  /// Auth
  container.read(authControllerProvider);
}
