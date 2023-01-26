// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../productcategory/categoryList.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key, required this.userDocumentID})
      : super(key: key);
  final String userDocumentID;
  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
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
        SizedBox(
          child: FutureBuilder(
            future: getCategories(),
            builder: (((context, snapshot) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GetCategeoryList(
                      DocumentID: categories[index],
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
            child: Card(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          top: 10,
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: CachedNetworkImage(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              imageUrl: '${data['Image Source']}',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
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
                          child: Text('${data['category name']}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 56, 56, 56))),
                        ),
                        const Positioned(
                          right: 20,
                          top: 10,
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: ClipRRect(
                              child: Icon(Icons.arrow_right),
                            ),
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
