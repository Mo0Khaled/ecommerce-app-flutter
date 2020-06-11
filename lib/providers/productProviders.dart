import 'package:boltecommerce/providers/product.dart';
import 'package:flutter/foundation.dart';

class ProductProviders with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Woman T-Shirt',
      description: 'null',
      img: 'assets/images/t1.png',
      price: 30.0,
    ),
    Product(
      id: 'p2',
      title: 'Man T-Shirt',
      description: 'null',
      img: 'assets/images/t2.png',
      price: 35.2,
    ),
    Product(
      id: 'p3',
      title: 'Shirt',
      description: 'null',
      img: 'assets/images/t3.png',
      price: 45.5,
    ),
  ];

  List<Product> get items => _items;
  Product findById(String id) => _items.firstWhere((prod) => prod.id == id);
  List<Product> get favItems =>
      _items.where((prodItem) => prodItem.isFav).toList();
}
