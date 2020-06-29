import 'package:boltecommerce/providers/cart.dart';
import 'package:boltecommerce/providers/order.dart';
import 'package:boltecommerce/screens/confirmation.dart';
import 'package:boltecommerce/widget/checkOut_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatelessWidget {
  static const routeId = '/checkOut';

  @override
  Widget build(BuildContext context) {
    final orderPro = Provider.of<Orders>(context);
    final cartPro = Provider.of<Cart>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Checkout",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.builder(
                itemBuilder: (context, index) => CheckOutItem(
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
                      Text("\$${cartPro.totalAmount.toStringAsFixed(2)}"),
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
                      Text("\$${cartPro.totalAmount.toStringAsFixed(2)}"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OrderButton(orderPro: orderPro, cartPro: cartPro),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.orderPro,
    @required this.cartPro,
  }) : super(key: key);

  final Orders orderPro;
  final Cart cartPro;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (widget.cartPro.totalAmount <= 0 || _isLoading)  ? null :
          () async {
        setState(() {
          _isLoading =true;
        });
       await widget.orderPro.addOrder(
            widget.cartPro.items.values.toList(), widget.cartPro.totalAmount);
        widget.cartPro.clear();
        Navigator.of(context)
            .pushReplacementNamed(Confirmation.routeId);
        setState(() {
          _isLoading = false;
        });
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
          child: _isLoading ? CircularProgressIndicator() : Text(
            "Buy",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
