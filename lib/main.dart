import 'package:boltecommerce/providers/cart.dart';
import 'package:boltecommerce/providers/productProviders.dart';
import 'package:boltecommerce/screens/HomePage.dart';
import 'package:boltecommerce/screens/cart_screen.dart';
import 'package:boltecommerce/screens/featured.dart';
import 'package:boltecommerce/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(BoltApp());

class BoltApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProviders(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Bolt eCommerce",
        theme: ThemeData(
          primaryIconTheme: IconThemeData(
            color: Colors.black,
          ),
          primaryColor: Colors.grey,
        ),
        initialRoute: HomePage.routeId,
        routes: {
          HomePage.routeId: (context) => HomePage(),
          FeaturedPage.routeId: (context) => FeaturedPage(),
          ProductDetails.routeId: (context) => ProductDetails(),
          CartScreen.routeId: (context) => CartScreen(),
        },
      ),
    );
  }
}
