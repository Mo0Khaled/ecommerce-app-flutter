import 'package:boltecommerce/providers/addressProvider.dart';
import 'package:boltecommerce/providers/auth.dart';
import 'package:boltecommerce/providers/cart.dart';
import 'package:boltecommerce/providers/order.dart';
import 'package:boltecommerce/providers/productProviders.dart';
import 'package:boltecommerce/screens/Address_screen.dart';
import 'package:boltecommerce/screens/Authentication_screen.dart';
import 'package:boltecommerce/screens/EditedProductScreen.dart';
import 'package:boltecommerce/screens/HomePage.dart';
import 'package:boltecommerce/screens/add_address.dart';
import 'package:boltecommerce/screens/cart_screen.dart';
import 'package:boltecommerce/screens/check_out.dart';
import 'package:boltecommerce/screens/confirmation.dart';
import 'package:boltecommerce/screens/favorite.dart';
import 'package:boltecommerce/screens/featured.dart';
import 'package:boltecommerce/screens/loading_screen.dart';
import 'package:boltecommerce/screens/orders_screen.dart';
import 'package:boltecommerce/screens/payment_screen.dart';
import 'package:boltecommerce/screens/product_details.dart';
import 'package:boltecommerce/screens/user_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(BoltApp());

class BoltApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductProviders>(
          update: (ctx, auth, previousProducts) => ProductProviders(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Bolt eCommerce",
          theme: ThemeData(
            primaryIconTheme: IconThemeData(
              color: Colors.black,
            ),
            primaryColor: Colors.grey,
          ),
          home: auth.isAuth ? HomePage() : AuthenticationScreen(),
//        initialRoute: Loading.routeId,
          routes: {
            HomePage.routeId: (context) => HomePage(),
            FeaturedPage.routeId: (context) => FeaturedPage(),
            ProductDetails.routeId: (context) => ProductDetails(),
            CartScreen.routeId: (context) => CartScreen(),
            FavoriteScreen.routeId: (context) => FavoriteScreen(),
            AddressScreen.routeId: (context) => AddressScreen(),
            AddAddress.routeId: (context) => AddAddress(),
            OrdersScreen.routeId: (context) => OrdersScreen(),
            PaymentScreen.routeId: (context) => PaymentScreen(),
            CheckOut.routeId: (context) => CheckOut(),
            Confirmation.routeId: (context) => Confirmation(),
            Loading.routeId: (context) => Loading(),
            UserProduct.routeId: (context) => UserProduct(),
            EditedProductScreen.routeId: (context) => EditedProductScreen(),
          },
        ),
      ),
    );
  }
}
