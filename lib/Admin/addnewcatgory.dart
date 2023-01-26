import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneclickv2/Admin/superadmin.dart';

class addnewcategory extends StatefulWidget {
  final String userDocumentID;

  const addnewcategory({Key? key, required this.userDocumentID})
      : super(key: key);

  @override
  State<addnewcategory> createState() => _addnewcategoryState();
}

final _category = TextEditingController();
final _categoryimgurl = TextEditingController();

class _addnewcategoryState extends State<addnewcategory> {
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
          'Add new category',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Text(
                  'Add Category',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 75, 75, 75)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(255, 204, 204, 204),
                  child: Icon(Icons.camera_alt,
                      color: Color.fromARGB(255, 97, 97, 97)),
                ),
              ),
              Text(
                'Upload Image doesnt available due to some issues\nplease enter the image url',
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  controller: _category,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category Name',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 119, 192, 79), width: 2.0),
                    ),
                    labelStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  validator: ((value) =>
                      value!.isEmpty ? 'Please enter product name' : null),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  controller: _categoryimgurl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category Image URL',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 119, 192, 79), width: 2.0),
                    ),
                    labelStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  validator: ((value) =>
                      value!.isEmpty ? 'Please enter product name' : null),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: GestureDetector(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(7000, 50),
                          primary: const Color.fromARGB(255, 119, 192, 79)),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('categories')
                            .add({
                          'category name': _category.text,
                          'Image Source': _categoryimgurl.text,
                        });
                        this.setState(() {
                          _category.clear();
                          _categoryimgurl.clear();
                        });
                        showDialogBox2();
                        // _addnewProdcut(productName: productName, category: category, unitprice: unitprice, quntity: quntity, imageurl: imageurl, shortdescription: shortdescription)
                      },
                      child: const Text('Add Now'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDialogBox2() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Success'),
          content: const Text('Product Added Successfully'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SuperAdminProfile(
                            userDocumentID: widget.userDocumentID,
                          )),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
