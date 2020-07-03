import 'package:boltecommerce/providers/productProviders.dart';
import 'package:boltecommerce/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  final Axis scrollDirection;

  ProductList({this.scrollDirection});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
//    final data  = Provider.of<ProductProviders>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: Provider.of<ProductProviders>(context,listen: false).fetchAndSetProduct(),
          builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.error != null) {
            return Center(
              child: Text("Error"),
            );
          }
          else {
            return
              Consumer<ProductProviders>(
              builder: (context , prod,_) =>
                ListView.builder(
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: prod.items[index],
                  child: ProductItem(),
                ),
                itemCount: prod.items.length,
                scrollDirection: widget.scrollDirection,
              ),
            );
          }
        }
      }),
    );
  }
}
