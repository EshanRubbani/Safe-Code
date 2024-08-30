import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safes_code/helper/repeatedCode/repeatedCode.dart';
import 'package:safes_code/services/firestore_service.dart';

class CreateBankScreen extends StatefulWidget {
  @override
  _CreateBankScreenState createState() => _CreateBankScreenState();
}

class _CreateBankScreenState extends State<CreateBankScreen> {
  FirestoreService _firestoreService = FirestoreService();
  final _formKey = GlobalKey<FormState>();
  String _bankName = '';
  double _currentAmount = 0.0;
  String _initialCode = '';

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
                padding: EdgeInsets.only(top: 60, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create New Bank",
                      style: const TextStyle(
                        fontFamily: "Open Sans",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        height: 27.0 / 20.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Provide required information to create a new bank.",
                      style: const TextStyle(
                        fontFamily: "Open Sans",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                        height: 27.0 / 20.0,
                        color: Colors.white,
                      ),
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: 20, bottom: 20, right: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Bank Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Bank Name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _bankName = value;
                            });
                          },
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Current Amount (\$)'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the current amount';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _currentAmount = double.tryParse(value) ?? 0.0;
                            });
                          },
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Initial Code'),
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the 4-digit code';
                            }
                            if (value.length != 4) {
                              return 'Code must be 4 digits';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _initialCode = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                            
                              // Handle form submission
                              _firestoreService.createBank(
                                _currentAmount,
                                _initialCode,
                                _bankName,
                              );
                              Get.back();
                            }
                          },
                          child: Text('Create Bank'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
