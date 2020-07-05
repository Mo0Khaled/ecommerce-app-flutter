import 'package:boltecommerce/lang/appLocale.dart';
import 'package:boltecommerce/providers/order.dart';
import 'package:boltecommerce/widget/orderItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeId = '/Order';

  @override
  Widget build(BuildContext context) {
    final translate = AppLocale.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context,listen: false).fetchAndSetOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text("error"),
              );
            } else {
              return RefreshIndicator(
                onRefresh: ()=> Provider.of<Orders>(context,listen: false).fetchAndSetOrders(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        translate.getTranslated('my_orders'),
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Expanded(
                      child: Consumer<Orders>(
                        builder: (context,orderPro,_) =>
                         ListView.builder(
                          itemBuilder: (context, index) =>
                              OrderItem(orderPro.orders[index]),
                          itemCount: orderPro.orders.length,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
