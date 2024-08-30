import 'package:flutter/material.dart';

import '../../helper/repeatedCode/repeatedCode.dart';


class Winners extends StatefulWidget {
  const Winners({Key? key}) : super(key: key);

  @override
  State<Winners> createState() => _WinnersState();
}

class _WinnersState extends State<Winners> {



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
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: RepeatedRow(name: 'Winners',)
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
                  child:SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: BouncingScrollPhysics()
                    ),
                    child: Column(
                      children: [


                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.28,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 60),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black12)
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12,left: 120),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5,),
                                      Image.asset('assets/avatar.png',width: 80,height: 80,),
                                      const SizedBox(height: 8,),
                                      const Text('John Doe',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),),
                                      const SizedBox(height: 8,),
                                      const Text('500 \$',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30,color: Colors.orange),),
                                      const SizedBox(height: 8,),
                                      const Text('23 July 2023',style: TextStyle(fontSize: 18),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              )
            ],
          ),
        )
    );

  }
}