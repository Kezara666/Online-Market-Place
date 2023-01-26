import 'package:flutter/material.dart';
import 'package:oneclickv2/login/login.dart';

class CongratulationsPage extends StatefulWidget {
  const CongratulationsPage({Key? key}) : super(key: key);

  @override
  State<CongratulationsPage> createState() => _CongratulationsPageState();
}

class _CongratulationsPageState extends State<CongratulationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                  child: Text(
                    'Congratulations!',
                    style: TextStyle(
                        fontSize: 30, color: Color.fromARGB(255, 119, 192, 79)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    'Your account has been created',
                    style: TextStyle(
                        fontSize: 22, color: Color.fromARGB(255, 75, 75, 75)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    'Now you can start using OneClick!\n Happy shopping!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 75, 75, 75)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(100, 30),
                          // fixedSize: (7000, 50),

                          primary: const Color.fromARGB(255, 119, 192, 79)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: const Text(
                        'Continue',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
