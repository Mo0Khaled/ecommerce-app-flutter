import 'package:boltecommerce/lang/appLocale.dart';
import 'package:boltecommerce/providers/address.dart';
import 'package:boltecommerce/providers/addressProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatefulWidget {
  static const routeId = '/add-Address';
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _addressLineFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _postalCodeFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editProduct = Address(
    id: null,
    name: '',
    addressLine: '',
    city: '',
    phoneNumber: 0,
  );
  @override
  void dispose() {
    _addressLineFocusNode.dispose();
    _cityFocusNode.dispose();
    _postalCodeFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  var _initValues = {
    'name': '',
    'address': '',
    'city': '',
    'postal': '',
    'phone': '',
  };
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final addressId = ModalRoute.of(context).settings.arguments as String;
      if (addressId != null) {
        _editProduct =
            Provider.of<AddressProvider>(context).findById(addressId);
        _initValues = {
          'name': _editProduct.name,
          'address': _editProduct.addressLine,
          'city': _editProduct.city,
          'phone': _editProduct.phoneNumber.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editProduct.id != null) {
      Provider.of<AddressProvider>(context, listen: false)
          .upDateAddress(_editProduct.id, _editProduct);
    } else {
      Provider.of<AddressProvider>(context, listen: false)
          .addAddress(_editProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocale.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              translate.getTranslated('create_address'),
              style: TextStyle(fontSize: 30),
            ),
          ),
          Expanded(
            child: Form(
              key: _form,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: translate.getTranslated('name')),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_addressLineFocusNode);
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return translate.getTranslated('validate_name');
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {
                        _editProduct = Address(
                          id: _editProduct.id,
                          name: val,
                          addressLine: _editProduct.addressLine,
                          city: _editProduct.city,
                          phoneNumber: _editProduct.phoneNumber,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      initialValue: _initValues['address'],
                      decoration: InputDecoration(labelText: translate.getTranslated('address_line')),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_cityFocusNode);
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return translate.getTranslated('validate_address');
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {
                        _editProduct = Address(
                          id: _editProduct.id,
                          name: _editProduct.name,
                          addressLine: val,
                          city: _editProduct.city,
                          phoneNumber: _editProduct.phoneNumber,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      initialValue: _initValues['city'],
                      decoration: InputDecoration(labelText: translate.getTranslated('city')),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_postalCodeFocusNode);
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return translate.getTranslated('validate_city');
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {
                        _editProduct = Address(
                          id: _editProduct.id,
                          name: _editProduct.name,
                          addressLine: _editProduct.addressLine,
                          city: val,
                          phoneNumber: _editProduct.phoneNumber,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      initialValue: _initValues['phone'],
                      decoration: InputDecoration(labelText: translate.getTranslated('phone')),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_phoneNumberFocusNode);
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return translate.getTranslated('validate_phone');
                        }
                        if (int.tryParse(val) == null) {
                          return "Please Enter a Valid Number.";
                        }

                        return null;
                      },
                      onSaved: (val) {
                        _editProduct = Address(
                          id: _editProduct.id,
                          name: _editProduct.name,
                          addressLine: _editProduct.addressLine,
                          city: _editProduct.city,
                          phoneNumber: int.parse(val),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (_saveForm),
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff667EEA),
                      Color(0xff6597F4),
                      Color(0xff64B0FD),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    translate.getTranslated('add_address'),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
