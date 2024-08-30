import 'package:flutter/material.dart';

class BuyGuess extends StatefulWidget {
  const BuyGuess({Key? key}) : super(key: key);

  @override
  State<BuyGuess> createState() => _BuyGuessState();
}

class _BuyGuessState extends State<BuyGuess> {



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
                  child: Text("Buy Guesses",
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
                    padding: const EdgeInsets.only(top: 40,left: 20,bottom: 20,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:    [
                      const Text('Buy Guesses',style: TextStyle(fontSize:18 ,fontWeight: FontWeight.w600),),
                      const SizedBox(height: 15,),
                      const Text('Minimum 1 Guess for 0.25 Cents ',style: TextStyle(fontSize:14,color: Color(0xffC4C4C4) ,fontWeight: FontWeight.w600),),
                      const SizedBox(height: 10,),
                      const Divider(color: Colors.black,thickness: 1,),
                      const SizedBox(height: 25,),
                      const Text('Select Guesses to Buy',style: TextStyle(fontSize:18,fontWeight: FontWeight.w600),),

                    Wrap(
                      children: const [
                        RepeatedGuessContainer(name: '\$ 100'),
                        RepeatedGuessContainer(name: '\$ 200'),
                        RepeatedGuessContainer(name: '\$ 300'),
                        RepeatedGuessContainer(name: '\$ 400'),
                        RepeatedGuessContainer(name: '\$ 500'),
                      ],
                    )

                      ],
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
//repeat Containers
class RepeatedGuessContainer extends StatelessWidget {
  const RepeatedGuessContainer({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 30),
      child: Container(
        height: MediaQuery.of(context).size.height*.15,
        width: MediaQuery.of(context).size.width*.25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black12),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 5
              )
            ]
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purpleAccent
                ),
                child: const Center(child: Text('\$',style: TextStyle(color: Colors.white,fontSize: 20),)),
              ),
              const SizedBox(height: 10,),
               Text(name,style: const TextStyle(color: Colors.purpleAccent,fontSize: 16,fontWeight: FontWeight.w600),)
            ],
          ),
        ),
      ),
    );
  }
}



