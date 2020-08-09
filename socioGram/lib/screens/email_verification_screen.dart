import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user_stream/firebase_user_stream.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/global_user_helper.dart';

class EmailVerificationScreen extends StatelessWidget {
  final FirebaseUser data;

  EmailVerificationScreen(
    this.data,
  );

  void _deleteUser(double height, double width, BuildContext context) {
    showDialog(height, width, context);
  }

  void showDialog(double height, double width, BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 320),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(20),
            height: height * 0.6,
            width: width * 0.9,
            child: Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Image.asset("assets/gifs/delete.gif"),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Material(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "DELETE USER",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Text(
                          "User Account will be permanantly deleted !!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.06,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlatButton(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.green, width: 3),
                              ),
                              onPressed: Navigator.of(context).pop,
                              child: Text(
                                "CANCEL",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            FlatButton(
                              color: Theme.of(context).errorColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: Theme.of(context).errorColor,
                                    width: 3),
                              ),
                              onPressed: () {
                                data.delete();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "DELETE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0.01)).animate(anim),
          child: child,
        );
      },
    );
  }

  void _verifyUser(BuildContext context) async {
    try {
      await data.reload();
      FirebaseUser newUser = await FirebaseAuth.instance.currentUser();

      bool _success = newUser.isEmailVerified;
      if (_success) {
        await Firestore.instance
            .collection('users')
            .document(newUser.uid)
            .setData({
          'id': newUser.uid,
          'userName': ThisUserHelper.globalUserName.trim(),
          'email': ThisUserHelper.globalUserEmail.trim(),
          'image': null,
          'phoneNumber': null,
          'bio': null,
          "timeStamp": DateTime.now(),
        });

        FirebaseUserReloader.reloadCurrentUser((user) => user.isEmailVerified);
      } else
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Please verify your email first."),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
    } catch (error) {
      print(error);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Could not verify email properly"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: _screenHeight * 0.2),
            Text(
              "Sociogram",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Signatra',
                fontSize: 50,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: _screenHeight * 0.05),
            Image.asset("assets/gifs/email.gif"),
            SizedBox(height: _screenHeight * 0.05),
            Text(
              "A verification email has been sent to ${data.email} ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            SizedBox(height: _screenHeight * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Builder(
                  builder: (context) => RaisedButton.icon(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.green, width: 3),
                    ),
                    icon: Icon(Icons.check_circle, color: Colors.green),
                    splashColor: Colors.green,
                    label: Text(
                      "Verify",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w900),
                    ),
                    onPressed: () => _verifyUser(context),
                  ),
                ),
                Builder(
                    builder: (context) => RaisedButton.icon(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Theme.of(context).errorColor, width: 3),
                          ),
                          icon: Icon(Icons.cancel,
                              color: Theme.of(context).errorColor),
                          splashColor: Theme.of(context).errorColor,
                          label: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Theme.of(context).errorColor,
                                fontWeight: FontWeight.w900),
                          ),
                          onPressed: () =>
                              _deleteUser(_screenHeight, _screenWidth, context),
                        )),
              ],
            )
          ],
        ));
  }
}
