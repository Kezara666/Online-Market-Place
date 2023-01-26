import 'package:flutter/material.dart';
import 'package:oneclickv2/home/home.dart';

import '../checkout/checkout.dart';
import 'cartitems.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key, required this.userDocumentID}) : super(key: key);

  final String userDocumentID;
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
            Navigator.pop(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        userDocumentID: widget.userDocumentID,
                      )),
            );
          },
        ),
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Cartitems(
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Checkout(
                              userDocumentID: widget.userDocumentID,
                            )),
                  );
                },
                child: const Text('checkout'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
