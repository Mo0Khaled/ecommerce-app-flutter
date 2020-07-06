import 'package:boltecommerce/helpers/customPage.dart';
import 'package:boltecommerce/lang/appLocale.dart';
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
import 'package:boltecommerce/screens/language_screen.dart';
import 'package:boltecommerce/screens/loading_screen.dart';
import 'package:boltecommerce/screens/orders_screen.dart';
import 'package:boltecommerce/screens/payment_screen.dart';
import 'package:boltecommerce/screens/product_details.dart';
import 'package:boltecommerce/screens/user_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getString('lang');
//  prefs.setString('lang', 'en');
//  Locale locale = Locale(prefs.getString('lang'),'');
  runApp(BoltApp());
}

class BoltApp extends StatelessWidget {
//  final Locale locale;
//
//  BoltApp(this.locale);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),

        ChangeNotifierProxyProvider<Auth, ProductProviders>(
          update: (ctx, auth, previousProducts) => ProductProviders(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth,AddressProvider>(
          update: (ctx,auth,previousAddress) => AddressProvider(auth.token, auth.userId, previousAddress == null ? [] : previousAddress.addresses),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) =>
            MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Bolt eCommerce",
          theme: ThemeData(
            fontFamily: 'SourceSansPro',
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionRoute(),
              }
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            iconTheme: IconThemeData(),
            appBarTheme:AppBarTheme(color: Colors.white,elevation: 0),
            primaryIconTheme: IconThemeData(
              color: Colors.black,
            ),
            primaryColor: Colors.grey,
          ),
//            locale:locale,
          localizationsDelegates: [
            AppLocale.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en',''),
            Locale('ar',''),
          ],
          localeResolutionCallback: (currentLocale,supportedLocale){
            if(currentLocale.languageCode != null){
              for(Locale locale in supportedLocale){
                if(currentLocale.languageCode == locale.languageCode){
                  return currentLocale;
                }
              }
            }
            return supportedLocale.first;
          },
          home:  auth.isAuth
              ? Loading()
              : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Loading()
                : AuthenticationScreen(),
          ),
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
            LanguageScreen.routeId:(context) => LanguageScreen(),
          },
        ),
      ),
    );
  }
}
