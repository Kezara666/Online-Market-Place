import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ItemWishList extends StatefulWidget {
  const ItemWishList({Key? key, required this.userDocumentID})
      : super(key: key);
  final String userDocumentID;
  @override
  State<ItemWishList> createState() => _ItemWishListState();
}

class _ItemWishListState extends State<ItemWishList> {
  List<String> cartDetals = [];

  Future _checkFirebaseDataAvailability() async {
    await FirebaseFirestore.instance
        .collection('wishlist')
        .where('User Document ID', isEqualTo: widget.userDocumentID)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              cartDetals.add(document.reference.id);
            }));
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
            future: _checkFirebaseDataAvailability(),
            builder: (((context, snapshot) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartDetals.length,
                  itemBuilder: (context, index) {
                    return UsersCart(
                      DocumentID: cartDetals[index],
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

class UsersCart extends StatefulWidget {
  final String DocumentID;
  final String userDocumentID;

  UsersCart({required this.DocumentID, required this.userDocumentID});

  @override
  State<UsersCart> createState() => _UsersCartState();
}

class _UsersCartState extends State<UsersCart> {
  Future removeItem() async {
    await FirebaseFirestore.instance
        .collection('wishlist')
        .doc(widget.DocumentID)
        .delete()
        .then((value) => print('Item Deleted'));
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference getProductDetails =
        FirebaseFirestore.instance.collection('wishlist');

    return FutureBuilder<DocumentSnapshot>(
      future: getProductDetails.doc(widget.DocumentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Card(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
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
                            imageUrl: '${data['Image source ']}',
                            imageBuilder: (context, imageProvider) => Container(
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
                        left: 45,
                        top: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              primary: const Color.fromARGB(255, 69, 199, 149),
                              padding: const EdgeInsets.all(5)),
                          child: const Icon(
                            Icons.favorite_border,
                            size: 15,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Positioned(
                        left: 100,
                        top: 35,
                        child: Text('${data['Product Name']}',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ),
                      Positioned(
                        left: 100,
                        top: 60,
                        child: Text('Quntity: ${data['Quantity']} ',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 226, 226, 226))),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: Row(
                          children: [
                            Text('Total Price: Rs.${data['Price']}.00',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 46, 46, 46))),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 179, 178, 178),
                              ),
                              onPressed: () {
                                // showDialogBox2();
                              },
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 10,
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  primary:
                                      const Color.fromARGB(255, 229, 230, 229),
                                  padding: const EdgeInsets.all(8)),
                              child: const Icon(
                                Icons.remove,
                                size: 15,
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text('${data['Quantity']}',
                                      style: TextStyle(fontSize: 20))),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  primary:
                                      const Color.fromARGB(255, 69, 199, 149),
                                  padding: const EdgeInsets.all(8)),
                              child: const Icon(
                                Icons.add,
                                size: 15,
                              ),
                              onPressed: () {},
                            ),
                          ],
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
  }

  // showDialogBox2() => showCupertinoDialog<String>(
  //       context: context,
  //       builder: (BuildContext context) => CupertinoAlertDialog(
  //         title: const Text('ALERT'),
  //         content: const Text('Do you want to remove this item from the cart?'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () async {
  //               Navigator.pop(context, 'Cancel');
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               removeItem();
  //               Navigator.pushReplacement(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => Cart(
  //                           userDocumentID: widget.userDocumentID,
  //                         )),
  //               );
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
}
