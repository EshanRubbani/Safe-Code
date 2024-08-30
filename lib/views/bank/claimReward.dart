import 'package:flutter/material.dart';
import 'package:safes_code/helper/page_navigation.dart';
import 'package:safes_code/helper/repeatedCode/repeatedCode.dart';




class ClaimReward extends StatefulWidget {
  const ClaimReward({Key? key,}) : super(key: key);

  @override
  State<ClaimReward> createState() => _ClaimRewardState();
}

class _ClaimRewardState extends State<ClaimReward> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(64, 201, 255, 0.5),
                Color(0xff93278F),
              ],
              stops: [
                0,
                0.9538,
              ],
              transform: GradientRotation(2.583),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15,
                child:  const Padding(
                    padding: EdgeInsets.only(left: 20,top: 45),
                    child: Text('Won',style: TextStyle(
                      fontFamily: "Open Sans",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      height: 27.0 / 20.0,
                      color: Colors.white,
                    ),)
                ),
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                      )
                    ],

                  ),
                  child:Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(top: 30,left: 20,right: 20,bottom: 20),
                        child: Image.asset('assets/claimReward.png'),
                      ),
                      const Text("Congratulations",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
                      const Text("You have guess the right code and won \n 500 \$",style: TextStyle(fontSize: 17,color: Colors.black54),textAlign: TextAlign.center,),
                      const SizedBox(height: 50,),
                      const Text('You will be given 90 percent of the \nearnings in with the bank. You will also \nbe charged to a 5.00 handling fee.',style: TextStyle(fontSize: 17,color: Colors.black54),textAlign: TextAlign.center,),

                   const SizedBox(height: 50,),
                   RepeatButton(name: 'Claim Reward', onTap: (){
                     Navigator.pushAndRemoveUntil(context,
                         MaterialPageRoute(builder: (context) =>  PageNavigator(),),
                             (route) => false);
                   }, width: 340, height: 48),

                    ],
                  )
                ),
              ),


            ],
          ),
        )
    );

  }
}