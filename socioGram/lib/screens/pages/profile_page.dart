import 'package:flutter/material.dart';
import 'package:socioGram/helpers/auth_method_helper.dart';
import 'package:socioGram/helpers/global_user_helper.dart';
import 'package:socioGram/widgets/header_app_bar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: null,
                  iconSize: 25),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Profile",
                // textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Signatra",
                  fontSize: .0,
                  letterSpacing: 2.0,
                ),
              ),
              background: Image.network(ThisUserHelper.globalUserImage,
                  fit: BoxFit.cover),
            ),
          ),
          //   SliverList(
          //   delegate: SliverChildListDelegate(
          //     [
          //       SizedBox(height: 10),
          //       Text(
          //         "₹ ${loadedProduct.price}",
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           color: Colors.grey,
          //           fontSize: 20,
          //         ),
          //       ),
          //       SizedBox(height: 10),
          //       Container(
          //         padding: EdgeInsets.symmetric(horizontal: 5),
          //         width: double.infinity,
          //         child: Text(
          //           loadedProduct.description,
          //           textAlign: TextAlign.center,
          //           softWrap: true,
          //         ),
          //       ),
          //       SizedBox(
          //         height: 800,
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
