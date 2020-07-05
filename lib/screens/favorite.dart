import 'package:boltecommerce/lang/appLocale.dart';
import 'package:boltecommerce/screens/cart_screen.dart';
import 'package:boltecommerce/widget/featuredList.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeId = '/Fav';
  @override
  Widget build(BuildContext context) {
    final translate = AppLocale.of(context);

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
          Icon(Icons.favorite,color: Colors.red,),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () => Navigator.of(context).pushNamed(CartScreen.routeId),),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              translate.getTranslated('Favorites'),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              child: FeaturedList(_showFavOnly),
            ),
          ),
        ],
      ),
    );
  }
}
