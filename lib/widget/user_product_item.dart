import 'package:boltecommerce/providers/productProviders.dart';
import 'package:boltecommerce/screens/EditedProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String img;

  UserProductItem({this.id, this.title, this.img});

  @override
  Widget build(BuildContext context) {
    final deleteProduct  = Provider.of<ProductProviders>(context,listen: false);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(img),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.edit), onPressed: () {
              Navigator.of(context).pushNamed(EditedProductScreen.routeId,arguments: id);
            }),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteProduct.deleteProduct(id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
