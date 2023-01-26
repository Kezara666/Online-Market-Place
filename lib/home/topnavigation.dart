import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../cart/cart.dart';
import '../profile/profile.dart';

class TopNavigation extends StatefulWidget {
  const TopNavigation({Key? key, required this.userDocumentID})
      : super(key: key);

  final String userDocumentID;

  @override
  State<TopNavigation> createState() => _TopNavigationState();
}

final String message =
    DateTime.now().hour < 12 ? "Good Morning" : "Good Afternoon";

class _TopNavigationState extends State<TopNavigation> {
  @override
  Widget build(BuildContext context) {
    CollectionReference getUsers =
        FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: getUsers.doc(widget.userDocumentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(
                              userDocumentID: widget.userDocumentID,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Column(
                              children: const [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  child: Icon(Icons.person,
                                      color: Color.fromARGB(255, 119, 192, 79)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Align(
                                    child: Text(
                                      '${data['Name']}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                  ),
                                  Text(
                                    '$message',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 22, 22, 22)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Cart(
                                userDocumentID: widget.userDocumentID,
                              )),
                    )
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, top: 10),
                    child: Column(
                      children: [
                        Column(
                          // Replace with a Row for horizontal icon + text
                          children: const <Widget>[
                            Icon(Icons.shopping_cart,
                                size: 30,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Text("Loading...");
      }),
    );
  }
}
