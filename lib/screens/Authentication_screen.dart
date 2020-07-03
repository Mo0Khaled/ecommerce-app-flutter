import 'package:boltecommerce/model/http_exception.dart';
import 'package:boltecommerce/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

enum AuthMode { signUp, LogIn }

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.LogIn;
  Map<String, String> _authData = {
    'name':'',
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
void _showErrorDialog(String message){
  showDialog(context: context,builder: (context) => AlertDialog(
    title: Text("An Error Occurred!"),
    content: Text(message),
    actions: <Widget>[
      FlatButton(onPressed: ()=> Navigator.of(context).pop(), child: Text("Okay!"),),
    ],
  ),);
}

  Future<void> _submit()async{
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try{
      if(_authMode == AuthMode.LogIn){
       await Provider.of<Auth>(context,listen: false).login(_authData['name'], _authData['email'], _authData['password'],);

  }else{
       await Provider.of<Auth>(context,listen: false).signUp(_authData['name'], _authData['email'], _authData['password'],);
      }
    } on HttpException catch(error){
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
    }
    catch(error){
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
    } else {
      setState(() {
        _authMode = AuthMode.LogIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  _authMode == AuthMode.signUp ? "SignUp"  : "Login",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      if (_authMode == AuthMode.signUp)
                        TextFormField(
                            enabled: _authMode == AuthMode.signUp,
                            decoration: InputDecoration(labelText: "Name"),
                          onSaved: (save){
                              _authData['name'] = save;
                          },
                        ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Email Address"),
                        keyboardType: TextInputType.emailAddress,
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
                        decoration: InputDecoration(labelText: "Password"),
                        obscureText: true,
                        controller: _passwordController,
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
                      if (_authMode == AuthMode.signUp)
                        TextFormField(
                            enabled: _authMode == AuthMode.signUp,
                            decoration:
                                InputDecoration(labelText: "Confirm Password"),
                            obscureText: true,
                            validator: _authMode == AuthMode.signUp
                                ? (val) {
                                    if (val != _passwordController.text) {
                                      return "Password don't match";
                                    }
                                  }
                                : null,
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
                              '${_authMode == AuthMode.signUp ? 'SIGN UP' : 'SIGN IN'}',
                              style: TextStyle(fontSize: 18,color: Colors.white),
                            ),
                          ),
                        ),
                      FlatButton(
                        child: Text(
                            'Already have an acoount ? ${_authMode == AuthMode.LogIn ? 'SIGN UP' : 'SIGN IN'}'),
                        onPressed: _switchMode,
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
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
