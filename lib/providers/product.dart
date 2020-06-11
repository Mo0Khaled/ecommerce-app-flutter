import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String img;
  final double price;
  bool isFav;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.img,
    @required this.price,
    this.isFav = false,
  });
  void toggleFav() {
    isFav = !isFav;
    notifyListeners();
  }
}
