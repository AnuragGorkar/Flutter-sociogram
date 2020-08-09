import "package:flutter/material.dart";
import 'package:socioGram/helpers/auth_method_helper.dart';

class LoadingSplashScreen extends StatefulWidget {
  @override
  _LoadingSplashScreenState createState() => _LoadingSplashScreenState();
}

class _LoadingSplashScreenState extends State<LoadingSplashScreen> {
  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _screenHeight * 0.2,
                ),
                Text(
                  "Sociogram",
                  style: const TextStyle(
                    fontFamily: 'Signatra',
                    fontSize: 50,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
                AuthMethodHelper.errorMessage != null
                    ? SizedBox(
                        height: _screenHeight * 0.17,
                      )
                    : Container(),
                AuthMethodHelper.errorMessage != null
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            SizedBox(
                              height: _screenHeight * 0.05,
                            ),
                            Text(
                              AuthMethodHelper.errorMessage,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontFamily: " OpenSans"),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      )
                    : Image.asset("assets/gifs/abstract-loader-white.gif"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
