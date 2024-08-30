import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Uuid _uuid = Uuid(); // UUID package for generating unique IDs
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  // Add user data to Firestore
  Future<void> addUser(String uid, String username, String name, String email,
      String phoneNumber) async {
    try {
      await _db.collection('users').doc(uid).set({
        'username': username,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'uid': uid,
        "tokens": 0,
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // Get user data from Firestore
  Future<DocumentSnapshot> getUser(String uid) async {
    try {
      return await _db.collection('users').doc(uid).get();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // Function to update or add profileImageUrl
  Future<void> updateProfileImageUrl(String userId, String newUrl) async {
    try {
      // Reference to the user's document
      DocumentReference userRef = _db.collection('users').doc(userId);

      // Fetch the user's document to check if it exists
      DocumentSnapshot userSnapshot = await userRef.get();

      if (userSnapshot.exists) {
        // If the document exists, update the profileImageUrl
        await userRef.update({'profileImageUrl': newUrl});
        print("Profile image URL updated successfully.");
      } else {
        // If the document doesn't exist, add it with profileImageUrl
        await userRef.set(
            {
              'profileImageUrl': newUrl,
            },
            SetOptions(
                merge: true)); // Merge true to avoid overwriting other fields
        print("Profile image URL added successfully.");
      }
    } catch (e) {
      print("Error updating profile image URL: $e");
    }
  }

  // Function to create a new bank
  Future<void> createBank(
    double currentAmount,
    String initialCode,
    String bankName,
  ) async {
   
    try {
      // Generate a unique bank ID
      String bankId = _uuid.v5(Uuid.NAMESPACE_URL, bankName);

      // Data to be added
      Map<String, dynamic> bankData = {
        'bankId': bankId,
        'ownerId': userId,
        'currentAmount': currentAmount,
        'initialCode': initialCode,
        'bankName': bankName,
        "created_at": Timestamp.now(),
      };

      // Add data to Firestore
      await _db.collection('banks').doc(bankId).set(bankData);

      // Update the user's document
      await _db.collection('users').doc(userId).update({
        'banks': FieldValue.arrayUnion([bankId]), // Add bankId to the array

      });
      
      print("Bank created successfully with ID: $bankId");
      Get.snackbar( "Success", "Bank created successfully: $bankId");
     
    } catch (e) {
     
      Get.snackbar("Error", e.toString());
      print("Error creating bank: $e");
      throw e;
    }
  }

  // Function to delete a bank
  Future<void> deleteBank(String userId, String bankId) async {
    try {
      // Delete bank document from Firestore
      await _db.collection('banks').doc(bankId).delete();

      // Update the user's document
      await _db.collection('users').doc(userId).update({
        'banks': FieldValue.arrayRemove([bankId]), // Remove bankId from the array
      });

      Get.snackbar("Success", "Bank deleted successfully: $bankId");
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print("Error deleting bank: $e");
      throw e;
    }
  }


  // Stream function to get all banks
  Stream<List<Map<String, dynamic>>> getAllBanks() {
    return _db.collection('banks').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }
}
