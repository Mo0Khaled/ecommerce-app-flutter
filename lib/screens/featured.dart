import 'package:boltecommerce/widget/featuredList.dart';
import 'package:flutter/material.dart';

class FeaturedPage extends StatelessWidget {
  static const routeId = "/Featured";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
//        leading: Icon(Icons.expand_less),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Featured",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: FeaturedList(),
          ),
        ],
      ),
    );
  }
}
