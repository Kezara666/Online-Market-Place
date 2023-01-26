import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StoreLocator extends StatefulWidget {
  const StoreLocator({Key? key}) : super(key: key);

  @override
  State<StoreLocator> createState() => _StoreLocatorState();
}

class _StoreLocatorState extends State<StoreLocator> {
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
            'Store Locator',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        imageUrl:
                            "https://img.freepik.com/free-vector/hand-drawn-local-market-sale-banner_23-2149487585.jpg?w=2000",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(
                      height: 120,
                      child: Card(
                          child: Stack(
                        children: [
                          Positioned(
                              top: 10, left: 10, child: Text('Store Locator')),
                          Positioned(
                              top: 35,
                              left: 10,
                              child: Text('T & J Malwana',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          Positioned(
                              top: 55,
                              left: 10,
                              child: Text('Main Street, Malwana',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ))),
                          Positioned(
                              top: 80,
                              left: 10,
                              child: Text('TEL: 0714297222',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ))),
                        ],
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
