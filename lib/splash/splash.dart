import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oneclickv2/home/home.dart';

import '../login/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

late final String userDocumentID;

class _SplashState extends State<Splash> {
  Future _checkFirebaseDataAvailability({String? userPhnenumber}) async {
    CollectionReference getProductDetails =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await getProductDetails.get();
    querySnapshot.docs.forEach((document) {
      if (document['Phone Number'] == userPhnenumber) {
        userDocumentID = document.reference.id;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      userDocumentID: userDocumentID,
                    )));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (FirebaseAuth.instance.currentUser != null) {
        print(
            '${FirebaseAuth.instance.currentUser!.phoneNumber} already signed In');
        _checkFirebaseDataAvailability(
            userPhnenumber: FirebaseAuth.instance.currentUser!.phoneNumber);
      } else {
        print('No user signed In using this device');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Image(
        image: AssetImage('assests/logoOneClick-01.png'),
        width: 150,
      )),
    );
  }
}
