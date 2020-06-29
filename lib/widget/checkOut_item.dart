import 'package:boltecommerce/providers/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutItem extends StatelessWidget {
  final OrderItemPro order;

  CheckOutItem(this.order);

  @override
  Widget build(BuildContext context) {
    final dismissProd = Provider.of<Orders>(context, listen: false);

//    var total = price * quantity;
    return Column(
        children: order.products
            .map((prod) => Dismissible(
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
                        content: Text(
                            "Do You Want to remove the Item From The Cart?"),
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
                    elevation: 7,
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 4,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Image.network(
                                prod.img,
                                fit: BoxFit.cover,
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
                                  height: 10,
                                ),
                                Text(
                                  '\$${prod.price * prod.quantity}',
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff374ABE)),
                                ),
                              ],
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Are You Sure?"),
                                      content: Text(
                                          "Do You Want to remove the Item From The Cart?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text("No"),
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            dismissProd.removeItems(order.id);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Yes"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
            .toList());
  }
}
