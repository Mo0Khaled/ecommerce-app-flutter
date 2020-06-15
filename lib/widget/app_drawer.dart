import 'package:boltecommerce/screens/HomePage.dart';
import 'package:boltecommerce/screens/cart_screen.dart';
import 'package:boltecommerce/screens/favorite.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Home"),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(HomePage.routeId),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Cart"),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(CartScreen.routeId),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Favorites"),
            onTap: () =>
                Navigator.of(context).pushNamed(FavoriteScreen.routeId),
          ),
        ],
      ),
    );
  }
}
