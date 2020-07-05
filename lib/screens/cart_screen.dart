import 'dart:io';

import 'package:boltecommerce/lang/appLocale.dart';
import 'package:boltecommerce/providers/cart.dart' show Cart;
import 'package:boltecommerce/screens/Address_screen.dart';
import 'package:boltecommerce/screens/HomePage.dart';
import 'package:boltecommerce/screens/featured.dart';
import 'package:boltecommerce/widget/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeId = "/Cart";

  @override
  Widget build(BuildContext context) {
    final cartPro = Provider.of<Cart>(context, listen: false);
    final translate = AppLocale.of(context);
//    final orderPro = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              translate.getTranslated('cart'),
              style: TextStyle(fontSize: 30, letterSpacing: 1),
            ),
          ),
          Expanded(
            child: cartPro.itemCount <= 0
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          translate.getTranslated('no_item'),
                          style: TextStyle(fontSize: 18),
                        ),
                        InkWell(
                          child: Text(
                            translate.getTranslated('lets_shopping'),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          onTap: () => Navigator.of(context)
                              .pushNamed(FeaturedPage.routeId),
                        ),
                      ],
                    ),
                  )
                :
                   Consumer<Cart>(
                    builder: (context, cartPro, _) => ListView.builder(
                      itemBuilder: (context, index) => CartItem(
                        title: cartPro.items.values.toList()[index].title,
                        id: cartPro.items.values.toList()[index].id,
                        img: cartPro.items.values.toList()[index].img,
                        price: cartPro.items.values.toList()[index].price,
                        quantity:
                            cartPro.items.values.toList()[index].quantity,
                        productId: cartPro.items.keys.toList()[index],
                      ),
                      itemCount: cartPro.items.length,
                    ),
                  ),

          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  cartPro.itemCount <= 0
                      ? showDialog(
                          context: context,
                          builder: (context) => Platform.isIOS
                              ? CupertinoAlertDialog(
                                  title:
                                      Text(translate.getTranslated('warning')),
                                  content: Text(translate
                                      .getTranslated('warning_content')),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text(translate
                                          .getTranslated('warning_content')),
                                    ),
                                    CupertinoDialogAction(
                                      onPressed: () => Navigator.of(context)
                                          .pushReplacementNamed(
                                              HomePage.routeId),
                                      child: Text(
                                          translate.getTranslated('go_home')),
                                    ),
                                  ],
                                )
                              : AlertDialog(
                                  title:
                                      Text(translate.getTranslated('warning')),
                                  content: Text(translate
                                      .getTranslated('warning_content')),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text(
                                        translate
                                            .getTranslated('warning_button'),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () => Navigator.of(context)
                                          .pushReplacementNamed(
                                              HomePage.routeId),
                                      child: Text(
                                        translate.getTranslated('go_home'),
                                      ),
                                    ),
                                  ],
                                ),
                        )
                      : Navigator.of(context).pushNamed(AddressScreen.routeId);
                },
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
                      translate.getTranslated("continue"),
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
