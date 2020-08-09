import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:google_sign_in/google_sign_in.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:socioGram/helpers/global_user_helper.dart';

class AuthMethodHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();
  static String _errorMessage;

  static String get errorMessage {
    return _errorMessage;
  }

  static void setMessage(String message) {
    _errorMessage = message;
  }

  static Future<void> signInWithGoogle() async {
    FirebaseUser user;

    bool isSignedIn = await _googleSignIn.isSignedIn();

    if (isSignedIn)
      user = await _auth.currentUser();
    else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      user = (await _auth.signInWithCredential(credential)).user;

      await Firestore.instance.collection('users').document(user.uid).setData({
        'id': user.uid,
        'userName': user.displayName,
        'email': user.email,
        'image': user.photoUrl,
        'phoneNumber': user.phoneNumber,
        'bio': null,
        "timeStamp": DateTime.now(),
      });
    }
  }

  static Future<void> getAuthenticatedUserData() async {
    FirebaseUser user;
    user = await _auth.currentUser();
    print(await Firestore.instance
        .collection('users')
        .document(user.uid)
        .get()
        .then((dataSnapshot) {
      return (dataSnapshot.data);
    }));

    ThisUserHelper.getUserData(await Firestore.instance
        .collection('users')
        .document(user.uid)
        .get()
        .then((dataSnapshot) {
      return (dataSnapshot.data);
    }));
  }

  static void logout() {
    _googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }

  static Future<void> signInWithEmail(
      String email, String password, bool isLogin, BuildContext context) async {
    AuthResult authResult;
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await authResult.user.sendEmailVerification();
      }
    } on PlatformException catch (error) {
      throw error;
    } catch (error) {
      throw error;
    }
  }

  static Future<void> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    final AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token);
    AuthResult authResult = await _auth.signInWithCredential(credential);

    if (authResult.additionalUserInfo.isNewUser) {
      final token = result.accessToken.token;
      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
      final profile = jsonDecode(graphResponse.body);
      print(profile);
      await Firestore.instance
          .collection('users')
          .document(authResult.user.uid)
          .setData({
        'userName': authResult.user.displayName,
        'email': authResult.user.email,
      });
    }
  }
}
