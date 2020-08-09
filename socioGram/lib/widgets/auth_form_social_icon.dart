import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialIcon extends StatelessWidget {
  final String iconSrc;
  final String iconText;
  final Function press;
  const SocialIcon({
    Key key,
    this.iconSrc,
    this.iconText,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: press,
      child: Container(
          width: _screenWidth * 0.36,
          height: _screenHeight * 0.06, 
          margin: EdgeInsets.symmetric(horizontal: 18),
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(110, 110, 255, 0.4),
              Color.fromRGBO(90, 110, 255, 1)
            ]),
            color: Colors.indigo,
            border: Border.all(width: 1.5, color: Colors.white),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                iconSrc,
                height: 21,
                width: 21,
              ),
              SizedBox(width: 20),
              Text(
                iconText,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: "OpenSans",
                    fontSize: 18),
              )
            ],
          )),
    );
  }
}
