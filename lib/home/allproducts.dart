// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../product/viewproduct.dart';

// ignore_for_file: file_names

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key, required this.userDocumentID}) : super(key: key);

  final String userDocumentID;
  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List<String> bestSelling = [];
  final auth = FirebaseAuth.instance;
  Future getBestSelling() async {
    await FirebaseFirestore.instance
        .collection('products')
        .orderBy('Product Name', descending: true)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            bestSelling.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      bestSelling = [];
    });
    return Column(
      children: [
        Row(
          children: const [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  "All Products",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 80, 80, 80)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(210, 0, 0, 0),
                child: Text(
                  "See more",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 119, 192, 79)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
            height: 175,
            child: FutureBuilder(
              future: getBestSelling(),
              builder: ((((context, snapshot) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bestSelling.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Container(
                        height: 175,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 234, 233),
                          borderRadius: BorderRadius.circular(10),
                          border: const Border.symmetric(),
                          boxShadow: const [],
                        ),
                        child: getBestSellingDetails(
                          DocumentID: bestSelling[index],
                          userDocumentID: widget.userDocumentID,
                        ),
                      ),
                    );
                  },
                );
              }))),
            ))
      ],
    );
  }
}

class getBestSellingDetails extends StatelessWidget {
  final String DocumentID;
  final String userDocumentID;
  getBestSellingDetails(
      {required this.DocumentID, required this.userDocumentID});
  @override
  Widget build(BuildContext context) {
    CollectionReference getCategories =
        FirebaseFirestore.instance.collection('products');

    return FutureBuilder<DocumentSnapshot>(
      future: getCategories.doc(DocumentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return GestureDetector(
            onTap: () {
              print(DocumentID);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewProduct(
                    itemDocumentID: DocumentID,
                    userDocumentID: userDocumentID,
                  ),
                ),
              );
            },
            child: Container(
              child: (Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: CachedNetworkImage(
                      height: 100,
                      width: 100,
                      imageUrl: '${data['Image Source']}',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const Icon(Icons.image),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                    width: 10,
                  ),
                  Text(
                    '${data['Product Name']}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 53, 53, 53)),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Rs.${data['Unit Price']}.00',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 179, 55, 55)),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
            ),
          );
        }
        return Text("Loading...");
      }),
    );
  }
}
