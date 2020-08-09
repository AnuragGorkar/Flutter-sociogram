import 'package:flutter/material.dart';
import 'package:socioGram/widgets/header_app_bar.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerAppBar(context, title: "Faourites"),
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
        child: Text("NP", style: TextStyle(color: Colors.white)),
      )),
    );
  }
}
