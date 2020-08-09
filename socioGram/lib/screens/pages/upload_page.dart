import 'package:flutter/material.dart';
import 'package:socioGram/widgets/header_app_bar.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerAppBar(context, title: "Upload Image"),
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
        child: Text("UP", style: TextStyle(color: Colors.white)),
      )),
    );
  }
}
