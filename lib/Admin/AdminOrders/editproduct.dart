import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key, required this.userDocumentID}) : super(key: key);
  final String userDocumentID;
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyProductItems(
                userDocumentID: widget.userDocumentID,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyProductItems extends StatefulWidget {
  const MyProductItems({Key? key, required this.userDocumentID})
      : super(key: key);
  final String userDocumentID;
  @override
  State<MyProductItems> createState() => _MyProductItemsState();
}

class _MyProductItemsState extends State<MyProductItems> {
  List<String> Myitems = [];
  Future _checkFirebaseDataAvailability() async {
    await FirebaseFirestore.instance
        .collection('cart')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              Myitems.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          _checkFirebaseDataAvailability(),
        ]),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {}
          return Text("Loading...");
        }));
  }
}
