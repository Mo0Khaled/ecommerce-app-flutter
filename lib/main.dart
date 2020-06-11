import 'package:boltecommerce/providers/productProviders.dart';
import 'package:boltecommerce/screens/HomePage.dart';
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
      ],
      child: MaterialApp(
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
        },
      ),
    );
  }
}
