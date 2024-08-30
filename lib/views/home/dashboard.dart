import 'package:flutter/material.dart';
import 'package:safes_code/views/home/buyguesses/buyGuesses.dart';
import 'package:safes_code/views/home/withdraw/withdraw.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/repeatedCode/repeatedCode.dart';
import 'Deposit/Deposit.dart';

class DashBoard extends StatefulWidget {
   DashBoard({Key? key,}) : super(key: key);


  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  int points = 0;

  @override
  void initState() {
    super.initState();
    getPoints();
  }

  void getPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      points = prefs.getInt('points') ?? 0;
    });
    print("I am get fun");
  }


  @override
  Widget build(BuildContext context) {
    print('Points $points');
    return Scaffold(
      body:Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.15,
              child: const Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: RepeatedRow(name: 'Home',)
              ),


            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 3.0,right: 3.0,),
                alignment: Alignment.center,
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
                child:SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: BouncingScrollPhysics()
                  ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Text('$totalPoints'),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Center(
                            child: Image.asset(
                                "assets/home_logo.png",
                                width: 320.0,height: 300,

                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8 , right: 8,bottom: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.95,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AboveFourContainers(onPress: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const Deposit(),)); }, name: 'Deposit', icon: Icons.call_received_sharp,),
                                  const SizedBox(width: 12,),
                                  AboveFourContainers(onPress: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const WithDrawCash(),)); }, name: 'WithDraw', icon: Icons.turn_sharp_left_outlined,),
                                  const SizedBox(width: 12,),
                                  AboveFourContainers(onPress: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyGuess(),)); }, name: '    Buy \nGuesses', icon: Icons.safety_divider_rounded,),
                                  const SizedBox(width: 12,),
                                  AboveFourContainers(onPress: (){
                                    Share.share('https://play.google.com/store/apps/details?id=com.yourcompany.yourapp');
                                  }, name: 'Share', icon: Icons.share,),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Transaction History',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Track your Spending & earning',
                            style: TextStyle(fontSize: 14,fontWeight:FontWeight.w400),
                          ),
                        ),

                        const SizedBox(height: 16.0),

                        Text('Points : $points'),

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            width: double.infinity,
                            height: 95,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                blurRadius: 10)
                              ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 73,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                  ),

                                  const SizedBox(width: 12,),
                                  Container(
                                    width: 70,
                                    height: 73,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: const Color(0xffEEEEEE)
                                    ),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Text('12',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 22),),
                                          Text("March",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),)
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0,top: 30),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text('Earned',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                                        Text('Lorem Ipsum is simply',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),)
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 50,),
                                  const Text('+34 \$',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 22,color: Colors.green),)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )

                ),  ),
            ),
          ],
        ),
      ),
    );

  }
}

//Class for the 4 container deposit , withdraw etc

class AboveFourContainers extends StatelessWidget {
  const AboveFourContainers({Key? key, required this.onPress, required this.name, required this.icon}) : super(key: key);

  final VoidCallback onPress;
  final String name ;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width*0.2,
        height: MediaQuery.of(context).size.height*.17,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.black12)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Icon(icon,size: 40,color: const Color(0xffB77BB5),),
              const SizedBox(height: 10,),
              Text(name,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Color(0xffB77BB5)),)
            ],
          ),
        ),
      ),
    );
  }
}