import 'package:flutter/material.dart';

AppBar headerAppBar(context, {String title, disableBackButton = false}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    automaticallyImplyLeading: disableBackButton ? false : true,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontFamily: "Signatra",
        fontSize: 35.0,
        letterSpacing: 2.0,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    centerTitle: true,
    backgroundColor: Colors.black,
  );
}
