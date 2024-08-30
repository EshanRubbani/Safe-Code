import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(), // replace with the name of your desired screen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
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
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/logo_large_transparent.png',
                        width: 800,
                        height: MediaQuery.of(context).size.height / 2 - 60,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 8,
                        left: MediaQuery.of(context).size.width / 3 - 60,
                        child: SizedBox(
                          width: 250,
                          height: 100,
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
