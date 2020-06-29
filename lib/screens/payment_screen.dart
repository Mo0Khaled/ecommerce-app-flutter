import 'package:boltecommerce/providers/cart.dart';
import 'package:boltecommerce/providers/order.dart';
import 'package:boltecommerce/screens/check_out.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  static const routeId = '/payment';

  @override
  Widget build(BuildContext context) {
    final orderPro = Provider.of<Orders>(context);
    final cartPro = Provider.of<Cart>(context,listen: false);

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
              "Payment",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListView(
              children: <Widget>[
                Container(
                  height: 179,
                  width: 283,
                  child: Image.asset(
                    'assets/images/visa.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  height: 179,
                  width: 283,
                  child: Image.asset(
                    'assets/images/visa.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  height: 179,
                  width: 283,
                  child: Image.asset(
                    'assets/images/visa.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Subtotal",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Text("\$${cartPro.totalAmount}"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Discount",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Text("0.0"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Shipping",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Text("0.0"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Text("\$${cartPro.totalAmount}"),
                  ],
                ),
              ],
            ),
          ),
//          Spacer(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(CheckOut.routeId),
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
                        "Checkout",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
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
