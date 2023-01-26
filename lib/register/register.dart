// ignore_for_file: avoid_print, body_might_complete_normally_nullable, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneclickv2/register/congratulations.dart';
import 'package:oneclickv2/register/registerOTP.dart';
import '../login/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

final _nameController = TextEditingController();
final _phoneontroller = TextEditingController();
final _addressontroller = TextEditingController();
final List<String> cityList = ['Biyagama'];

final _formKey = GlobalKey<FormState>();

String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
RegExp regExp = RegExp(patttern);

class _RegisterState extends State<Register> {
  Future _checkFirebaseDataAvailability({required String phone}) async {
    FirebaseFirestore.instance
        .collection('users')
        .where('Phone Number', isEqualTo: phone)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        print('Document exists on the database');
        showDialogBox2();
      } else {
        print('Document does not exist on the database');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterOTP(
              Name: _nameController.text,
              Address: _addressontroller.text,
              City: 'Biyagama',
              PhoneNumber: _phoneontroller.text,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                    image: AssetImage('assests/images/logoOneClick-01.png'),
                    width: 75,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: const Text("Hello!",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w400))),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: const Text("Sign up and start using OneClick!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400))),
                const SizedBox(
                  height: 25,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 119, 192, 79),
                                  width: 2.0),
                            ),
                            labelStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          validator: ((value) =>
                              value!.isEmpty ? 'Please enter your name' : null),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _phoneontroller,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 119, 192, 79),
                                  width: 2.0),
                            ),
                            labelStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
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
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _addressontroller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Address',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 119, 192, 79),
                                  width: 2.0),
                            ),
                            labelStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          validator: ((value) => value!.isEmpty
                              ? 'Please enter your address'
                              : null),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 119, 192, 79),
                                  width: 2.0),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            'Biyagama',
                            style: TextStyle(fontSize: 14),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                          buttonHeight: 60,
                          buttonPadding:
                              const EdgeInsets.only(left: 20, right: 20),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          items: cityList
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select your City';
                            }
                          },
                          onChanged: (value) {
                            //Do something when changing the item if you want.
                          },
                          onSaved: (value) {
                            // selectedValue = value.toString();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
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
                                  primary:
                                      const Color.fromARGB(255, 119, 192, 79)),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CongratulationsPage(),
                                  ),
                                );
                                // _checkFirebaseDataAvailability(
                                //     phone: _phoneontroller.text);
                              },
                              child: const Text('Sign up'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 180,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                          color: Color(0xFF777777),
                          fontWeight: FontWeight.w200,
                          fontSize: 17),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: const Text(
                        'Log In',
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
      )),
    );
  }

  showDialogBox2() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Phone Number already exists'),
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
