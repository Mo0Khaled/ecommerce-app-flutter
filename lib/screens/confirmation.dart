import 'package:boltecommerce/lang/appLocale.dart';
import 'package:boltecommerce/screens/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Confirmation extends StatelessWidget {
  static const routeId = '/confirmation';

  @override
  Widget build(BuildContext context) {
    final translate = AppLocale.of(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 200,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/like.png',
                  fit: BoxFit.cover,
                ),
                Text(
                  translate.getTranslated('confirmation'),
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  translate.getTranslated('message_one'),
                  style: TextStyle(),
                ),
                Text(
                  translate.getTranslated('message_two'),
                  style: TextStyle(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushReplacementNamed(HomePage.routeId),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff667EEA),
                        Color(0xff6597F4),
                        Color(0xff64B0FD),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      translate.getTranslated('back_home'),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
