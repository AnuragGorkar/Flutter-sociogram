import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final bool _isLogin;

  OrDivider(this._isLogin);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              buildDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  _isLogin ? "Login with" : "Signup with",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              buildDivider(),
            ],
          ),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: const Divider(
        color: Colors.grey,
        height: 1.9,
      ),
    );
  }
}
