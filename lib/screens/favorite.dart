import 'package:boltecommerce/widget/featuredList.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeId = '/Fav';
  @override
  Widget build(BuildContext context) {
    var _showFavOnly = true;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
//        leading: IconButton(
//          icon: Icon(Icons.expand_less),
//          onPressed: () { },
//        ),
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
              "Favorites",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: FeaturedList(_showFavOnly),
          ),
        ],
      ),
    );
  }
}
