import 'package:boltecommerce/screens/Address_screen.dart';
import 'package:boltecommerce/screens/HomePage.dart';
import 'package:boltecommerce/screens/cart_screen.dart';
import 'package:boltecommerce/screens/favorite.dart';
import 'package:boltecommerce/screens/orders_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Divider(),
            buildDrawerScreens(context, HomePage.routeId, 'Home'),
            buildDrawerScreens(context, HomePage.routeId, 'Profile'),
            buildDrawerScreens(context, CartScreen.routeId, 'My Cart'),
            buildDrawerScreens(context, FavoriteScreen.routeId, 'Favorite'),
            buildDrawerScreens(context, OrdersScreen.routeId, 'My Orders'),
            buildDrawerScreens(context, HomePage.routeId, 'Language'),
            buildDrawerScreens(context, HomePage.routeId, 'Settings'),
          ],
        ),
      ),
    );
  }

  GestureDetector buildDrawerScreens(
      BuildContext context, String routeName, String pageName) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          pageName,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed(routeName),
    );
  }
}
