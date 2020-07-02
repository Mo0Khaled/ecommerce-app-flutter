import 'package:boltecommerce/model/http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }
  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }
  String  get userId{
    return _userId;
  }
  Future<void> _authenticate(String name,String email,String password,String urlSegment) async{
    final url = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyC9we_pm7vqBz8sekTvHvz16MpAnrMQqNU';
    try{
      final response = await http.post(url,body: json.encode({
        'name':name,
        'email': email,
        'password':password,
        'returnSecureToken': true,
      }));
      final responseData = json.decode(response.body);
        if(responseData['error'] != null){
          throw HttpException(responseData['error']['message']);
        }
        _token = responseData['idToken'];
        _userId = responseData['localId'];
        _expiryDate = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
        print(responseData);
        notifyListeners();

    }catch(error){
      throw error;
    }

  }
  Future<void> signUp(String name,String email, String password) async {
    return _authenticate(name,email, password,'signupNewUser');
  }

  Future<void> login(String name,String email, String password) async {
    return _authenticate(name,email, password,'verifyPassword');
  }

}