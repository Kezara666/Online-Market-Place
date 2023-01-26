import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Addresschanger extends StatefulWidget {
  const Addresschanger({Key? key, required this.userDocumentID})
      : super(key: key);
  final String userDocumentID;
  @override
  State<Addresschanger> createState() => _AddresschangerState();
}

final _addressController = TextEditingController();

class _AddresschangerState extends State<Addresschanger> {
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
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Text('Change your address',
                        style: TextStyle(fontSize: 20))),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 119, 192, 79), width: 2.0),
                    ),
                    labelStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  validator: ((value) =>
                      value!.isEmpty ? 'Please enter your name' : null),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                          'Note: Your address will be changed to address you mentioned above',
                          style: TextStyle(fontSize: 16))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: GestureDetector(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(7000, 40),
                          primary: const Color.fromARGB(255, 119, 192, 79)),
                      onPressed: () async {
                        if (_addressController.text == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.orangeAccent,
                              content: Text(
                                'Please provide valid delivery address',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                            ),
                          );
                        } else {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.userDocumentID)
                              .update({
                            'Address': _addressController.text,
                          });
                          showDialogBox2();
                        }
                      },
                      child: const Text('Confirm Location & Proceed'),
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
          content: const Text('Your address has been successfully changed'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
