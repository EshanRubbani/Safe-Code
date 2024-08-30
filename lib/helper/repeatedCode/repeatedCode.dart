import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safes_code/controllers/auth_controller.dart';

import '../../views/profile/edit_profile.dart';

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key, required this.name, required this.onTap, required this.width, required this.height, }) : super(key: key);
  final String name;
  final VoidCallback onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        //height: MediaQuery.of(context).size.height*0.065,
        //width: MediaQuery.of(context).size.width*0.8,
          decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(64, 201, 255, 0.5),
              Color(0xff93278F),
            ],
            transform: GradientRotation(2.583),
          ),
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(child: Text(name,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),)),
      ),
    );
  }
}

//Custom Row Takes place like App bar
class RepeatedRow extends StatelessWidget {
  const RepeatedRow({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
          final AuthController authController = Get.find();
    return Row(
      children:  [
         Text(
          name,
          style: const TextStyle(
            fontFamily: "Open Sans",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
            height: 27.0 / 20.0,
            color: Colors.white,
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  ProfileScreen()));
          },
          child: const Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(width: 5,),
        InkWell(
          onTap: (){
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>   PointsScreen()));
          },
          child: const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(width: 5,),
        InkWell(
          onTap: (){
            authController.signOut();
          },
          child: const Icon(
            Icons.logout_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ],
    );
  }
}
