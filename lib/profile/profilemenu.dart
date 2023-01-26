import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oneclickv2/Admin/superadmin.dart';
import 'package:oneclickv2/Orders/myorders.dart';
import 'package:oneclickv2/StoreLocator/storelocator.dart';
import 'package:oneclickv2/wishlist/wishlist.dart';
import '../contactus.dart';
import '../login/login.dart';
import '../privacy.dart';
import '../term.dart';
import 'addresschange.dart';
import 'editProfile.dart';

// class checkUser extends StatefulWidget {
//   const checkUser({Key? key, required this.userDocumentID}) : super(key: key);
//   final String userDocumentID;
//   @override
//   State<checkUser> createState() => _checkUserState();
// }

// String userType = '';
// String userDocumentID = '';
// Future getuserDetails() async {
//   await FirebaseFirestore.instance
//       .collection('users')
//       .doc(userDocumentID)
//       .get()
//       .then((DocumentSnapshot documentSnapshot) {
//     if (documentSnapshot.exists) {
//       print('Document exists on the database');
//       userType = documentSnapshot['Phone Number'];
//     }
//   });
//   checkuser();
// }

// void checkuser() {
//   if (userType == 'SuperAdmin') {
//     SuperAdminMenu(
//       userDocumentID: '',
//     );
//   } else if (userType == 'Vendor') {
//     SuperAdminMenu(
//       userDocumentID: '',
//     );
//   } else {
//     SuperAdminMenu(
//       userDocumentID: '',
//     );
//   }
// }

// class _checkUserState extends State<checkUser> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//        future: Future.wait([
//              getuserDetails(),

//             ]),
//       builder: builder)
//   }
// }

class SuperAdminMenu extends StatefulWidget {
  const SuperAdminMenu({Key? key, required this.userDocumentID})
      : super(key: key);
  final String userDocumentID;
  @override
  State<SuperAdminMenu> createState() => _SuperAdminMenuState();
}

List<Map> menuItems = [
  {
    'name': 'Edit Profile',
    'icon': Icons.edit,
    'navigation': '',
  },
  {
    'name': 'Admin Privileges',
    'icon': Icons.admin_panel_settings,
    'navigation': '',
  },
  {
    'name': 'Your Orders',
    'icon': Icons.shopping_bag_outlined,
    'navigation': '',
  },
  {
    'name': 'Wislist',
    'icon': Icons.favorite_border_outlined,
    'navigation': '',
  },
  {
    'name': 'Address Change',
    'icon': Icons.location_on_outlined,
    'navigation': '',
  },
  {
    'name': 'Store Locator',
    'icon': Icons.location_on_outlined,
    'navigation': '',
  },
  {
    'name': 'Contact Us',
    'icon': Icons.phone_outlined,
    'navigation': '',
  },
  {
    'name': 'Privacy Policy',
    'icon': Icons.privacy_tip_outlined,
    'navigation': '',
  },
  {
    'name': 'Terms & Conditions',
    'icon': Icons.description_outlined,
  },
  {
    'name': 'Logout',
    'icon': Icons.logout,
    'navigation': '',
  },
];

class _SuperAdminMenuState extends State<SuperAdminMenu> {
  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (menuItems[index]['name'] == 'Edit Profile') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileMain(
                      userDocumentID: widget.userDocumentID,
                    ),
                  ),
                );
              } else if (menuItems[index]['name'] == 'Admin Privileges') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuperAdminProfile(
                      userDocumentID: widget.userDocumentID,
                    ),
                  ),
                );
              } else if (menuItems[index]['name'] == 'Your Orders') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyOrders(
                      userDocumentID: widget.userDocumentID,
                    ),
                  ),
                );
              } else if (menuItems[index]['name'] == 'Wislist') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Wishlist(
                      userDocumentID: widget.userDocumentID,
                    ),
                  ),
                );
              } else if (menuItems[index]['name'] == 'Address Change') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Addresschanger(
                      userDocumentID: widget.userDocumentID,
                    ),
                  ),
                );
              } else if (menuItems[index]['name'] == 'Store Locator') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StoreLocator(),
                  ),
                );
              } else if (menuItems[index]['name'] == 'Contact Us') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Contactus(),
                  ),
                );
              } else if (menuItems[index]['name'] == 'Privacy Policy') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Privacy(),
                  ),
                );
              } else if (menuItems[index]['name'] == 'Terms & Conditions') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Terms(),
                  ),
                );
              } else if (menuItems[index]['name'] == 'Logout') {
                signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Container(
                color: Colors.transparent,
                child: SizedBox(
                  child: Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 119, 192, 79),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                          child: Icon(
                            menuItems[index]['icon'],
                            color: const Color.fromARGB(255, 20, 20, 20),
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                        width: 10,
                      ),
                      Positioned(
                        left: 80,
                        top: 10,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            menuItems[index]['name'],
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 53, 53, 53)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 5,
                        right: 20,
                        child: ClipRRect(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 26, 26, 26),
                            size: 25,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Divider(
                          color: Colors.grey,
                          indent: 0,
                          endIndent: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
