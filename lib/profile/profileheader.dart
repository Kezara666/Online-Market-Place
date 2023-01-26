import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profileheader extends StatefulWidget {
  const Profileheader({Key? key, required this.userDocumentID})
      : super(key: key);
  final String userDocumentID;
  @override
  State<Profileheader> createState() => _ProfileheaderState();
}

class _ProfileheaderState extends State<Profileheader> {
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
                    color: const Color.fromARGB(255, 119, 192, 79),
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
