import 'dart:convert';

import 'package:boltecommerce/model/http_exception.dart';
import 'package:boltecommerce/providers/address.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AddressProvider with ChangeNotifier {
  List<Address> _addresses = [
//    Address(
//      id: "a1",
//      name: 'Istiak mahmud Remon',
//      addressLine: 'Shewrapara 958',
//      city: 'Dhaka',
//      phoneNumber: 152632252,
//      postalCode: '1215',
//    ),
  ];

  List<Address> get addresses => _addresses;
  final String authToken;
  final String userId;

  AddressProvider(this.authToken, this.userId, this._addresses);

  Address findById(String id) {
    return _addresses.firstWhere((address) => address.id == id);
  }
  Future<void> fetchAndSetAddress()async{
    final url =
        "https://boltecommerce-11687.firebaseio.com/address/$userId.json?auth=$authToken";
    try{
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data == null) {
        return;
      }
      final List<Address> loadedAddresses = [];
      data.forEach((addressId, address) {
       loadedAddresses.add(
           Address(
             id: addressId,
             name: address['name'],
             addressLine: address['addressLine'],
             city: address['city'],
             phoneNumber: address['phoneNumber'],
           )
       );
      });
      _addresses = loadedAddresses.reversed.toList();
      notifyListeners();
    }catch(error){
      throw error;
    }
  }

  Future<void> addAddress(Address address)async {
    final url =
        "https://boltecommerce-11687.firebaseio.com/address/$userId.json?auth=$authToken";
   final response = await http.post(url,
        body: json.encode({
          'phoneNumber': address.phoneNumber,
          'city': address.city,
          'name': address.name,
          'addressLine': address.addressLine,
        }));
    final newAddress = Address(
      id: json.decode(response.body)['name'],
      phoneNumber: address.phoneNumber,
      city: address.city,
      name: address.name,
      addressLine: address.addressLine,
    );
    _addresses.add(newAddress);
    notifyListeners();
  }

  Future<void> upDateAddress(String id, Address newAddress) async{
    final url = "https://boltecommerce-11687.firebaseio.com/address/$id.json?auth=$authToken";
    await http.patch(url,body: json.encode({
      'phoneNumber': newAddress.phoneNumber,
      'city': newAddress.city,
      'name': newAddress.name,
      'addressLine': newAddress.addressLine,
    }));
    final addressIndex = _addresses.indexWhere((address) => address.id == id);
    if (addressIndex >= 0) {
      _addresses[addressIndex] = newAddress;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteAddress(String id) async{
    final url = "https://boltecommerce-11687.firebaseio.com/address/$id.json?auth=$authToken";
      final existingAddressIndex = _addresses.indexWhere((index) => index.id == id);
      var existingAddress =_addresses[existingAddressIndex];
    _addresses.removeAt(existingAddressIndex);
    notifyListeners();

      final response = await http.delete(url);
      if(response.statusCode >= 400){
         _addresses.insert(existingAddressIndex, existingAddress);
             notifyListeners();
         throw HttpException("could not delete The Address!");

      }
      existingAddress = null;
  }
}
