import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'AdminOrders/adminorders.dart';
import 'additem.dart';
import 'addnewcatgory.dart';

class SuperAdminProfile extends StatefulWidget {
  const SuperAdminProfile({Key? key, required this.userDocumentID})
      : super(key: key);
  final String userDocumentID;
  @override
  State<SuperAdminProfile> createState() => _SuperAdminProfileState();
}

class _SuperAdminProfileState extends State<SuperAdminProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AdminProfileHeader(
                userDocumentID: widget.userDocumentID,
              ),
              SuperAdminMenu(
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

class AdminProfileHeader extends StatefulWidget {
  const AdminProfileHeader({Key? key, required this.userDocumentID})
      : super(key: key);
  final String userDocumentID;
  @override
  State<AdminProfileHeader> createState() => _AdminProfileHeaderState();
}

class _AdminProfileHeaderState extends State<AdminProfileHeader> {
  @override
  Widget build(BuildContext context) {
    CollectionReference getProductDetails =
        FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: getProductDetails.doc(widget.userDocumentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Stack(
            children: <Widget>[
              Positioned(
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    color: Color.fromARGB(255, 231, 41, 57),
                    height: 220.0,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const Home()),
                    // );
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Align(
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    height: 100,
                    width: 100,
                    imageUrl:
                        "https://images.unsplash.com/photo-1491349174775-aaafddd81942?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
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
              Padding(
                padding: EdgeInsets.only(top: 150),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    '${data['Name']}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 22, 22, 22),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 170),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Super Admin',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
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
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class SuperAdminMenu extends StatefulWidget {
  const SuperAdminMenu({Key? key, required this.userDocumentID})
      : super(key: key);
  final String userDocumentID;
  @override
  State<SuperAdminMenu> createState() => _SuperAdminMenuState();
}

List<Map> menuItems = [
  {
    'name': 'Add Product',
    'icon': Icons.add,
    'navigation': '',
  },
  {
    'name': 'Add Category',
    'icon': Icons.category,
    'navigation': '',
  },
  {
    'name': 'Edit Items',
    'icon': Icons.shopping_bag_outlined,
    'navigation': '',
  },
  {
    'name': 'Orders',
    'icon': Icons.shopping_bag_outlined,
    'navigation': '',
  },
];

class _SuperAdminMenuState extends State<SuperAdminMenu> {
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
              if (menuItems[index]['name'] == 'Add Product') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuperUserAddItems(
                      userDocumentID: widget.userDocumentID,
                    ),
                  ),
                );
              } else if (menuItems[index]['name'] == 'Add Category') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => addnewcategory(
                      userDocumentID: widget.userDocumentID,
                    ),
                  ),
                );
              } else if (menuItems[index]['name'] == 'Orders') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminOrders(
                      userDocumentID: widget.userDocumentID,
                    ),
                  ),
                );
              } else if (menuItems[index]['name'] == 'Edit Items') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminOrders(
                      userDocumentID: widget.userDocumentID,
                    ),
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
                          color: const Color.fromARGB(255, 231, 41, 57),
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
