import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:safes_code/services/firestore_service.dart';
import 'package:safes_code/views/bank/createBank.dart';

import '../../helper/repeatedCode/repeatedCode.dart';
import 'guess_number.dart';

class Banks extends StatefulWidget {
  const Banks({Key? key}) : super(key: key);

  @override
  State<Banks> createState() => _BanksState();
}

class _BanksState extends State<Banks> {
  FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
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
              child: const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: RepeatedRow(
                    name: 'Bank',
                  )),
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: 20, bottom: 20, right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all()),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(20),
                                elevation: 5,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                ),
                                isExpanded: true,
                                value: 'Top Trending Banks',
                                underline: const SizedBox(),
                                onChanged: (String? value) {},
                                items: <String>[
                                  'Top Trending Banks',
                                  'B',
                                  'C',
                                  'D'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 8),
                           
                            child: StreamBuilder<List<Map<String, dynamic>>>(
                              stream: _firestoreService.getAllBanks(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }

                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Center(child: Text('No banks found.'));
                                }

                                List<Map<String, dynamic>> banks =
                                    snapshot.data!;

                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 12.0),
                                  itemCount: banks.length,
                                  itemBuilder: (context, index) {
                                    final bank = banks[index];
                                    return buildCard(context, bank);
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(CreateBankScreen()),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
        tooltip: 'Save Bank',
        backgroundColor: Color(0xff93278F).withOpacity(0.8),
      ),
    );
  }

  Container buildCard(BuildContext context, Map<String, dynamic> bank) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(10)
      ),   
     
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LotteryScreenGame(
                            image: '',
                            text1: '',
                            text2: '',
                          )));
            },
            child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width * 0.38,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xffB77BB5)),
              child: Center(child: Image.asset('assets/bank.png')),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.32,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black12)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${bank['currentAmount']} \$',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    Text("Winning Price",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black54))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
