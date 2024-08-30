import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import this for User type
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find(); // Singleton instance
  late Rx<User?> _user;
  final AuthService _authService = AuthService(); // AuthService instance
  final FirestoreService _firestoreService = FirestoreService();
    final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_authService.currentUser);
    _user.bindStream(_auth.authStateChanges()); // Stream to listen to auth state changes
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      if (Get.currentRoute != '/login') {
        Get.offAllNamed('/login');
      }
    } else {
      if (Get.currentRoute != '/home') {
        Get.offAllNamed('/home');
      }
    }
  }

  void signUp(String email, String password, String username, String name, String phoneNumber) async {
    try {
      User? user = await _authService.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        await _firestoreService.addUser(user.uid, username, name, email, phoneNumber);
      }
    } catch (e) {
      Get.snackbar('Error creating account', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signIn(String email, String password) async {
    try {
      await _authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      Get.snackbar('Error signing in', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    await _authService.signOut();
  }
}
