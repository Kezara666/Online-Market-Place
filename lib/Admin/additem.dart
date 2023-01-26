import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneclickv2/Admin/superadmin.dart';

class SuperUserAddItems extends StatefulWidget {
  const SuperUserAddItems({Key? key, required this.userDocumentID})
      : super(key: key);
  final String userDocumentID;
  @override
  State<SuperUserAddItems> createState() => _SuperUserAddItemsState();
}

class _SuperUserAddItemsState extends State<SuperUserAddItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Additem(
                userDocumentID: widget.userDocumentID,
              ),

              // Profilemenu(
              //   userDocumentID: widget.userDocumentID,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class Additem extends StatefulWidget {
  final String userDocumentID;

  const Additem({Key? key, required this.userDocumentID}) : super(key: key);

  @override
  State<Additem> createState() => _AdditemState();
}

final _productname = TextEditingController();
final _productcategory = TextEditingController();
final _productunitprice = TextEditingController();
final _productquantity = TextEditingController();
final _productimgurl = TextEditingController();
final _productdescription = TextEditingController();

List<String> categories = [];

Future _checkFirebaseDataAvailability() async {
  await FirebaseFirestore.instance
      .collection('categories')
      .get()
      .then((snapshot) => snapshot.docs.forEach((document) {
            categories.add(document['category name']);
          }));
  print(categories);
}

class _AdditemState extends State<Additem> {
  @override
  CollectionReference getProductDetails =
      FirebaseFirestore.instance.collection('cart');
  Widget build(BuildContext context) {
    setState(() {
      categories = [];
    });
    return FutureBuilder(
      future: Future.wait([
        _checkFirebaseDataAvailability(),
      ]),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: 400,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                          ),
                          child: Text(
                            'Add Item',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 75, 75, 75)),
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
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: TextFormField(
                            controller: _productname,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Product Name',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 119, 192, 79),
                                    width: 2.0),
                              ),
                              labelStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            validator: ((value) => value!.isEmpty
                                ? 'Please enter product name'
                                : null),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 119, 192, 79),
                                    width: 2.0),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Select Category',
                              style: TextStyle(fontSize: 14),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                            buttonHeight: 60,
                            buttonPadding:
                                const EdgeInsets.only(left: 20, right: 20),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            items: categories
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select your City';
                              }
                            },
                            onChanged: (value) {
                              //Do something when changing the item if you want.
                            },
                            onSaved: (value) {
                              // selectedValue = value.toString();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: TextFormField(
                            controller: _productunitprice,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Unit Price',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 119, 192, 79),
                                    width: 2.0),
                              ),
                              labelStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            validator: ((value) => value!.isEmpty
                                ? 'Please enter product name'
                                : null),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: TextFormField(
                            controller: _productquantity,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Quantity',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 119, 192, 79),
                                    width: 2.0),
                              ),
                              labelStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            validator: ((value) => value!.isEmpty
                                ? 'Please enter product name'
                                : null),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: TextFormField(
                            controller: _productimgurl,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Image URL',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 119, 192, 79),
                                    width: 2.0),
                              ),
                              labelStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            validator: ((value) => value!.isEmpty
                                ? 'Please enter product name'
                                : null),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: TextFormField(
                            controller: _productdescription,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Description',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 119, 192, 79),
                                    width: 2.0),
                              ),
                              labelStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            validator: ((value) => value!.isEmpty
                                ? 'Please enter product name'
                                : null),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: GestureDetector(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(7000, 50),
                                    primary: const Color.fromARGB(
                                        255, 119, 192, 79)),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('products')
                                      .add({
                                    'Product Name': _productname.text,
                                    'Category': _productcategory.text,
                                    'Unit Price': _productunitprice.text,
                                    'Quantity Available': _productquantity.text,
                                    'Image Source': _productimgurl.text,
                                    'product Description':
                                        _productdescription.text,
                                  });
                                  this.setState(() {
                                    _productname.clear();
                                    _productcategory.clear();
                                    _productunitprice.clear();
                                    _productquantity.clear();
                                    _productimgurl.clear();
                                    _productdescription.clear();
                                  });
                                  showDialogBox2();
                                },
                                child: const Text('Add Now'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          );
        }
        return Text("Loading...");
      }),
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

// Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           'Add new item',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: 
//         ),
//       ),
//     );