import 'package:boltecommerce/model/http_exception.dart';
import 'package:boltecommerce/providers/product.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProviders with ChangeNotifier {
  List<Product> _items = [
//    Product(
//      id: 'p1',
//      title: 'Woman T-Shirt',
//      review: 4.5,
//      description:
//          'A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of existence in this spot, which was created for the bliss of souls like mine.',
//      img: 'assets/images/t1.png',
//      price: 30.0,
//    ),
//    Product(
//      id: 'p2',
//      title: 'Woman T-Shirt',
//      review: 2.5,
//      description:
//          'A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of existence in this spot, which was created for the bliss of souls like mine.',
//      img: 'assets/images/t2.png',
//      price: 35.2,
//    ),
//    Product(
//      id: 'p3',
//      title: 'Shirt',
//      review: 4.0,
//      description:
//          'A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of existence in this spot, which was created for the bliss of souls like mine.',
//      img: 'assets/images/t3.png',
//      price: 45.5,
//    ),
  ];

  List<Product> get items => _items;

  Product findById(String id) => _items.firstWhere((prod) => prod.id == id);

  List<Product> get favItems =>
      _items.where((prodItem) => prodItem.isFav).toList();

  Future<void> fetchAndSetProduct() async {
    const url = 'https://boltecommerce-11687.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data == null) {
        return;
      }
      final List<Product> loadedProduct = [];
      data.forEach((productId, productData) {
        loadedProduct.add(
          Product(
            id: productId,
            title: productData['title'],
            review: productData['review'],
            description: productData['description'],
            img: productData['img'],
            price: productData['price'],
            isFav: productData['isFav'],
          ),
        );
      });
      _items =loadedProduct;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://boltecommerce-11687.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'review': product.review,
          'description': product.description,
          'img': product.img,
          'price': product.price,
          'isFav': product.isFav,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        review: product.review,
        description: product.description,
        img: product.img,
        price: product.price,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> upDateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((newProduct) => newProduct.id == id);
    if (productIndex >= 0) {
      final url =
          'https://boltecommerce-11687.firebaseio.com/products/$id.json';
      await http.patch(
        url,
        body: json.encode({
          'title': newProduct.title,
          'review': newProduct.review,
          'description': newProduct.description,
          'img': newProduct.img,
          'price': newProduct.price,
        }),
      );
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print("....");
    }
  }

  Future<void> deleteProduct(String id)async {

    final url =
        'https://boltecommerce-11687.firebaseio.com/products/$id.json';

      final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
      var existingProduct = _items[existingProductIndex];
      _items.removeAt(existingProductIndex);
      notifyListeners();
      final response =await http.delete(url);
      if(response.statusCode >= 400){
        _items.insert(existingProductIndex, existingProduct);
        notifyListeners();
        throw HttpException("could not delete product!");
      }
      existingProduct = null;
    }
}
