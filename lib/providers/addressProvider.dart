import 'package:boltecommerce/providers/address.dart';
import 'package:flutter/foundation.dart';

class AddressProvider with ChangeNotifier {
  List<Address> _addresses = [
    Address(
      id: "a1",
      name: 'Istiak mahmud Remon',
      addressLine: 'Shewrapara 958',
      city: 'Dhaka',
      phoneNumber: 152632252,
      postalCode: '1215',
    ),
  ];

  List<Address> get addresses => _addresses;
  Address findById(String id) {
    return _addresses.firstWhere((address) => address.id == id);
  }

  void addAddress(Address address) {
    final newAddress = Address(
      id: DateTime.now().toString(),
      phoneNumber: address.phoneNumber,
      city: address.city,
      name: address.name,
      addressLine: address.addressLine,
      postalCode: address.postalCode,
    );
    _addresses.add(newAddress);
    notifyListeners();
  }

  void upDateAddress(String id, Address newAddress) {
    final addressIndex = _addresses.indexWhere((address) => address.id == id);
    if (addressIndex >= 0) {
      _addresses[addressIndex] = newAddress;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteAddress(String id) {
    _addresses.retainWhere((address) => address.id == id);
    notifyListeners();
  }
}
