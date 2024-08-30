// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
//
//
// class Profile {
//   String name;
//   String email;
//   String phone;
//
//   Profile({required this.name, required this.email, required this.phone});
// }
//
// class ProfileAdapter extends TypeAdapter<Profile> {
//   @override
//   int get typeId => 0;
//
//   @override
//   Profile read(BinaryReader reader) {
//     return Profile(
//       name: reader.read(),
//       email: reader.read(),
//       phone: reader.read(),
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, Profile obj) {
//     writer.write(obj.name);
//     writer.write(obj.email);
//     writer.write(obj.phone);
//   }
// }
//
// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   late Box<Profile> profileBox;
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//
//   bool isEditing = false;
//
//   @override
//   void initState() {
//     super.initState();
//     profileBox = Hive.box<Profile>('profile');
//     loadProfile();
//   }
//
//   void loadProfile() {
//     if (profileBox.isNotEmpty) {
//       Profile profile = profileBox.getAt(0)!;
//       setState(() {
//         nameController.text = profile.name;
//         emailController.text = profile.email;
//         phoneController.text = profile.phone;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     super.dispose();
//   }
//
//   void toggleEditing() {
//     setState(() {
//       isEditing = !isEditing;
//     });
//   }
//
//   void saveProfile() {
//     Profile profile = Profile(
//       name: nameController.text,
//       email: emailController.text,
//       phone: phoneController.text,
//     );
//
//     if (profileBox.isEmpty) {
//       profileBox.add(profile);
//     } else {
//       profileBox.putAt(0, profile);
//     }
//
//     toggleEditing();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             onPressed: toggleEditing,
//             icon: Icon(Icons.edit),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 64,
//               backgroundImage: AssetImage('assets/profile_pic.png'),
//             ),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: nameController,
//               enabled: isEditing,
//               decoration: InputDecoration(
//                 labelText: 'Name',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: emailController,
//               enabled: isEditing,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: phoneController,
//               enabled: isEditing,
//               decoration: InputDecoration(
//                 labelText: 'Phone',
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: isEditing ? saveProfile : null,
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
