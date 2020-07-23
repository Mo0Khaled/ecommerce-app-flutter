import 'package:boltecommerce/model/http_exception.dart';
import 'package:boltecommerce/providers/product.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProviders with ChangeNotifier {
  List<Product> _items = [];
  final String authToken;
  final String userId ;
  ProductProviders(this.authToken,this.userId,this._items);
  List<Product> get items => _items;
  Product findById(String id) => _items.firstWhere((prod) => prod.id == id);
  List<Product> get favItems =>
      _items.where((prodItem) => prodItem.isFav).toList();
  List<Product> filter(String name) {
    return _items
        .where(
          (element) => element.categoryId.contains(name),
    )
        .toList();
  }
  Future<void> fetchAndSetProduct([bool filterByUser = false]) async {
    final filter = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = 'https://boltecommerce-11687.firebaseio.com/products.json?auth=$authToken&$filter';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data == null) {
        return;
      }
      url = 'https://boltecommerce-11687.firebaseio.com/userFavorite/$userId.json?auth=$authToken';
      final favResponse = await http.get(url);
      final favData = json.decode(favResponse.body);
      final List<Product> loadedProduct = [];
      data.forEach((productId, productData) {
        loadedProduct.add(
          Product(
            id: productId,
            categoryId: productData['category_id'],
            title: productData['title'],
            review: productData['review'],
            discount: productData['discount'],
            shipping: productData['shipping'],
            description: productData['description'],
            img: productData['img'],
            price: productData['price'],
            isFav: favData == null ? false : favData[productId] ?? false,
          ),
        );
      });
      _items = loadedProduct.reversed.toList();

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = 'https://boltecommerce-11687.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'category_id': product.categoryId,
          'title': product.title,
          'review': product.review,
          'description': product.description,
          'img': product.img,
          'price': product.price,
          'discount':product.discount,
          'shipping':product.shipping,
          'isFav': product.isFav,
          'creatorId': userId,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        categoryId: product.categoryId,
        title: product.title,
        review: product.review,
        discount:  product.discount,
        shipping: product.shipping,
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
          'https://boltecommerce-11687.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(
        url,
        body: json.encode({
          'category_id':newProduct.categoryId,
          'title': newProduct.title,
          'review': newProduct.review,
          'description': newProduct.description,
          'img': newProduct.img,
          'price': newProduct.price,
          'discount': newProduct.discount,
          'shipping':newProduct.shipping,
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
        'https://boltecommerce-11687.firebaseio.com/products/$id.json?auth=$authToken';

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
