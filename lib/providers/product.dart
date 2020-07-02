import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Product with ChangeNotifier {
  final String id;
  final String title;
  final double review;
  final String description;
  final String img;
  final double price;
  bool isFav;

  Product({
    @required this.id,
    @required this.title,
    @required this.review,
    @required this.description,
    @required this.img,
    @required this.price,
    this.isFav = false,
  });
  void _setFavValue(bool newFav){
    isFav =newFav;
    notifyListeners();
  }
  Future<void> toggleFav(String token,String userId) async{
    final oldStatus =isFav;
    isFav = !isFav;
    final url =
        'https://boltecommerce-11687.firebaseio.com/userFavorite/$userId/$id.json?auth=$token';
    try{
        final response = await http.patch(url,body: json.encode({
          'isFav':isFav,
        }),);
        if(response.statusCode >= 400){
          _setFavValue(oldStatus);
        }
    }catch(error){
      _setFavValue(oldStatus);
    }

    notifyListeners();
  }
}
