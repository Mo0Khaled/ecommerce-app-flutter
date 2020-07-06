import 'package:boltecommerce/lang/appLocale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  static const routeId = '/language';

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  _english() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', 'en');
  }

  _arabic() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', 'ar');
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocale.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(translate.getTranslated('language')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,top: 10),
              child: FlatButton(onPressed: _english, child: Text("English",style: TextStyle(fontSize: 25),)),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: FlatButton(onPressed: _arabic, child: Text("العربية",style: TextStyle(fontSize: 25),)),
            ),
          ),

        ],
      ),
    );
  }
}
