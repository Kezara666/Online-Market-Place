// ignore_for_file: unused_element, avoid_print, body_might_complete_normally_nullable

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../register/register.dart';
import 'loginOTP.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

final _phoneController = TextEditingController();
final _formKey = GlobalKey<FormState>();

final focusNode = FocusNode();
bool showError = false;

var _phone = "";
String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
RegExp regExp = RegExp(patttern);

class _LoginState extends State<Login> {
  final auth = FirebaseAuth.instance;

//Phone number checking function
  Future _checkFirebaseDataAvailability({required String phone}) async {
    FirebaseFirestore.instance
        .collection('users')
        .where('Phone Number', isEqualTo: phone)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // String uid = querySnapshot.docs.first.id;

        print('Document exists on the database');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginOTP(
                    PhoneNumber: phone,
                    userDocumentID: querySnapshot.docs.first.id,
                  )),
        );
      } else {
        print('Document does not exist on the database');
        showDialogBox2();
      }
    });
  }

  // Internect connection checker
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();

    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 375,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: const Image(
                        image: AssetImage('assests/logoOneClick-01.png'),
                        width: 75,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: const Text("Lets sign you in",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400))),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: const Text("Welcome back!",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400))),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: const Text("You have been missed!",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400))),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              obscureText: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Phone Number',
                                hintText: 'Phone Number',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 119, 192, 79),
                                      width: 2.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter valid phone number';
                                } else if (!regExp.hasMatch(value)) {
                                  return 'Please enter valid phone number';
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: GestureDetector(
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(7000, 50),
                                      primary: const Color.fromARGB(
                                          255, 119, 192, 79)),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _checkFirebaseDataAvailability(
                                            phone: _phoneController.text);
                                      });
                                    }
                                  },
                                  child: const Text('Log In'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 65,
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t you have an account? ',
                        style: TextStyle(
                            color: Color(0xFF777777),
                            fontWeight: FontWeight.w200,
                            fontSize: 17),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          );
                        },
                        child: const Text(
                          'Join Now',
                          style: TextStyle(
                              color: Color.fromARGB(255, 119, 192, 79),
                              fontWeight: FontWeight.w900,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  showDialogBox2() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('User Not Found'),
          content: const Text('Please check your phone number and try again'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
