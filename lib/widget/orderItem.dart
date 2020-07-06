import 'package:boltecommerce/lang/appLocale.dart';
import 'package:boltecommerce/providers/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final OrderItemPro order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    final translate = AppLocale.of(context);
    return Column(
      children: order.products
          .map(
            (prod) => Card(
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 125,
                  child: Row(
                    children: <Widget>[
                      translate.locale.languageCode == 'en'
                          ? Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Container(
                                width: 120,
//                                height: 120,
                                child: Image.network(
                                  prod.img,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 15),
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
                            child: InkWell(
                              onTap: () {
//                                Navigator.of(context).pushNamed(ProductDetails.routeId,arguments: order.products[0].);
                              },
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
                                    translate.getTranslated('order_again'),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
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
          )
          .toList(),
    );
  }
}
