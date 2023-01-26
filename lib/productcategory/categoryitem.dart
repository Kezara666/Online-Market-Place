// ignore: unused_import
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../product/viewproduct.dart';

class ItemwithAddtocart extends StatefulWidget {
  const ItemwithAddtocart(
      {Key? key, required this.category, required this.userDocumentID})
      : super(key: key);
  final String category;
  final String userDocumentID;
  @override
  State<ItemwithAddtocart> createState() => _ItemwithAddtocartState();
}

class _ItemwithAddtocartState extends State<ItemwithAddtocart> {
  List<String> products = [];
  final auth = FirebaseAuth.instance.currentUser;
  Future getProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .where('Category', isEqualTo: widget.category)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            products.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      products = [];
    });
    return Column(
      children: [
        SizedBox(
          child: FutureBuilder(
            future: getProducts(),
            builder: (((context, snapshot) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return GetCategeoryList(
                      DocumentID: products[index],
                      userDocumentID: widget.userDocumentID,
                    );
                  });
            })),
          ),
        ),
      ],
    );
  }
}

class GetCategeoryList extends StatefulWidget {
  final String DocumentID;
  final String userDocumentID;
  GetCategeoryList({required this.DocumentID, required this.userDocumentID});

  @override
  State<GetCategeoryList> createState() => _GetCategeoryListState();
}

class _GetCategeoryListState extends State<GetCategeoryList> {
  @override
  Widget build(BuildContext context) {
    CollectionReference getCategories =
        FirebaseFirestore.instance.collection('products');

    return FutureBuilder<DocumentSnapshot>(
      future: getCategories.doc(widget.DocumentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewProduct(
                            itemDocumentID: widget.DocumentID,
                            userDocumentID: widget.userDocumentID,
                          )));
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 10,
                          top: 20,
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: CachedNetworkImage(
                              imageUrl: '${data['Image Source']}',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const Icon(Icons.image),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 100,
                          top: 20,
                          child: Text('${data['Product Name']}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 56, 56, 56))),
                        ),
                        Positioned(
                          left: 100,
                          top: 45,
                          // ignore: prefer_interpolation_to_compose_strings
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text("Rs.",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 119, 192, 79),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text('${data['Unit Price']}',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 119, 192, 79),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const Text(" /",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 78, 78, 78))),
                              Text('${data['Quantity Available']}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 78, 78, 78)))
                            ],
                          ),
                        ),
                        Positioned(
                          right: 60,
                          top: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                primary:
                                    const Color.fromARGB(255, 119, 192, 79),
                                padding: const EdgeInsets.all(8)),
                            child: const Icon(
                              Icons.remove,
                              size: 15,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                primary:
                                    const Color.fromARGB(255, 119, 192, 79),
                                padding: const EdgeInsets.all(8)),
                            child: const Icon(
                              Icons.add,
                              size: 15,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Text("Loading...");
      }),
    );
  }
}


// child: Card(
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(
//                           height: 100,
//                           width: MediaQuery.of(context).size.width,
//                           child: Stack(
//                             children: <Widget>[
//                               Positioned(
//                                 left: 10,
//                                 top: 20,
//                                 child: SizedBox(
//                                   width: 70,
//                                   height: 70,
//                                   child: CachedNetworkImage(
//                                     imageUrl: categoryitemList[index]
//                                         ['iconPath'],
//                                     imageBuilder: (context, imageProvider) =>
//                                         Container(
//                                       decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           image: imageProvider,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     placeholder: (context, url) =>
//                                         const Icon(Icons.image),
//                                     errorWidget: (context, url, error) =>
//                                         const Icon(Icons.error),
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 left: 100,
//                                 top: 20,
//                                 child: Text(categoryitemList[index]['name'],
//                                     style: const TextStyle(
//                                         fontSize: 18,
//                                         color:
//                                             Color.fromARGB(255, 56, 56, 56))),
//                               ),
//                               Positioned(
//                                 left: 100,
//                                 top: 45,
//                                 // ignore: prefer_interpolation_to_compose_strings
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     const Text("Rs.",
//                                         style: TextStyle(
//                                             color: Color.fromARGB(
//                                                 255, 119, 192, 79),
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold)),
//                                     Text(categoryitemList[index]['price'],
//                                         style: const TextStyle(
//                                             color: Color.fromARGB(
//                                                 255, 119, 192, 79),
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold)),
//                                     const Text(" /",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             color: Color.fromARGB(
//                                                 255, 78, 78, 78))),
//                                     Text(categoryitemList[index]['quntity'],
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             color: Color.fromARGB(
//                                                 255, 78, 78, 78)))
//                                   ],
//                                 ),
//                               ),
//                               Positioned(
//                                 right: 60,
//                                 top: 35,
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                       shape: const CircleBorder(),
//                                       primary: const Color.fromARGB(
//                                           255, 119, 192, 79),
//                                       padding: const EdgeInsets.all(8)),
//                                   child: const Icon(
//                                     Icons.remove,
//                                     size: 15,
//                                   ),
//                                   onPressed: () {},
//                                 ),
//                               ),
//                               Positioned(
//                                 right: 0,
//                                 top: 35,
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                       shape: const CircleBorder(),
//                                       primary: const Color.fromARGB(
//                                           255, 119, 192, 79),
//                                       padding: const EdgeInsets.all(8)),
//                                   child: const Icon(
//                                     Icons.add,
//                                     size: 15,
//                                   ),
//                                   onPressed: () {},
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),