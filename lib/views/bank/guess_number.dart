import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/page_navigation.dart';
import '../../helper/repeatedCode/repeatedCode.dart';
import 'claimReward.dart';

class LotteryScreenGame extends StatefulWidget {
  const LotteryScreenGame({Key? key, required this.image, required this.text1, required this.text2}) : super(key: key);
  final String image;
  final String text1;
  final String text2;

  @override
  State<LotteryScreenGame> createState() => _LotteryScreenGameState();
}

class _LotteryScreenGameState extends State<LotteryScreenGame> {
  late int randomNumber;
  int points = 0;
  TextEditingController guessController = TextEditingController();
  String result = '';
  bool _isShowHint = false;
  late int clicks = 4;

  void _clickdecrement() {
    clicks--;
  }

  @override
  void initState() {
    super.initState();
    generateRandomNumber();
  }

  void generateRandomNumber() {
    Random random = Random();
    randomNumber = random.nextInt(10000);
  }

  void savePoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('points', points);
    print("I am save fun");
  }

  void checkGuess() {
    int? userGuess = int.tryParse(guessController.text);

    if (userGuess != null) {
      if (userGuess == randomNumber) {
        setState(() {
          points += 10;
        });
        savePoints();
        winnerDialog();
      } else {
        loserDialog();
      }
    } else {
      invalidEnterDialog();
    }
  }

  void winnerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: 100,
            height: 400,
            child: Column(
              children: [
                const Text(
                  'Congrats!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.green),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'You have guessed it right',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
                ),
                Image.asset(
                  'assets/winner.png',
                  height: 220,
                ),
                Text(
                  'You have to guess $clicks More digits to win Proceed to guess other digits',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: RepeatButton(
                    name: 'Processed to Guesses',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ClaimReward()));
                    },
                    width: 230,
                    height: 40,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void loserDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: 100,
            height: 400,
            child: Column(
              children: [
                const Text(
                  'Oops!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.red),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'You have guessed it wrong',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
                ),
                Image.asset('assets/loser.png'),
                Text(
                  'You have to guess $clicks More digits to win Proceed to guess other digits\nRandom number was $randomNumber',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: RepeatButton(
                    name: 'Processed to Guesses',
                    onTap: () {
                      Navigator.pop(context);
                      if (clicks == 0) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageNavigator(),
                            ),
                            (route) => false);
                      }
                    },
                    width: 230,
                    height: 40,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void invalidEnterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: 100,
            height: 400,
            child: Column(
              children: [
                const Text(
                  'Oops!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.red),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Please enter a valid number',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
                ),
                Image.asset('assets/loser.png'),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: RepeatButton(
                    name: 'Processed to Guesses',
                    onTap: () {
                      Navigator.pop(context);
                    },
                    width: 230,
                    height: 40,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showHint() {
    setState(() {
      _isShowHint = !_isShowHint;
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
        body: Container(
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: const [
                  Text(
                    "Bank Name",
                    style: TextStyle(
                      fontFamily: "Open Sans",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      height: 27.0 / 20.0,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ],
              ),
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 20),
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.38,
                      height: MediaQuery.of(context).size.height * 0.18,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color(0xffB77BB5)),
                      child: Center(child: Image.asset('assets/bank.png')),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.32,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.black12)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                '100 \$',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              Text("Winning Price", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black54))
                            ],
                          ),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 16.0),
                        // Text(
                        //   'Random Number: $randomNumber',
                        //   style: TextStyle(fontSize: 24.0),
                        // ),
                        const SizedBox(height: 16.0),

                        Pinput(
                          controller: guessController,
                          length: 4,
                          onChanged: (String value) {
                            randomNumber = value as int;
                          },
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          showCursor: true,
                          onCompleted: (pin) => print(pin),
                        ),

                        const SizedBox(height: 30.0),

                        InkWell(
                          onTap: () {
                            showHint();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SizedBox(
                                    width: 100,
                                    height: 400,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Hints for you!',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          textAlign: TextAlign.center,
                                          'You have Spend 20 \$ therefore its time to give you a hint about the code.',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
                                        ),
                                        Text(
                                          '${(randomNumber ~/ 1000) % 1000}',
                                          style: const TextStyle(fontSize: 130, color: Colors.green),
                                        ),
                                        const Text(
                                          textAlign: TextAlign.center,
                                          'This is one digit of the code,Now Guess more easily and win the price.',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 55.0),
                                          child: RepeatButton(
                                            name: 'Processed to Guesses',
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            width: 230,
                                            height: 40,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 270,
                            height: 35,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
                            child: const Center(
                                child: Text(
                              'Spend 20 \$ get a number of the code',
                              style: TextStyle(color: Color(0xff767676), fontWeight: FontWeight.w400, fontSize: 12),
                            )),
                          ),
                        ),

                        const SizedBox(height: 12.0),

                        InkWell(
                          onTap: () {
                            showHint();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SizedBox(
                                    width: 100,
                                    height: 400,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Hints for you!',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          textAlign: TextAlign.center,
                                          'You have Spend 40 \$ therefore its time to give you a hint about the place of the digit in the code.',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 50),
                                          child: Row(
                                            children: [
                                              _container('${(randomNumber ~/ 1000) % 1000}'),
                                              _container('*'),
                                              _container('*'),
                                              _container('*'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          textAlign: TextAlign.center,
                                          'This is one digit of the code,Now Guess more easily and win the price.',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 55.0),
                                          child: RepeatButton(
                                            name: 'Processed to Guesses',
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            width: 230,
                                            height: 40,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 270,
                            height: 35,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
                            child: const Center(
                                child: Text(
                              'Spend 40 \$ to put number space it goes to',
                              style: TextStyle(color: Color(0xff767676), fontWeight: FontWeight.w400, fontSize: 12),
                            )),
                          ),
                        ),

                        const SizedBox(height: 30.0),

                        RepeatButton(
                          name: 'Make a guess $clicks',
                          onTap: () {
                            checkGuess();
                            _clickdecrement();
                            setState(() {
                              if (clicks == 0) {
                                loserDialog();
                              }
                            });
                          },
                          width: 345,
                          height: 50,
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

Padding _container(String data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(234, 239, 243, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Text(
        data,
        style: const TextStyle(fontSize: 20),
      )),
    ),
  );
}
