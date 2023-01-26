import 'package:flutter/material.dart';

import 'package:oneclickv2/wishlist/wishlistitems.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key, required this.userDocumentID}) : super(key: key);

  final String userDocumentID;
  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
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
          'Wishlist',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ItemWishList(
                userDocumentID: widget.userDocumentID,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        child: FittedBox(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 119, 192, 79)),
                onPressed: () {
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Checkout(
                  //               userDocumetID: widget.userDocumentID,
                  //             )));
                },
                child: const Text('Buy Now'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
