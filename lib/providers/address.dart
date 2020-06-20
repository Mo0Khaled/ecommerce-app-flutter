import 'package:flutter/foundation.dart';

class Address with ChangeNotifier {
  final String id;
  final String name;
  final String addressLine;
  final String city;
  final String postalCode;
  final int phoneNumber;

  Address({
    this.id,
    this.name,
    this.addressLine,
    this.city,
    this.postalCode,
    this.phoneNumber,
  });
}
