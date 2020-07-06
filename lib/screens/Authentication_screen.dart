import 'package:boltecommerce/lang/appLocale.dart';
import 'package:boltecommerce/model/http_exception.dart';
import 'package:boltecommerce/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

enum AuthMode { signUp, LogIn }

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.LogIn;
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _slideAnimation = Tween<Offset>(
            begin: Offset(0, -1), end: Offset(0,0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
//    _heightAnimation.addListener(() {
//      setState(() {});
//    });

    _opacityAnimation = Tween<double>(
        begin: 0.0, end:1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("An Error Occurred!"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Okay!"),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.LogIn) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['name'],
          _authData['email'],
          _authData['password'],
        );
      } else {
        await Provider.of<Auth>(context, listen: false).signUp(
          _authData['name'],
          _authData['email'],
          _authData['password'],
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchMode() {
    if (_authMode == AuthMode.LogIn) {
      setState(() {
        _authMode = AuthMode.signUp;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.LogIn;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocale.of(context);
    return Scaffold(
      body: Transform.translate(
        offset: Offset(0, 80),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  _authMode == AuthMode.signUp
                      ? translate.getTranslated('signUp')
                      : translate.getTranslated('logIn'),
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      AnimatedContainer(
                        constraints: BoxConstraints(minHeight:_authMode == AuthMode.signUp ?6.0:0 ,maxHeight:_authMode == AuthMode.signUp ? 120 :0 ),
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInSine,
                        child: FadeTransition(
                          opacity: _opacityAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: TextFormField(
                              enabled: _authMode == AuthMode.signUp,
                              decoration: InputDecoration(
                                  labelText: translate.getTranslated('name')),
                              onSaved: (save) {
                                _authData['name'] = save;
                              },
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: translate.getTranslated('email')),
                        keyboardType: TextInputType.emailAddress,
                        // ignore: missing_return
                        validator: (val) {
                          if (val.isEmpty || !val.contains('@')) {
                            return 'Invalid email!';
                          }
                        },
                        onSaved: (save) {
                          _authData['email'] = save;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: translate.getTranslated('password')),
                        obscureText: true,
                        controller: _passwordController,
                        // ignore: missing_return
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please Enter a Password";
                          } else if (val.length < 5) {
                            return "Too short Password";
                          }
                        },
                        onSaved: (save) {
                          _authData['password'] = save;
                        },
                      ),
//                        if (_authMode == AuthMode.signUp)
                      AnimatedContainer(
                        constraints: BoxConstraints(minHeight: _authMode == AuthMode.signUp ? 60:0, maxHeight:
                        _authMode == AuthMode.signUp ? 120 : 0),
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInSine,
                        child: FadeTransition(
                          opacity: _opacityAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: TextFormField(
                              enabled: _authMode == AuthMode.signUp,
                              decoration: InputDecoration(
                                  labelText:
                                  translate.getTranslated('confirm_password')),
                              obscureText: true,
                              validator: _authMode == AuthMode.signUp
                              // ignore: missing_return
                                  ? (val) {
                                if (val != _passwordController.text) {
                                  return "Password don't match";
                                }
                              }
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (_isLoading)
                        CircularProgressIndicator()
                      else
                        GestureDetector(
                          onTap: _submit,
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.060,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff667EEA),
                                  Color(0xff6597F4),
                                  Color(0xff64B0FD),
                                ],
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${_authMode == AuthMode.signUp ? translate.getTranslated('signUp') : translate.getTranslated('logIn')}',
                              style:
                              TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      FlatButton(
                        child: Text(
                            '${translate.getTranslated('have_account')} ${_authMode == AuthMode.LogIn ? translate.getTranslated('signUp') : translate.getTranslated('logIn')}'),
                        onPressed: _switchMode,
                        padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
