import 'package:boltecommerce/providers/cart.dart' show Cart;
import 'package:boltecommerce/screens/Address_screen.dart';
import 'package:boltecommerce/screens/featured.dart';
import 'package:boltecommerce/widget/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeId = "/Cart";

  @override
  Widget build(BuildContext context) {
    final cartPro = Provider.of<Cart>(context);
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
              "Cart",
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
                          "No Item .. ",
                          style: TextStyle(fontSize: 18),
                        ),
                        InkWell(
                          child: Text(
                            "Let's Shopping?",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                          onTap: () => Navigator.of(context)
                              .pushNamed(FeaturedPage.routeId),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) => CartItem(
                      title: cartPro.items.values.toList()[index].title,
                      id: cartPro.items.values.toList()[index].id,
                      img: cartPro.items.values.toList()[index].img,
                      price: cartPro.items.values.toList()[index].price,
                      quantity: cartPro.items.values.toList()[index].quantity,
                      productId: cartPro.items.keys.toList()[index],
                    ),
                    itemCount: cartPro.items.length,
                  ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
//                  orderPro.addOrderToCheckOut(
//                      cartPro.items.values.toList(), cartPro.totalAmount);
//                  cartPro.clear();
                  Navigator.of(context).pushNamed(AddressScreen.routeId);
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
                      "Continue",
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
