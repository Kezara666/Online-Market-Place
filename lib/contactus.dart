import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Contactus extends StatefulWidget {
  const Contactus({Key? key}) : super(key: key);

  @override
  State<Contactus> createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: SizedBox(
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: const Image(
                                image:
                                    AssetImage('assests/logoOneClick-01.png'),
                                width: 75,
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                            ),
                            child: Text('GET IN TOUCH WITH US',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 75, 75, 75))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 25,
                            ),
                            child: Text('Our team is always ready to help you',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 75, 75, 75))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 25,
                            ),
                            child: Text('Send us an email',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 75, 75, 75))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                            ),
                            child: Text('oneclick92@gmail.com',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 75, 75, 75))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 25,
                            ),
                            child: Text('Or call us',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 75, 75, 75))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                            ),
                            child: Text('077 123 4567',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 75, 75, 75))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 50,
                            ),
                            child: Text(
                                'Thank you for your support! Happy shopping!',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 75, 75, 75))),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
