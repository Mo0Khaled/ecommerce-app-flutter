import 'dart:io';

import 'package:boltecommerce/lang/appLocale.dart';
import 'package:boltecommerce/providers/addressProvider.dart';
import 'package:boltecommerce/screens/add_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressItem extends StatelessWidget {
  final String id;
  final String addressLine;
  final String city;
  final int phoneNumber;
  AddressItem(this.id, this.addressLine, this.city, this.phoneNumber);

  @override
  Widget build(BuildContext context) {
    final translate = AppLocale.of(context);

    final deleteAddress = Provider.of<AddressProvider>(context, listen: false);
    return GestureDetector(
      onLongPress: () =>
          Navigator.of(context).pushNamed(AddAddress.routeId, arguments: id),
      child: Dismissible(
        key: ValueKey(id),
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            size: 40,
            color: Colors.white,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => deleteAddress.deleteAddress(id),
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (context) =>   Platform.isIOS ? CupertinoAlertDialog(
              title: Text(translate.getTranslated('title_remove_someThing')),
              content: Text(translate.getTranslated('remove_address_alert')),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(translate.getTranslated('no')),
                ),
                CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(translate.getTranslated('yes')),
                ),
              ],
            ):AlertDialog(
              title: Text(translate.getTranslated('title_remove_someThing')),
              content: Text(translate.getTranslated('remove_address_alert')),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(translate.getTranslated('no')),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(translate.getTranslated('yes')),
                ),
              ],
            ),
          );
        },
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(addressLine),
              SizedBox(
                height: 5,
              ),
              Text('City: $city'),
              SizedBox(
                height: 5,
              ),
              Text('Phone: $phoneNumber'),
            ],
          ),
        ),
      ),
    );
  }
}
