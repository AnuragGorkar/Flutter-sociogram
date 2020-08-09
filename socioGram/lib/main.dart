import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user_stream/firebase_user_stream.dart';

import './screens/email_verification_screen.dart';
import './screens/loading_splash_screen.dart';
import './screens/authScreen.dart';
import './screens/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SocioGram',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentTextTheme: TextTheme(
          headline6: TextStyle(fontFamily: "OpenSans")
        )
      ),
      home: StreamBuilder(
        stream: FirebaseUserReloader.onAuthStateChangedOrReloaded,
        builder: (context, AsyncSnapshot<FirebaseUser> userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return LoadingSplashScreen();
          }
          if (userSnapshot.hasData) {
            if (userSnapshot.data.isEmailVerified)
              return HomeScreen();
            else
              return EmailVerificationScreen(userSnapshot.data);
          }
          return AuthScreen();
        },
      ),
    );
  }
}
