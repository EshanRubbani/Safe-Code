import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safes_code/services/firebase_storage_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController tokenController = TextEditingController();

  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  bool isEditing = false;
  User? currentUser;
  var profileImage = ''.obs;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
    // Observe changes in downloadUrl and update profileImage
    imagePickerController.downloadUrl.listen((url) {
      if (url.isNotEmpty) {
        setState(() {
          profileImage.value = url;
        });
      }
    });
  }

  void fetchUserProfile() async {
    // Get current user from FirebaseAuth
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Fetch additional user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        phoneController.text = userData['phoneNumber'] ?? '';
        profileImage.value = userData['profileImageUrl'] ?? '';
        emailController.text = userData['email'] ?? '';
        nameController.text = userData['name'] ?? '';
        usernameController.text = userData['username'] ?? '';
        tokenController.text = userData['tokens'].toString();
      }
    }
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void saveProfile() async {
    if (currentUser != null) {
      // Update additional data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update({
        "name": nameController.text,
        "username": usernameController.text,
        "phoneNumber": phoneController.text,
      });

      setState(() {
        isEditing = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(64, 201, 255, 0.5),
                  Color(0xff93278F),
                ],
                stops: [0, 0.9538],
                transform: GradientRotation(2.583),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontFamily: "Open Sans",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                              height: 27.0 / 20.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Edit your profile',
                            style: TextStyle(
                              fontFamily: "Open Sans",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              height: 27.0 / 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (isEditing) {
                                return Color(0xff93278F);
                              }
                              return Colors.white;
                            },
                          ),
                        ),
                        onPressed: () {
                          toggleEditing();
                        },
                        child: Text(
                          "Update Profile",
                          style: TextStyle(
                              color: isEditing ? Colors.white : Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 150),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 50,
                          backgroundImage: profileImage.value.isNotEmpty
                              ? NetworkImage(profileImage.value)
                              : null, // Set to null if no image
                          child: profileImage.value.isEmpty
                              ? Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 50, // Adjust the icon size as needed
                                )
                              : null, // Set to null if there is an image
                        ),
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: isEditing,
                        child: ElevatedButton(
                          onPressed: () {
                            imagePickerController.getImage();
                          },
                          child: const Text("Pick Image"),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 80),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            enabled: isEditing,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: usernameController,
                            enabled: isEditing,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                            ),
                          ),
                          const SizedBox(height: 10),
                           TextFormField(
                            controller: tokenController,
                            enabled:
                                false, 
                            decoration: const InputDecoration(
                              labelText: 'Tokens',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: emailController,
                            enabled:
                                false, // Email is usually not editable directly
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: phoneController,
                            enabled: isEditing,
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: isEditing,
                    child: ElevatedButton(
                      onPressed: isEditing ? saveProfile : null,
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePickerController extends GetxController {
  var imagePath = ''.obs;
  var downloadUrl = ''.obs;

  Future<void> getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imagePath.value = image.path;

      // Convert the XFile to a File
      File imageFile = File(image.path);

      // Create an instance of FirebaseStorageService
      FirebaseStorageService storageService = FirebaseStorageService();

      // Upload the image and get the download URL
      try {
        String? url = await storageService.uploadImage(imageFile);

        if (url != null) {
          downloadUrl.value = url;
        }
      } catch (e) {
        print("Failed to upload image: $e");
        Get.snackbar("Error", "Failed to upload image.");
      }
    } else {
      Get.snackbar("Error", "No image selected.");
    }
  }
}
