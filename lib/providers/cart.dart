import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CartItem with ChangeNotifier {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final double discount;
  final double shipping;
  final String img;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.discount,
    @required this.shipping,
    @required this.img,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items => _items;
  int get itemCount => items.length;
  double get totalAmount {
    var total = 0.0;
    _items.forEach(
      (key, cartItem) {
        total += cartItem.price * cartItem.quantity;
      },
    );
    return total;
  }
  double get totalAfterDiscount {
    var totalDiscount = 0.0;
    _items.forEach((key, cartItem) {
      totalDiscount += cartItem.price * cartItem.quantity - allDiscount;
    });
    return totalDiscount;
  }
  double get allDiscount {
    var allDiscount = 0.0;
    _items.forEach((key, cartItem) {
      allDiscount +=  cartItem.discount * cartItem.quantity;
    });
    return allDiscount;
  }


  Future<void> addItem(String productId, double price, String title,double discount,double shipping, String img) async{


     if (_items.containsKey(productId)) {
       _items.update(
         productId,
             (exCartItem) => CartItem(
           id: DateTime.now().toString(),
           title: exCartItem.title,
           quantity: exCartItem.quantity + 1,
           price: exCartItem.price,
           discount: exCartItem.discount,
           shipping: exCartItem.shipping,
           img: exCartItem.img,
         ),
       );
     } else {
       _items.putIfAbsent(
         productId,
             () => CartItem(
           id:  DateTime.now().toString(),
           title: title,
           price: price,
           discount: discount,
           shipping: shipping,
           img: img,
           quantity: 1,
         ),
       );
     }
     notifyListeners();

  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (items[productId].quantity > 1) {
      _items.update(
        productId,
        (exCartItem) => CartItem(
          id: exCartItem.id,
          title: exCartItem.title,
          quantity: exCartItem.quantity - 1,
          price: exCartItem.price,
          discount: exCartItem.discount,
          shipping: exCartItem.shipping,
          img: exCartItem.img,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void addOne(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) => CartItem(
          id: value.id,
          title: value.title,
          quantity: value.quantity + 1,
          price: value.price,
          discount: value.discount,
          shipping: value.shipping,
          img: value.img,
        ),
      );
    }
    notifyListeners();
  }

  void removeOne(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) => CartItem(
          id: value.id,
          title: value.title,
          quantity: value.quantity <= 0 ? value.quantity : value.quantity - 1,
          price: value.price,
          discount: value.discount,
          shipping: value.shipping,
          img: value.img,
        ),
      );
    }
    notifyListeners();
  }

  void removeItems(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
