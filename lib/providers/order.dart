import 'package:boltecommerce/providers/cart.dart';
import 'package:flutter/foundation.dart';

class OrderItemPro {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItemPro({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItemPro> _orders = [];

  List<OrderItemPro> get orders => _orders;

  void addOrder(List<CartItem> cartProduct, double total) {
    _orders.insert(
      0,
      OrderItemPro(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProduct,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
