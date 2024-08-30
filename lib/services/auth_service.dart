import 'package:firebase_auth/firebase_auth.dart';
import "package:get/get.dart";

class AuthService {
  // FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Getter for the current user
  User? get currentUser => _auth.currentUser;

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar("Success", "Account created successfully!");
      return userCredential.user;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      
      print(e);
      throw e;
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar("Success", "Logged in successfully!");
    } catch (e) {
      Get.snackbar("Error", e.toString());

      print(e);
      throw e;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.snackbar("Success", "Logged out successfully!");
    } catch (e) {
      Get.snackbar("Error", e.toString());

      print(e);
      throw e;
    }
  }
}
