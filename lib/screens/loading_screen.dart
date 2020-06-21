import 'dart:async';

import 'package:boltecommerce/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  static const routeId = '/loading';
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacementNamed(HomePage.routeId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/background.png',
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/Logo.png',
              fit: BoxFit.cover,
            ),
            Transform.translate(
              offset: Offset(0, 170),
              child: Center(
                child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
