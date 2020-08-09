import 'dart:async';
import "package:flutter/material.dart";

import '../animation/fadeAnimation.dart';
import '../helpers/global_user_helper.dart';
import '../widgets/auth_form.dart';
import '../helpers/auth_method_helper.dart';
import '../screens/loading_splash_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

Widget _positionedStackElement(
    {double left,
    double right,
    double top,
    double bottom,
    double width,
    double height,
    double animationSpeed,
    String imageLoc}) {
  return Positioned(
    left: left,
    right: right,
    top: top,
    bottom: bottom,
    width: width,
    height: height,
    child: FadeAnimation(
      animationSpeed,
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imageLoc), fit: BoxFit.fill),
        ),
      ),
    ),
  );
}

class _AuthScreenState extends State<AuthScreen> {
  Timer _timer;
  var _isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> _submitAuthForm(
    String authMethod,
    bool isLogin,
    BuildContext cntx,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      switch (authMethod) {
        case "Email":
          {
            await AuthMethodHelper.signInWithEmail(
                ThisUserHelper.globalUserEmail,
                ThisUserHelper.globalUserPassword,
                isLogin,
                context);
          }
          break;
        case "Google":
          {
            await AuthMethodHelper.signInWithGoogle();
          }
          break;
        case "Facebook":
          {
            await AuthMethodHelper.signInWithFacebook();
          }
      }
    } catch (error) {
      print(error.message);
      AuthMethodHelper.setMessage("An error occured while ");
      if (error.message != null) {
        AuthMethodHelper.setMessage(error.message);

        setState(() {});

        _timer = new Timer(const Duration(milliseconds: 5100), () {
          setState(() {
            AuthMethodHelper.setMessage(null);
            _isLoading = false;
          });
        });
      } else {
        setState(() {
          AuthMethodHelper.setMessage(null);
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;

    return _isLoading
        ? LoadingSplashScreen()
        : Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      0.0,
                      Container(
                        height: _screenHeight * 0.37,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: const AssetImage(
                                  'assets/images/background.png'),
                              fit: BoxFit.fill),
                        ),
                        child: Stack(
                          children: <Widget>[
                            _positionedStackElement(
                                left: _screenWidth * 0.1,
                                width: _screenWidth * 0.18,
                                height: _screenHeight * 0.23,
                                animationSpeed: 2.0,
                                imageLoc: 'assets/images/light-1.png'),
                            _positionedStackElement(
                                left: _screenWidth * 0.38,
                                width: _screenWidth * 0.15,
                                height: _screenHeight * 0.17,
                                animationSpeed: 3.0,
                                imageLoc: 'assets/images/light-2.png'),
                            _positionedStackElement(
                                right: _screenWidth * 0.1,
                                top: _screenHeight * 0.08,
                                width: 60,
                                height: 60,
                                animationSpeed: 4.0,
                                imageLoc: 'assets/images/clock.png'),
                            Positioned(
                              child: FadeAnimation(
                                5.5,
                                Container(
                                  margin: EdgeInsets.only(
                                      top: _screenHeight * 0.15),
                                  child: Center(
                                    child: const Text(
                                      "Sociogram",
                                      style: const TextStyle(
                                        fontFamily: 'Signatra',
                                        fontSize: 50,
                                        color: Colors.white,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AuthForm(_submitAuthForm),
                  ],
                ),
              ),
            ),
          );
  }
}
