import 'package:boltecommerce/lang/appLocale.dart';
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
    final translate = AppLocale.of(context);
    final authData = Provider.of<Auth>(context,listen: false);
    return Drawer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Divider(),
            buildDrawerScreens(context, HomePage.routeId, translate.getTranslated('home')),
            buildDrawerScreens(context, HomePage.routeId, translate.getTranslated('profile')),
            buildDrawerScreens(context, CartScreen.routeId, translate.getTranslated('my_cart')),
            buildDrawerScreens(context, FavoriteScreen.routeId, translate.getTranslated('Favorites')),
            buildDrawerScreens(context, OrdersScreen.routeId, translate.getTranslated('my_orders')),
            buildDrawerScreens(context, HomePage.routeId, translate.getTranslated('language')),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  translate.getTranslated('settings'),
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
              translate.getTranslated('logout'),
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
