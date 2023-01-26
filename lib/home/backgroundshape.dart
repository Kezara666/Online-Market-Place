import 'package:flutter/material.dart';

class BackgroundColorShape extends StatefulWidget {
  const BackgroundColorShape({Key? key}) : super(key: key);

  @override
  State<BackgroundColorShape> createState() => _BackgroundColorShapeState();
}

class _BackgroundColorShapeState extends State<BackgroundColorShape> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurveClipper(),
      child: Container(
        color: const Color.fromARGB(255, 119, 192, 79),
        height: 220.0,
      ),
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
