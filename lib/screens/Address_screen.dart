import 'package:boltecommerce/lang/appLocale.dart';
import 'package:boltecommerce/providers/addressProvider.dart';
import 'package:boltecommerce/screens/add_address.dart';
import 'package:boltecommerce/screens/payment_screen.dart';
import 'package:boltecommerce/widget/address_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  
  static const routeId = '/address';
  @override
  Widget build(BuildContext context) {
    final translate = AppLocale.of(context);
    final addressData = Provider.of<AddressProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              translate.getTranslated('address'),
              style: TextStyle(fontSize: 30),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Column(
                children: <Widget>[
                  AddressItem(
                    addressData.addresses[index].id,
                    addressData.addresses[index].addressLine,
                    addressData.addresses[index].city,
                    addressData.addresses[index].phoneNumber,
                  ),
                  Divider(),
                ],
              ),
              itemCount: addressData.addresses.length,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed(AddAddress.routeId),
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
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(PaymentScreen.routeId);
                    },
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
                          translate.getTranslated('continue_to_payment'),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
