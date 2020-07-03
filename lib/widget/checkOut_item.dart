import 'package:flutter/material.dart';
class CheckOutItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String img;


  CheckOutItem({
      this.id, this.productId, this.title, this.quantity, this.price, this.img});

  @override
  Widget build(BuildContext context) {
    var total = price * quantity;
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 138,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Image.network(
                  img,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, color: Color(0xff374ABE)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
