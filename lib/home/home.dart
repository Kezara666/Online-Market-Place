// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:oneclickv2/home/topnavigation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../productcategory/productcategories.dart';
import 'BestSelling.dart';
import 'allproducts.dart';
import 'backgroundshape.dart';
import 'bottomnavigation.dart';
import 'homebanner.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.userDocumentID}) : super(key: key);

  final String userDocumentID;
  @override
  State<Home> createState() => _HomeState();
}

final Uri _url = Uri.parse("https://wa.me/message/XWQWHCETW7N7P1");

class _HomeState extends State<Home> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();

    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 320,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: BackgroundColorShape(),
                    ),
                    Positioned(
                      child: TopNavigation(
                        userDocumentID: widget.userDocumentID,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Positioned(top: 60, left: 0, right: 0, child: HomeBanner()),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              ),
              ProductCategories(
                userDocumentID: widget.userDocumentID,
              ),
              const SizedBox(
                height: 25,
              ),
              BestSelling(
                userDocumentID: widget.userDocumentID,
              ),
              const SizedBox(
                height: 25,
              ),
              AllProducts(userDocumentID: widget.userDocumentID),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _launchUrl();
        },
        label: const Text('Bulk Order'),
        backgroundColor: const Color.fromARGB(255, 119, 192, 79),
        icon: const Icon(Icons.add),
      ),
      bottomNavigationBar: Bottomnavigation(
        userDocumentID: widget.userDocumentID,
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
