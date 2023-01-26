// ignore_for_file: file_names, non_constant_identifier_names, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oneclickv2/home/home.dart';

import 'package:pinput/pinput.dart';

class LoginOTP extends StatefulWidget {
  const LoginOTP(
      {Key? key, required this.PhoneNumber, required this.userDocumentID})
      : super(key: key);
  final String PhoneNumber;
  final String userDocumentID;

  @override
  State<LoginOTP> createState() => _LoginOTPState();
}

final controller = TextEditingController();
final focusNode = FocusNode();
final auth = FirebaseAuth.instance;
bool showError = false;
String _verificationCode = "";

class _LoginOTPState extends State<LoginOTP> {
  @override
  void initState() {
    super.initState();
    _phoneAuth();
  }

  Future _phoneAuth() async {
    await auth.verifyPhoneNumber(
        phoneNumber: widget.PhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) async {
            if (value.user != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Color.fromARGB(255, 64, 255, 128),
                  content: Text(
                    "Login Sucessfull ",
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Home(
                          userDocumentID: widget.userDocumentID,
                        )),
              );
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.orangeAccent,
                content: Text(
                  "Invalid Phone Number",
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
            );
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationCode = verificationId;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Code send faild trying again",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationCode = verificationId;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "OTP Time out",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        },
        timeout: const Duration(seconds: 120));
  }

  @override
  Widget build(BuildContext context) {
    const length = 6;
    const borderColor = Color.fromARGB(255, 119, 192, 79);
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = Color.fromRGBO(222, 231, 240, .57);
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle:
          const TextStyle(fontSize: 20, color: Color.fromARGB(255, 29, 29, 29)),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 375),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 0, top: 0),
                    child: const Image(
                      image: AssetImage('assests/images/logoOneClick-01.png'),
                      width: 75,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: const [
                          Text(
                            'Verify your identity',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: const [
                          Text(
                            '.',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 112, 56)),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'You will receive a 6 digit code via SMS',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'We have sent a code to your phone number',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Pinput(
                    length: length,
                    controller: controller,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    onCompleted: (pin) {
                      setState(() => showError = pin != '555555');
                    },
                    focusedPinTheme: defaultPinTheme.copyWith(
                      height: 68,
                      width: 64,
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: borderColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyWith(
                      decoration: BoxDecoration(
                        color: errorColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Didn\'t receive the code?',
                        style: TextStyle(
                            color: Color(0xFF777777),
                            fontWeight: FontWeight.w200,
                            fontSize: 17),
                      ),
                      TextButton(
                        onPressed: () {
                          _phoneAuth();
                        },
                        child: const Text(
                          'Request again',
                          style: TextStyle(
                              color: Color.fromARGB(255, 119, 192, 79),
                              fontWeight: FontWeight.w900,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(7000, 50),
                              primary: const Color.fromARGB(255, 119, 192, 79)),
                          onPressed: () {
                            _phoneAuth();
                          },
                          child: const Text(
                            'Secure Login',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
