import 'package:boltecommerce/providers/productProviders.dart';
import 'package:boltecommerce/widget/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'EditedProductScreen.dart';

class UserProduct extends StatelessWidget {
  static const routeId = '/userProduct';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProviders>(context, listen: false)
        .fetchAndSetProduct(true);
  }

  @override
  Widget build(BuildContext context) {
//    final productData = Provider.of<ProductProviders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditedProductScreen.routeId);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text("error"),
              );
            } else {
              return RefreshIndicator(
                onRefresh: ()=>_refreshProducts(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<ProductProviders>(
                    builder:  (context,productData,_) =>
                        ListView.builder(
                          itemBuilder: (context, index) => Column(
                            children: <Widget>[
                              UserProductItem(
                                id: productData.items[index].id,
                                title: productData.items[index].title,
                                img: productData.items[index].img,
                              ),
                              Divider(),
                            ],
                          ),
                          itemCount: productData.items.length,
                        ),
                  ),
                ),
              );
            }
          }
        }

      ),
    );
  }
}
