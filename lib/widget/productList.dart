import 'package:boltecommerce/providers/productProviders.dart';
import 'package:boltecommerce/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProviders>(context);
    final products = productData.items;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        ),
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
