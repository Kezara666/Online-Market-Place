// ignore_for_file: dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({Key? key, required this.userDocumentID}) : super(key: key);

  final String userDocumentID;
  @override
  State<AdminOrders> createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
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
            'Received Orders',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                OrderItems(
                  userDocumentID: widget.userDocumentID,
                ),
              ],
            ),
          ),
        ));
  }
}

class OrderItems extends StatefulWidget {
  const OrderItems({Key? key, required this.userDocumentID}) : super(key: key);
  final String userDocumentID;
  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  String name = '';
  String address = '';
  String phone = '';
  List<String> cartDetals = [];
  Future _checkFirebaseDataAvailability() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              cartDetals.add(document.reference.id);
            }));
    print(cartDetals);
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

  @override
  Widget build(BuildContext context) {
    setState(() {
      cartDetals = [];
    });
    return Column(
      children: [
        SizedBox(
          child: FutureBuilder(
            future: Future.wait([
              _checkFirebaseDataAvailability(),
              getuserDetails(),
            ]),
            builder: ((((context, snapshot) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartDetals.length,
                  itemBuilder: (context, index) {
                    return UsersOrderDetails(
                      DocumentID: cartDetals[index],
                      userDocumentID: widget.userDocumentID,
                      name: name,
                      address: address,
                    );
                  });
            }))),
          ),
        ),
      ],
    );
  }
}

class UsersOrderDetails extends StatefulWidget {
  const UsersOrderDetails(
      {Key? key,
      required this.address,
      required this.userDocumentID,
      required this.DocumentID,
      required this.name})
      : super(key: key);
  final String address;
  final String name;
  final String userDocumentID;
  final String DocumentID;
  @override
  State<UsersOrderDetails> createState() => _UsersOrderDetailsState();
}

class _UsersOrderDetailsState extends State<UsersOrderDetails> {
  @override
  Widget build(BuildContext context) {
    CollectionReference getProductDetails =
        FirebaseFirestore.instance.collection('orders');
    return FutureBuilder<DocumentSnapshot>(
      future: getProductDetails.doc(widget.DocumentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminOrderFullDetails(
                              orderDocumentID: widget.DocumentID,
                              Address: widget.address,
                              Name: widget.name,
                              userDocumentID: widget.userDocumentID,
                              Phone: '${data['Phone Number']}',
                              total: '${data['Total']}',
                              DeliverdDate: '${data['DeliveryDate']}',
                              OrderedDate: '${data['OrderDate']}',
                              orderType: '${data['OrderType']}',
                              TimeSlot: '${data['DeliveryTimeSlot']}',
                            )));
              },
              child: Card(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 205,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 10,
                            top: 10,
                            child: Text('Order ID: ${widget.DocumentID}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 97, 97, 97))),
                          ),
                          Positioned(
                            left: 10,
                            top: 30,
                            child: Text('Order Date: \n${data['OrderDate']}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 97, 97, 97))),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 119, 192, 79),
                                  borderRadius: BorderRadius.circular(5)),
                              width: 120,
                              height: 30,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Status: ${data['Status']}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            top: 70,
                            child: Text('Total: ${data['Total']}',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          Positioned(
                            left: 10,
                            top: 95,
                            child: Text('Name: ${widget.name}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          Positioned(
                            left: 10,
                            top: 120,
                            child: SizedBox(
                              width: 200,
                              child: Text('Address: ${widget.address}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            top: 180,
                            child: Text('Phone: ${data['Phone Number']}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: SizedBox(
                              width: 100,
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(100, 40),
                                  primary: Color.fromARGB(255, 228, 73, 68),
                                ),
                                onPressed: () => {},
                                child: const Text('Cancel order'),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Text("Loading...");
      }),
    );
  }
}

class AdminOrderFullDetails extends StatefulWidget {
  const AdminOrderFullDetails(
      {Key? key,
      required this.OrderedDate,
      required this.DeliverdDate,
      required this.TimeSlot,
      required this.orderType,
      required this.userDocumentID,
      required this.orderDocumentID,
      required this.total,
      required this.Name,
      required this.Address,
      required this.Phone})
      : super(key: key);

  final String userDocumentID;
  final String orderDocumentID;
  final String Phone;
  final String total;
  final String Name;
  final String Address;
  final String OrderedDate;
  final String DeliverdDate;
  final String TimeSlot;
  final String orderType;
  @override
  State<AdminOrderFullDetails> createState() => _AdminOrderFullDetailsState();
}

class _AdminOrderFullDetailsState extends State<AdminOrderFullDetails> {
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
          'Order: ${widget.orderDocumentID}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SizedBox(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "ORDER SUMMARY",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                    child: Text(
                      "Order ID:\n${widget.orderDocumentID}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                    child: Text(
                      "Name:\n${widget.Name}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                    child: Text(
                      "Address:\n${widget.Address}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                    child: Text(
                      "Ammount:\nRs.${widget.total}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                    child: Text(
                      "Orderd Date:\n${widget.OrderedDate}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                    child: Text(
                      "Order Delivery Date:\n${widget.DeliverdDate}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                    child: Text(
                      "Order Type:\n${widget.orderType}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                    child: Text(
                      "Customer requested time:\n${widget.TimeSlot}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                    child: Text(
                      "Orderd Items:",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                    child: OrderDescription(
                      userDocumentID: widget.userDocumentID,
                      orderDocumentID: widget.orderDocumentID,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 60),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 119, 192, 79)),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('orders')
                              .doc(widget.orderDocumentID)
                              .update({
                            'Status': "Delivered",
                          });
                          showDialogBox2();
                        },
                        child: const Text('Confirm Order Deliverd'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  showDialogBox2() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Success'),
          content: const Text('Order has been successfully Delivered'),
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

class OrderDescription extends StatefulWidget {
  const OrderDescription(
      {Key? key, required this.orderDocumentID, required this.userDocumentID})
      : super(key: key);
  final String userDocumentID;
  final String orderDocumentID;
  @override
  State<OrderDescription> createState() => _OrderDescriptionState();
}

class _OrderDescriptionState extends State<OrderDescription> {
  List<dynamic> itemids = [];
  int itemSize = 0;

  Future getItems2() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderDocumentID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        itemids.add(documentSnapshot['itemids']);
        itemSize = itemids[0].length;
        print(itemids);
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      itemSize = 0;
      itemids = [];
    });
    CollectionReference getProductDetails =
        FirebaseFirestore.instance.collection('orders');
    return Column(
      children: [
        SizedBox(
          child: FutureBuilder(
            future: Future.wait([getItems2()]),
            builder: (((context, snapshot) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemSize,
                  itemBuilder: (context, index) {
                    return FutureBuilder<DocumentSnapshot>(
                      future:
                          getProductDetails.doc(widget.orderDocumentID).get(),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Card(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        left: 10,
                                        top: 5,
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Item code:',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 194, 193, 193))),
                                              TextSpan(
                                                  text:
                                                      ' ${data['itemids'][index]}',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 119, 192, 79))),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 30,
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Item name:',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 194, 193, 193))),
                                              TextSpan(
                                                  text:
                                                      ' ${data['itemnames'][index]}',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 68, 68, 68))),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 50,
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Item price:',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 194, 193, 193))),
                                              TextSpan(
                                                  text:
                                                      ' ${data['itemprices'][index]}',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 68, 68, 68))),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 50,
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Item Quntity:',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 194, 193, 193))),
                                              TextSpan(
                                                  text:
                                                      ' ${data['itemquantities'][index]}',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 68, 68, 68))),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return Text("Loading...");
                      }),
                    );
                  });
            })),
          ),
        ),
      ],
    );
  }
}
