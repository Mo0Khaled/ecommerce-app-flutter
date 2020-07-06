import 'dart:convert';
import 'package:http/http.dart' as http;
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
  final String authToken;
  final String userId;
  Orders(this.authToken,this.userId, this._orders);

  List<OrderItemPro> get orders => _orders;
  OrderItemPro findById(String id) => _orders.firstWhere((order) => order.id == id);


  double get totalAmount {
    var total = 0.0;
    _orders.forEach((orderItemPro) {
      total += orderItemPro.amount;
    });
    return total;
  }

  Future<void> fetchAndSetOrders() async {
    final url = 'https://boltecommerce-11687.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItemPro> loadedOrder = [];
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (data == null) {
      return;
    }
    data.forEach((orderId, orderData) {
      loadedOrder.add(
        OrderItemPro(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price'],
                  discount: item['discount'],
                  shipping: item['shipping'],
                  img: item['img'],
                ),
              )
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime']),
        ),
      );
    });
    _orders =loadedOrder.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final time = DateTime.now();
    final url = 'https://boltecommerce-11687.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': time.toIso8601String(),
          'products': cartProduct
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                    'img': cp.img,
                  })
              .toList(),
        }));
    _orders.insert(
      0,
      OrderItemPro(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProduct,
        dateTime: time,
      ),
    );
    notifyListeners();
  }

  void removeItems(String productId) {
    _orders.removeWhere((element) => element.id == productId);
    notifyListeners();
  }
}
