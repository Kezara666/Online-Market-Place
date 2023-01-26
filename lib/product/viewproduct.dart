import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct(
      {Key? key, required this.itemDocumentID, required this.userDocumentID})
      : super(key: key);
  final String itemDocumentID;
  final String userDocumentID;
  @override
  State<ViewProduct> createState() => _ViewProductState();
}

Future _addtoCart(
    {required String userDocumentID,
    required String productDocumentID,
    required String unitPrice,
    required String Quntity,
    required String Price,
    required String ImageSource,
    required String ProductName,
    required String Name}) async {
  final users = FirebaseFirestore.instance.collection('cart').doc();

  final json = {
    'Product Document ID': productDocumentID,
    'User Document ID': userDocumentID,
    'Quantity': Quntity,
    'Price': Price,
    'Image source ': ImageSource,
    'Product Name': ProductName,
  };
  await users.set(json);
}

Future _addtoWishList(
    {required String userDocumentID,
    required String productDocumentID,
    required String unitPrice,
    required String Quntity,
    required String Price,
    required String ImageSource,
    required String ProductName,
    required String Name}) async {
  final users = FirebaseFirestore.instance.collection('wishlist').doc();

  final json = {
    'Product Document ID': productDocumentID,
    'User Document ID': userDocumentID,
    'Quantity': Quntity,
    'Price': Price,
    'Image source ': ImageSource,
    'Product Name': ProductName,
  };
  await users.set(json);
}

class _ViewProductState extends State<ViewProduct> {
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
      ),
      body: SafeArea(
        child: GetItemInformation(
          DocumentID: widget.itemDocumentID,
          userDocumentID: widget.userDocumentID,
        ),
      ),
    );
  }
}

class GetItemInformation extends StatefulWidget {
  final String DocumentID;
  final String userDocumentID;
  GetItemInformation({required this.DocumentID, required this.userDocumentID});

  @override
  State<GetItemInformation> createState() => _GetItemInformationState();
}

class _GetItemInformationState extends State<GetItemInformation> {
  int _itemCount = 1;
  late String itemPrice;
  double itemPriceDouble = 0.0;
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
          return (Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    child: CachedNetworkImage(
                      height: 300,
                      width: 300,
                      imageUrl: '${data['Image Source']}',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 25,
                          child: Text(
                            '${data['Product Name']}',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 119, 192, 79),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 65,
                          left: 25,
                          child: Text(
                            "Price",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 119, 192, 79),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 65,
                          right: 25,
                          child: Text(
                            'Rs.${data['Unit Price']}.00',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 80, 80, 80),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 85,
                          left: 25,
                          child: Text(
                            "In Stock",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 80, 80, 80),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 85,
                          right: 25,
                          child: Text(
                            "Per Kg",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 80, 80, 80),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 120,
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
                            onPressed: () => setState(() => _itemCount--),
                          ),
                        ),
                        Positioned(
                          left: 70,
                          top: 120,
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
                            onPressed: () => setState(() => _itemCount++),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 30,
                          child: new Text(
                            _itemCount.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 80, 80, 80),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(120, 30),
                              primary: const Color.fromARGB(255, 119, 192, 79),
                            ),
                            onPressed: () => {
                              itemPrice = data['Unit Price'],
                              itemPriceDouble = double.parse(itemPrice),
                              _addtoCart(
                                Name: data['Product Name'],
                                Price:
                                    (_itemCount * itemPriceDouble).toString(),
                                productDocumentID: widget.DocumentID,
                                Quntity: _itemCount.toString(),
                                ImageSource: '${data['Image Source']}',
                                ProductName: '${data['Product Name']}',
                                unitPrice: 'Rs.${data['Unit Price']}.00',
                                userDocumentID: widget.userDocumentID,
                              ),
                              showDialogBox2(),
                            },
                            child: const Text('Add to Cart'),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                primary:
                                    const Color.fromARGB(255, 119, 192, 79),
                                padding: const EdgeInsets.all(5)),
                            child: const Icon(
                              Icons.favorite_border,
                              size: 15,
                            ),
                            onPressed: () => {
                              _addtoWishList(
                                Name: data['Product Name'],
                                Price: '500',
                                productDocumentID: widget.DocumentID,
                                Quntity: '5',
                                ImageSource: '${data['Image Source']}',
                                ProductName: '${data['Product Name']}',
                                unitPrice: 'Rs.${data['Unit Price']}.00',
                                userDocumentID: widget.userDocumentID,
                              ),
                              showDialogBox2(),
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ));
        }
        return Text("Loading...");
      }),
    );
  }

  showDialogBox1() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Success'),
          content: const Text('Product added to wishlist'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  showDialogBox2() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Success'),
          content: const Text('Product added to cart'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
