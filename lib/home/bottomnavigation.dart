import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../cart/cart.dart';
import '../category/category.dart';
import '../profile/profile.dart';
import '../wishlist/wishlist.dart';
import 'home.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({Key? key, required this.userDocumentID})
      : super(key: key);

  final String userDocumentID;
  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar(
      iconSize: 30.0,
      scaleCurve: Curves.easeOut,
      selectedColor: const Color.fromARGB(255, 119, 192, 79),
      strokeColor: const Color(0x30040307),
      unSelectedColor: const Color(0xffacacac),
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon: const Icon(Icons.home),
          title: const Text("Home"),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.category),
          title: const Text("Categories"),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart),
          title: const Text("Cart"),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.favorite_border),
          title: const Text("Wishlist"),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
          title: const Text("Profile"),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        userDocumentID: widget.userDocumentID,
                      )),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Category(
                        userDocumentID: widget.userDocumentID,
                      )),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Cart(
                        userDocumentID: widget.userDocumentID,
                      )),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Wishlist(
                        userDocumentID: widget.userDocumentID,
                      )),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Profile(
                        userDocumentID: widget.userDocumentID,
                      )),
            );
          }
        });
      },
    );
  }
}
