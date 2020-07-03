import 'package:boltecommerce/providers/auth.dart';
import 'package:boltecommerce/screens/HomePage.dart';
import 'package:boltecommerce/screens/cart_screen.dart';
import 'package:boltecommerce/screens/favorite.dart';
import 'package:boltecommerce/screens/orders_screen.dart';
import 'package:boltecommerce/screens/user_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context,listen: false);
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
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              onTap: () {
                authData.userId == 'TAkaObz0d8NEfPCSkCovdoWri203' ||authData.userId == 'KPk06mKhdvWts0w6sm4Y4MFxrM22' ? Navigator.of(context).pushNamed(UserProduct.routeId) :
                    showDialog(context: context,builder: (context)=> AlertDialog(
                      title: Text('Hello!'),
                      content: Text(
                          "Please This is Page For The Owner Only , Thanks for Understanding"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () =>
                              Navigator.of(context).pop(true),
                          child: Text("Okay"),
                        ),
                      ],
                    ),
                    );
              },
            ),
           GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'LogOut',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/');
            authData.logOut();
          },
        ),

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
