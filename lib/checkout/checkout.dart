import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneclickv2/checkout/sheduleDate.dart';
import 'package:oneclickv2/checkout/sheduleTimeSlot.dart';
import 'package:oneclickv2/home/home.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key, required this.userDocumentID}) : super(key: key);
  final String userDocumentID;

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Usercheckoutdetails(
                userDocumentID: widget.userDocumentID,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Usercheckoutdetails extends StatefulWidget {
  const Usercheckoutdetails({Key? key, required this.userDocumentID})
      : super(key: key);

  final String userDocumentID;

  @override
  State<Usercheckoutdetails> createState() => _UsercheckoutdetailsState();
}

class _UsercheckoutdetailsState extends State<Usercheckoutdetails> {
  double total = 0;
  double ammount = 0;
  String name = '';
  String address = '';
  String phone = '';
  String city = '';
  String Delivery = '';
  String OrderType = '';
  String DeliveryDate = '';
  String DeliveryTImeSlot = '';
  bool _isSheduleTimeSlot = false;
  bool _isSheduleDelivery = false;
  bool isVisable = false;
  List<String> cartDetals = [];
  List<String> userDetails = [];
  List<String> productids = [];
  List<String> productnames = [];
  List<String> productQuantities = [];
  List<String> productPrices = [];
  Future _checkFirebaseDataAvailability() async {
    await FirebaseFirestore.instance
        .collection('cart')
        .where('User Document ID', isEqualTo: widget.userDocumentID)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              cartDetals.add(document.reference.id);
              productids.add(document['Product Document ID']);
              productnames.add(document['Product Name']);
              productQuantities.add(document['Quantity']);
              productPrices.add(document['Price']);

              total = total + double.parse(document['Price']);
              print(total);
              String price = document['Price'];
              print(price);
            }));
  }

  Future getuserDetails() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userDocumentID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        name = documentSnapshot['Name'];
        address = documentSnapshot['Address'];
        phone = documentSnapshot['Phone Number'];
        print(name);
      }
    });
  }

  addOrder() async {
    await FirebaseFirestore.instance.collection('orders').add({
      'User Document ID': widget.userDocumentID,
      'Name': name,
      'Address': address,
      'Phone Number': phone,
      'City': 'Biyagama',
      'Total': ammount,
      'itemids': productids,
      'itemnames': productnames,
      'itemquantities': productQuantities,
      'itemprices': productPrices,
      'Status': 'Pending',
      'OrderType': OrderType,
      'OrderDate': DateTime.now().toString(),
      'DeliveryDate': DeliveryDate,
      'DeliveryTimeSlot': DeliveryTImeSlot,
    });
  }

  clearCart() async {
    await FirebaseFirestore.instance
        .collection('cart')
        .where('User Document ID', isEqualTo: widget.userDocumentID)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              document.reference.delete();
            }));
  }

  @override
  CollectionReference getProductDetails =
      FirebaseFirestore.instance.collection('users');
  Widget build(BuildContext context) {
    setState(() {
      cartDetals = [];
      total = 0;
      userDetails = [];
      productids = [];
      productnames = [];
      productQuantities = [];
      productPrices = [];
    });
    return FutureBuilder(
      future: Future.wait([
        _checkFirebaseDataAvailability(),
        getuserDetails(),
      ]),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Column(
                children: const [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: Text(
                        'Delivery Address',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Card(
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 20,
                            left: 10,
                            child: Text(
                              '$name',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 60,
                            left: 10,
                            child: Text(
                              'Delivery Address :',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 80,
                            left: 10,
                            child: Text(
                              "$address",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 65, 65, 65),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 60,
                            right: 10,
                            child: Text(
                              'Contact Number :',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 80,
                            right: 10,
                            child: Text(
                              "$phone",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 179, 178, 178),
                                ),
                                onPressed: null),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              Column(
                children: const [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: Text(
                        'Delivery Address',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => (setState(() => {
                      isVisable = true,
                      Delivery = '200',
                      ammount = total + 200,
                      OrderType = 'Express',
                      _isSheduleDelivery = false,
                    })),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        Card(
                          child: Column(children: <Widget>[
                            SizedBox(
                              height: 150,
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              child: Stack(
                                children: const <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Icon(
                                        Icons.local_shipping,
                                        color:
                                            Color.fromARGB(255, 114, 114, 114),
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Express Delivery',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 66, 66, 66),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '15 Minutes',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 65, 65, 65),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Delivery Fee : Rs 200',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 65, 65, 65),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        GestureDetector(
                          onTap: () => ({
                            setState(() => {
                                  isVisable = true,
                                  Delivery = '150',
                                  ammount = total + 150,
                                  OrderType = 'Sheduled Delivery',
                                  _isSheduleDelivery = true,
                                }),
                          }),
                          child: Card(
                            child: Column(children: <Widget>[
                              SizedBox(
                                height: 150,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                child: Stack(
                                  children: const <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Icon(
                                          Icons.av_timer,
                                          color: Color.fromARGB(
                                              255, 192, 192, 192),
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Sheduled Delivery',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 66, 66, 66),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '1 - 5 Days',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 65, 65, 65),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Free Delivery',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Color.fromARGB(255, 65, 65, 65),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: _isSheduleDelivery,
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    child: FittedBox(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(255, 119, 192, 79)),
                            onPressed: () => ({
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const SheduleDate(),
                              ).then((val) {
                                setState(() {
                                  DeliveryDate = val;
                                });
                              }),
                            }),
                            child: const Text('Select Delivery Date'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: _isSheduleDelivery,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    child: FittedBox(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(255, 119, 192, 79)),
                            onPressed: () => ({
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const SheduleTimeSlot(),
                              ).then((val) {
                                setState(() {
                                  DeliveryTImeSlot = val;
                                });
                              }),
                            }),
                            child: const Text('Delivery Time Slot'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 15,
                      child: Text(
                        'Delivery Fee',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 15,
                      child: Text(
                        'Rs $Delivery',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 15,
                      child: Text(
                        'Total',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 15,
                      child: Text(
                        '$total',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 15,
                      child: Text(
                        'Ammount Payable',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 15,
                      child: Text(
                        '$ammount',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isVisable,
                child: SizedBox(
                  child: FittedBox(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 119, 192, 79)),
                          onPressed: () {
                            if (OrderType == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.orangeAccent,
                                  content: Text(
                                    "Please Select Order Type",
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black),
                                  ),
                                ),
                              );
                            } else if (OrderType == 'Sheduled Delivery' &&
                                    DeliveryDate == '' ||
                                DeliveryTImeSlot == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.orangeAccent,
                                  content: Text(
                                    "Please Select Delivery Date and Time",
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black),
                                  ),
                                ),
                              );
                            } else if (OrderType == 'Express') {
                              addOrder();
                              clearCart();
                              showDialogBox2();
                            } else {
                              addOrder();
                              clearCart();
                              showDialogBox2();
                            }
                          },
                          child: const Text('Place Order'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
          content: const Text('Order Placed Successfully'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(
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
