import 'package:boltecommerce/providers/productProviders.dart';
import 'package:boltecommerce/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProductScreen extends StatelessWidget {
  static const routeId = '/cat';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final products = Provider.of<ProductProviders>(context).filter(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(id),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: products.length == 0
            ? Center(
          child: Text("No Items"),
        )
            : GridView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem(),
          ),
//          shrinkWrap: true,

          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 190,
            childAspectRatio: 2.2 / 3.0,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}
