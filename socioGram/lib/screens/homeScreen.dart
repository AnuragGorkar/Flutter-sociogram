import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:socioGram/helpers/auth_method_helper.dart';

import '../screens/pages/profile_page.dart';
import '../screens/pages/notifications_page.dart';
import '../screens/pages/time_line_page.dart';
import '../screens/pages/search_page.dart';
import '../screens/pages/upload_page.dart';
import '../helpers/global_user_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    AuthMethodHelper.getAuthenticatedUserData();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        iconSize: 30,
        backgroundColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Theme.of(context).primaryColor.withOpacity(0.4),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(""),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text(""),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_camera),
              title: Text(""),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text(""),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(""),
              backgroundColor: Colors.black),
        ],
        onTap: _onTappedBar,
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          TimeLinePage(),
          SearchPage(),
          UploadPage(),
          NotificationsPage(),
          ProfilePage(),
        ],
        onPageChanged: (int value) {
          setState(() {
            _selectedIndex = value;
            AuthMethodHelper.getAuthenticatedUserData();
          });
        },
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });

    _pageController.jumpToPage(value);
  }
}
