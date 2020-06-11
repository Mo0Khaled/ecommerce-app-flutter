import 'package:boltecommerce/widget/productList.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeId = '/Home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      drawerScrimColor: Colors.black,
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Card(
              elevation: 10,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                  focusColor: Colors.black,
                  hintText: 'Search Your Product',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Featured',
                  style: TextStyle(fontSize: 25),
                ),
                FlatButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(color: Colors.grey),
                    ))
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 260,
            child: ProductList(),
          ),
        ],
      ),
    );
  }
}
