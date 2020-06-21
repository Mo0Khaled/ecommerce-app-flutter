import 'package:boltecommerce/screens/HomePage.dart';
import 'package:flutter/material.dart';

class Confirmation extends StatelessWidget {
  static const routeId = '/confirmation';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/like.png',
                fit: BoxFit.cover,
              ),
              Text(
                "Confirmation",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "You have successfully",
                style: TextStyle(),
              ),
              Text(
                "completed your payment procedure",
                style: TextStyle(),
              ),
              Transform.translate(
                offset: Offset(0, 160),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushNamed(HomePage.routeId),
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
                            "Back to Home",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
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
