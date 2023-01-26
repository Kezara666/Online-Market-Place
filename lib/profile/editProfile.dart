import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneclickv2/login/login.dart';
import 'package:pinput/pinput.dart';

import '../login/loginOTP.dart';

class EditProfileMain extends StatefulWidget {
  const EditProfileMain({Key? key, required this.userDocumentID})
      : super(key: key);
  final String userDocumentID;
  @override
  State<EditProfileMain> createState() => _EditProfileMainState();
}

class _EditProfileMainState extends State<EditProfileMain> {
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
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              EditProfile(
                userDocumentID: widget.userDocumentID,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.userDocumentID}) : super(key: key);
  final String userDocumentID;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

final _nameController = TextEditingController();
final _imageController = TextEditingController();
String phone = '';

class _EditProfileState extends State<EditProfile> {
  Future getuserDetails() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userDocumentID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        phone = documentSnapshot['Phone Number'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          getuserDetails(),
        ]),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color.fromARGB(255, 204, 204, 204),
                    child: Icon(Icons.camera_alt,
                        color: Color.fromARGB(255, 97, 97, 97)),
                  ),
                ),
                Text(
                  'Upload Image doesnt available due to some issues\nplease enter the image url',
                  textAlign: TextAlign.center,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text('Change Your name',
                          style: TextStyle(fontSize: 20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 119, 192, 79),
                            width: 2.0),
                      ),
                      labelStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    validator: ((value) =>
                        value!.isEmpty ? 'Please enter your name' : null),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text('Profile Image URL',
                          style: TextStyle(fontSize: 20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _imageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'URL',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 119, 192, 79),
                            width: 2.0),
                      ),
                      labelStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    validator: ((value) =>
                        value!.isEmpty ? 'Please enter your name' : null),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                            'Note: Your address will be changed to address you mentioned above',
                            style: TextStyle(fontSize: 16))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(7000, 40),
                            primary: const Color.fromARGB(255, 119, 192, 79)),
                        onPressed: () async {
                          if (_imageController.text == '' ||
                              _nameController == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.orangeAccent,
                                content: Text(
                                  'Please provide valid image url and account name',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                ),
                              ),
                            );
                          } else {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userDocumentID)
                                .update({
                              'Name': _nameController.text,
                              'ImageURL': _imageController.text,
                            });
                            showDialogBox2();
                          }
                        },
                        child: const Text('Save changes'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: Text(
                            'You can delete your oneclick Account at any time. If you change your mind, you might not be able to recover it.',
                            style: TextStyle(fontSize: 16))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(7000, 40),
                            primary: Color.fromARGB(255, 221, 58, 66)),
                        onPressed: () async {
                          showDialogBox();
                        },
                        child: const Text('Delete Account'),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Text("Loading...");
        }));
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Alert'),
          content: const Text('Do you want to Delete your account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => ({
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => DeleteOTP(
                    phone: phone,
                    userDocumentID: widget.userDocumentID,
                  ),
                )
              }),
              child: const Text('OK'),
            ),
          ],
        ),
      );
  showDialogBox2() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Success'),
          content: const Text('Your address has been successfully changed'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                if (_imageController.text == '' || _nameController == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.orangeAccent,
                      content: Text(
                        'Please provide valid image url and account name',
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                    ),
                  );
                } else {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.userDocumentID)
                      .update({
                    'Name': _nameController.text,
                    'ImageURL': _imageController.text,
                  });
                  showDialogBox2();
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}

class DeleteOTP extends StatefulWidget {
  const DeleteOTP({Key? key, required this.phone, required this.userDocumentID})
      : super(key: key);
  final String phone;
  final String userDocumentID;
  @override
  State<DeleteOTP> createState() => _DeleteOTPState();
}

// DatePickerController _controller = DatePickerController();

String _selectedDate = '';
final _OTPcontroller = TextEditingController();
final focusNode = FocusNode();
String _verificationCode = "";

class _DeleteOTPState extends State<DeleteOTP> {
  @override
  void initState() {
    super.initState();
    _phoneAuth();
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future _phoneAuth() async {
    await auth.verifyPhoneNumber(
        phoneNumber: widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) async {
            if (value.user != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.orangeAccent,
                  content: Text(
                    "Account Sucsessfully Deleted",
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ),
              );
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.userDocumentID)
                  .delete()
                  .then((value) => print('Item Deleted'));
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.orangeAccent,
                content: Text(
                  "Invalid Phone Number",
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
            );
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationCode = verificationId;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Code send faild trying again",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationCode = verificationId;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "You have taken too long to enter the OTP please try again",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        },
        timeout: const Duration(seconds: 120));
  }

  @override
  Widget build(BuildContext context) {
    const length = 6;
    const borderColor = Color.fromARGB(255, 119, 192, 79);
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = Color.fromRGBO(222, 231, 240, .57);
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle:
          const TextStyle(fontSize: 20, color: Color.fromARGB(255, 29, 29, 29)),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return AlertDialog(
      scrollable: true,
      title: const Text('Select  Delivery Date'),
      content: SizedBox(
        child: Column(
          children: [
            Pinput(
              length: length,
              controller: _OTPcontroller,
              focusNode: focusNode,
              defaultPinTheme: defaultPinTheme,
              // onCompleted: (pin) {
              //   setState(() => showError = pin != '555555');
              // },
              focusedPinTheme: defaultPinTheme.copyWith(
                height: 68,
                width: 64,
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: borderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyWith(
                decoration: BoxDecoration(
                  color: errorColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(600, 40),
            primary: const Color.fromARGB(255, 119, 192, 79),
          ),
          onPressed: () => {
            if (_selectedDate == '')
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please Select Date And Time Slot'),
                  ),
                ),
              }
            else
              {
                Navigator.pop(context, _selectedDate),
              }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
