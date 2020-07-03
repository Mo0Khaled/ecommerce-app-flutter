import 'package:boltecommerce/model/http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _timer;
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
        _autoLogOut();
      notifyListeners();
      final prefs =await  SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _token,
          'userId':_userId,
          'expiryDate':_expiryDate.toIso8601String(),
        });
        prefs.setString("userData", userData);
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
  Future<bool> tryAutoLogin()async {
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey("userData")){
        return false;
    }
    final existingUserData = json.decode(prefs.getString("userData")) as Map<String,Object>;
    final expiryDate =DateTime.parse(existingUserData['expiryDate']);
    if(expiryDate.isBefore(DateTime.now())){
      return false;
    }
    _token = existingUserData['token'];
    _userId = existingUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
      _autoLogOut();
      return true;
  }
  Future<void> logOut()async{
    _token = null;
    _userId = null;
    _expiryDate = null;
    if(_timer!= null){
      _timer.cancel();
      _timer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }
  void _autoLogOut(){
    if(_timer!= null){
      _timer.cancel();
    }

    final timeToExpiry =_expiryDate.difference(DateTime.now()).inSeconds;
    _timer = Timer(Duration(seconds: timeToExpiry), logOut);
  }
}