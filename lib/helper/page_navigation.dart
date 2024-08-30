import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:safes_code/views/winners/winners.dart';
import '../views/bank/bankscreen.dart';
import '../views/home/dashboard.dart';


class PageNavigator extends StatefulWidget {
  PageNavigator({Key? key}) : super(key: key);

  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  List pages =[
    const Winners(),
     DashBoard(),
    const Banks(),
  ];

  int selectedIndex = 1;

  DateTime? currentBackPressTime;


  Future<bool> _onWillPop() async {

    // This dialog will exit your app on saying yes
    return (
        await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          height: MediaQuery.of(context).size.height*0.2,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
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
                borderRadius: BorderRadius.circular(10.0),
              ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                      const Text(
                        'Exit App', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Do you want to exit the app?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),

                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child:  const Text('No',style: TextStyle(color: Colors.white),),),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child:  const Text('Yes',style: TextStyle(color: Colors.white),))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        //content:  const Text('Do you want to exit an App'),

      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: pages[selectedIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(


        buttonBackgroundColor: Colors.blue,
        backgroundColor:  Colors.black12,
        items:  const [
          Icon(LineIcons.wineGlass,size: 30),
          Icon(LineIcons.home,size: 30),
          Icon(LineIcons.building,size: 30),
        ],
        animationCurve: Curves.linear,
        animationDuration: const Duration(milliseconds: 400),
        index: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}



