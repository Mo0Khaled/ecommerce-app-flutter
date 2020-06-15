import 'package:boltecommerce/providers/cart.dart';
import 'package:boltecommerce/screens/cart_screen.dart';
import 'package:boltecommerce/screens/featured.dart';
import 'package:boltecommerce/widget/app_drawer.dart';
import 'package:boltecommerce/widget/badge.dart';
import 'package:boltecommerce/widget/productList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeId = '/Home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          Consumer<Cart>(
            builder: (context, cartPro, ch) => Badge(
              value: cartPro.itemCount.toString(),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartScreen.routeId),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
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
            buildTitle(
              title: "Categories",
              onPressed: () {},
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  buildCategory(
                    img: "assets/images/woman.png",
                    name: "Woman",
                    onTap: () {},
                    left: 25,
                    color1: Color(0xff6681EB),
                    color2: Color(0xff6590F1),
                    color3: Color(0xff64A8FA),
                  ),
                  buildCategory(
                    img: "assets/images/man.png",
                    name: "Man",
                    onTap: () {},
                    left: 35,
                    color1: Color(0xffFF5858),
                    color2: Color(0xffFE5870),
                    color3: Color(0xffFC588A),
                  ),
                  buildCategory(
                    img: "assets/images/kid.png",
                    name: "Kids",
                    onTap: () {},
                    left: 35,
                    color1: Color(0xff43E97B),
                    color2: Color(0xff3EEFA0),
                    color3: Color(0xff3AF6C8),
                  ),
                ],
              ),
            ),
            buildTitle(
              title: "Featured",
              onPressed: () =>
                  Navigator.of(context).pushNamed(FeaturedPage.routeId),
            ),
            Container(
              width: double.infinity,
              height: 260,
              child: ProductList(
                scrollDirection: Axis.horizontal,
              ),
            ),
            buildTitle(
              title: "Best Sell",
              onPressed: () {},
            ),
            Container(
              width: double.infinity,
              height: 260,
              child: ProductList(
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTitle({String title, Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 25),
          ),
          FlatButton(
            onPressed: onPressed,
            child: Text(
              'See All',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  InkWell buildCategory({
    String img,
    String name,
    Function onTap,
    Color color1,
    Color color2,
    Color color3,
    double left,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        margin: EdgeInsets.all(10),
        height: 65,
        width: 114,
        child: Stack(
          children: <Widget>[
            Image.asset(
              img,
              fit: BoxFit.contain,
            ),
            Container(
              width: 115,
              height: 65,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color1.withOpacity(0.9),
                    color2.withOpacity(.5),
                    color3.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              child: Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              top: 20,
              left: left,
            ),
          ],
        ),
      ),
    );
  }
}
