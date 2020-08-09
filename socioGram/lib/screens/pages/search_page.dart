import 'package:flutter/material.dart';
import 'package:socioGram/widgets/header_app_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerAppBar(context, title: "Search"),
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
        child: Text("SP", style: TextStyle(color: Colors.white)),
      )),
    );
  }
}
