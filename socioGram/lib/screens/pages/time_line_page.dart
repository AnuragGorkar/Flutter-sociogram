import 'package:flutter/material.dart';
import 'package:socioGram/widgets/header_app_bar.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerAppBar(context, title: "Sociogram"),
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
        child: Text("TLP", style: TextStyle(color: Colors.white)),
      )),
    );
  }
}
