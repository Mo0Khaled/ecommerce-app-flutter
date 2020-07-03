import 'package:boltecommerce/providers/cart.dart';
import 'package:boltecommerce/providers/order.dart';
import 'package:boltecommerce/providers/product.dart';
import 'package:boltecommerce/providers/productProviders.dart';
import 'package:boltecommerce/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  final OrderItemPro order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    final dismissProd = Provider.of<Orders>(context, listen: false);
    final id = Provider.of<Product>(context).id;
    return Column(
      children: order.products
          .map(
            (prod) => Dismissible(
              key: ValueKey(prod.id),
              background: Container(
                color: Theme.of(context).errorColor,
                child: Icon(
                  Icons.delete,
                  size: 40,
                  color: Colors.white,
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => dismissProd.removeItems(order.id),
              confirmDismiss: (direction) {
                return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Are You Sure?"),
                    content:
                        Text("Do You Want to remove the Item From The Cart?"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text("No"),
                      ),
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 115,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            width: 120,
                            child: Image.network(
                              prod.img,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              prod.title,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '\$${prod.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff374ABE)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              DateFormat("dd/mm hh:mm").format(order.dateTime),
                            ),
                            Transform.translate(
                              offset: Offset(0, 8),
                              child: Consumer<ProductProviders>(
                                builder:(ctx,l,_) =>InkWell(
                                  onTap: ()=> Navigator.of(context).pushNamed(
                                      ProductDetails.routeId,
                                      arguments: l.findById(id)),
                                  child: Container(
                                    width: 114,
                                    height: 39,
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
                                        "Order Again",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
