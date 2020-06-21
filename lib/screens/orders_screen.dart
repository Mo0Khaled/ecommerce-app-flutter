import 'package:boltecommerce/providers/order.dart';
import 'package:boltecommerce/widget/orderItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeId = '/Order';

  @override
  Widget build(BuildContext context) {
    final orderPro = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "My Orders",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) =>
                  OrderItem(orderPro.orders[index]),
              itemCount: orderPro.orders.length,
            ),
          ),
        ],
      ),
    );
  }
}
