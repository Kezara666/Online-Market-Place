import 'package:flutter/material.dart';
import 'package:oneclickv2/profile/profileheader.dart';
import 'package:oneclickv2/profile/profilemenu.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.userDocumentID}) : super(key: key);
  final String userDocumentID;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Profileheader(
                userDocumentID: widget.userDocumentID,
              ),
              SuperAdminMenu(
                userDocumentID: widget.userDocumentID,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
