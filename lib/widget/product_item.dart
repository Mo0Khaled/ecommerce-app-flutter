import 'package:boltecommerce/screens/product_details.dart';
import '../providers/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Consumer<Product>(
        builder: (context, productPro, ch) => Container(
          width: 157,
          child: Card(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                      ProductDetails.routeId,
                      arguments: productPro.id),
                  child: Container(
                    height: 185,
                    child: Image.network(
                      productPro.img,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 7,right: 7),
                  child: Text('\$${productPro.price}'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7,bottom: 10,right: 7),
                  child: Text(productPro.title),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
