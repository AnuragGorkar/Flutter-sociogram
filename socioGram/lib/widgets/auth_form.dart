import "package:flutter/material.dart";

import '../helpers/global_user_helper.dart';
import '../widgets/auth_form_or_divider.dart';
import '../widgets/auth_form_social_icon.dart';
import '../animation/fadeAnimation.dart';

class AuthForm extends StatefulWidget {
  final Future<void> Function(
    String authMethod,
    bool isLogin,
    BuildContext cntx,
  ) submitFunction;

  AuthForm(this.submitFunction);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  AnimationController _animationController;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;
  var _isLogin;
  var _passwordInvisible = true;
  var _userEmail = ThisUserHelper.globalUserEmail;
  var _userName = ThisUserHelper.globalUserName;
  var _userPassword = ThisUserHelper.globalUserPassword;

  void _trySubmit(String _authMethod, BuildContext context) async {
    bool isValid;
    if (_authMethod == "Email") {
      isValid = _formKey.currentState.validate();
    } else
      isValid = true;

    FocusScope.of(context).unfocus();

    if (isValid) {
      ThisUserHelper.setGlobalUserEmail(_userEmail);
      ThisUserHelper.setGlobalUserPassword(_userPassword);
      ThisUserHelper.setGlobalUserUserName(_userName);
      _formKey.currentState.save();
      await widget.submitFunction(
        _authMethod,
        _isLogin,
        context,
      );
    }
  }

  void initState() {
    super.initState();
    _isLogin = true;
    ThisUserHelper.initializeUserCredentials();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
    _slideAnimation =
        Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    final _screenWidth = MediaQuery.of(context).size.width;

    return FadeAnimation(
      5.5,
      Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    height: _screenHeight * 0.1,
                    width: _screenWidth * 0.81,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.2),
                      ),
                    ),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      key: const ValueKey('email'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value.isEmpty ||
                            !value.contains('@') ||
                            !value.contains('.com'))
                          return 'Please enter valid email address.';
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: "Email Address",
                        labelStyle: TextStyle(
                          color: Colors.indigo,
                        ),
                      ),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                  ),
                  AnimatedContainer(
                    constraints: BoxConstraints(
                      minHeight: !_isLogin ? _screenHeight * 0.05 : 0,
                      maxHeight: !_isLogin ? _screenHeight * 0.1 : 0,
                    ),
                    width: _screenWidth * 0.81,
                    padding: EdgeInsets.all(4),
                    duration: Duration(milliseconds: 270),
                    curve: Curves.easeIn,
                    child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: TextFormField(
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            key: const ValueKey('userName'),
                            enabled: !_isLogin,
                            autocorrect: true,
                            textCapitalization: TextCapitalization.words,
                            validator: !_isLogin
                                ? (value) {
                                    if (value.isEmpty || value.length < 4)
                                      return "Minimum length for UserName is 4 characters.";
                                    return null;
                                  }
                                : null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "User Name",
                              labelStyle: TextStyle(
                                color: Colors.indigo,
                              ),
                            ),
                            onSaved: (value) {
                              _userName = value;
                            },
                          ),
                        )),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.2),
                      ),
                    ),
                  ),
                  Container(
                    height: _screenHeight * 0.1,
                    width: _screenWidth * 0.81,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.2),
                      ),
                    ),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 6)
                          return "Minimum length for password is 6 characters.";
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.indigo,
                        ),
                        suffixIcon: GestureDetector(
                          child: Icon(
                            _passwordInvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.indigo,
                          ),
                          onTap: () {
                            setState(() {
                              _passwordInvisible = !_passwordInvisible;
                            });
                          },
                        ),
                      ),
                      obscureText: _passwordInvisible,
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                  ),
                  SizedBox(height: _screenHeight * 0.05),
                  RaisedButton.icon(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white, width: 1.5),
                    ),
                    icon: Icon(_isLogin ? Icons.input : Icons.person_add,
                        color: Colors.white),
                    splashColor: Colors.white,
                    label: Text(
                      _isLogin ? "Login" : "Signup",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => _trySubmit("Email", context),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin
                        ? "Create New Account"
                        : "I already have an account!"),
                    onPressed: () {
                      if (_isLogin == true) {
                        setState(() {
                          _isLogin = false;
                        });
                        _animationController.forward();
                      } else if (_isLogin == false) {
                        setState(() {
                          _isLogin = true;
                        });
                        _animationController.reverse();
                      }
                    },
                  ),
                  OrDivider(_isLogin),
                  SocialIcon(
                    iconSrc: "svg images/whiteGoogle.svg",
                    iconText: "Google",
                    press: () => _trySubmit("Google", context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
