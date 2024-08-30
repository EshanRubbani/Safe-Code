import 'package:flutter/material.dart';
import 'package:safes_code/helper/repeatedCode/repeatedCode.dart';

class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {

  final amountController = TextEditingController();
  final emailController = TextEditingController();
  final cardNumberController = TextEditingController();
  final mmYyController = TextEditingController();
  final cvvController = TextEditingController();

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
            child: const Padding(
              padding: EdgeInsets.only(left: 20,top: 50),
              child: Text("Deposit",
                style: TextStyle(
                  fontFamily: "Open Sans",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  height: 27.0 / 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
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
              child: Padding(
                padding: const EdgeInsets.only(top: 40,left: 20,bottom: 20,right: 15),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: BouncingScrollPhysics()
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text("Deposit Cash",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 22),),
                      const SizedBox(height: 10,),
                      const Text("Deposit Cash to Safes Codes ",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                      const SizedBox(height: 25,),

                      RepeatTextField(name: 'Amount to Deposit', controller: amountController),
                      const SizedBox(height: 30,),
                      const Text('Card Information'),
                      const SizedBox(height: 12,),
                      RepeatTextField(name: 'Email', controller: emailController),
                      const SizedBox(height: 25,),
                      RepeatTextField(name: 'Card Number', controller: cardNumberController),
                      const SizedBox(height: 25,),
                      Row(
                        children: [
                          Flexible(
                              child:RepeatTextField(name: "MM/YY", controller: mmYyController), ),
                          const SizedBox(width: 10,),
                          Flexible(
                            child: RepeatTextField(name: "CVV", controller: cvvController),)
                        ],
                      ),

                      const SizedBox(height: 70,),
                      Center(child: RepeatButton(name: 'Deposit', onTap: (){}, width: 345, height: 50,))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      )
    );

  }
}

//Class for Textfield
class RepeatTextField extends StatefulWidget {
  const RepeatTextField({Key? key, required this.name, required this.controller}) : super(key: key);
  final String name;
  final TextEditingController controller;

  @override
  State<RepeatTextField> createState() => _RepeatTextFieldState();
}

class _RepeatTextFieldState extends State<RepeatTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: widget.name
      ),
    );
  }
}


