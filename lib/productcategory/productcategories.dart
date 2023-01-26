import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'categoryList.dart';

class ProductCategories extends StatefulWidget {
  const ProductCategories({Key? key, required this.userDocumentID})
      : super(key: key);
  final String userDocumentID;
  @override
  State<ProductCategories> createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  List<String> categories = [];
  final auth = FirebaseAuth.instance.currentUser;
  Future getCategories() async {
    await FirebaseFirestore.instance.collection('categories').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            categories.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      categories = [];
    });
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              "Categories",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 80, 80, 80)),
            ),
          ),
        ),
        SizedBox(
          height: 120,
          child: FutureBuilder(
            future: getCategories(),
            builder: ((context, snapshot) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: GetCategeoryDetails(
                              DocumentID: categories[index],
                              userDocumentID: widget.userDocumentID,
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }),
          ),
        ),
      ],
    );
  }
}

class GetCategeoryDetails extends StatefulWidget {
  final String DocumentID;
  final String userDocumentID;
  GetCategeoryDetails({required this.DocumentID, required this.userDocumentID});

  @override
  State<GetCategeoryDetails> createState() => _GetCategeoryDetailsState();
}

class _GetCategeoryDetailsState extends State<GetCategeoryDetails> {
  @override
  Widget build(BuildContext context) {
    CollectionReference getCategories =
        FirebaseFirestore.instance.collection('categories');

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
                      builder: (context) => CategoryItems(
                            category: '${data['category name']}',
                            userDocumentID: widget.userDocumentID,
                          )));
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 238, 238, 238),
                      borderRadius: BorderRadius.circular(100),
                      border: const Border.symmetric(),
                      boxShadow: const [],
                    ),
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(20),
                    child: ClipRRect(
                      child: Image.network(
                        '${data['Image Source']}',
                        scale: 0.8,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                    width: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text('${data['category name']}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 80, 80, 80))),
                  )
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
