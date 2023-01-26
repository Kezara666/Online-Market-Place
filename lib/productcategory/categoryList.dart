// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'categoryitem.dart';

class CategoryItems extends StatefulWidget {
  const CategoryItems(
      {Key? key, required this.userDocumentID, required this.category})
      : super(key: key);
  final String userDocumentID;
  final String category;
  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
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
          title: Text(
            widget.category,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  child: Container(
                    color: const Color.fromARGB(255, 119, 192, 79),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          left: 20,
                        ),
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 119, 192, 79),
                                fontSize: 16),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 119, 192, 79),
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 119, 192, 79),
                                  width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 119, 192, 79),
                                  width: 0.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.category,
                          style: TextStyle(
                              color: Color.fromARGB(255, 49, 49, 49),
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                ItemwithAddtocart(
                  category: widget.category,
                  userDocumentID: widget.userDocumentID,
                ),
              ],
            ),
          ),
        ));
  }
}
