import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safes_code/services/firestore_service.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreService firestoreService = FirestoreService();


  Future<String?> uploadImage(File imageFile) async {
    try {
      // Get the current user's UID
      String uid = _auth.currentUser!.uid;

      // Create a reference to the storage location
      Reference ref = _storage.ref().child('images/$uid.jpg');

      // Upload the image
      UploadTask uploadTask = ref.putFile(imageFile);

      // Show a snackbar while uploading
      Get.snackbar(
        "Uploading",
        "Please wait...",
        isDismissible: false,
        showProgressIndicator: true,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        duration: Duration(seconds: 9999), // Set a long duration
      );

      // Wait for the upload to complete
      await uploadTask.whenComplete(() {
        // Hide the snackbar after the upload is complete
        Get.back();
        Get.snackbar("Success,", "Image uploaded successfully!",colorText: Colors.white,);
       

      });

      // Get the download URL
      String downloadUrl = await ref.getDownloadURL();
       firestoreService.updateProfileImageUrl(uid, downloadUrl);

      return downloadUrl;
    } catch (e) {
      Get.snackbar("Error", e.toString(),colorText: Colors.white,);
      print(e);
      return null;
    }
  }
}
