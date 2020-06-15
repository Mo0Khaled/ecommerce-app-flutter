import 'package:boltecommerce/providers/cart.dart';
import 'package:boltecommerce/providers/productProviders.dart';
import 'package:boltecommerce/screens/cart_screen.dart';
import 'package:boltecommerce/widget/badge.dart';
import 'package:boltecommerce/widget/containerSize.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum sizeType {
  S,
  L,
  M,
  XXL,
}

class ProductDetails extends StatefulWidget {
  static const routeId = 'product_details';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  sizeType selectedSize;

  @override
  Widget build(BuildContext context) {
//    final loadedProduct = Provider.of<Product>(context);
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<ProductProviders>(context).findById(productId);
    final cartPro = Provider.of<Cart>(context, listen: false);
    const activeCardColor = Color(0xff667EEA);
    const inActiveColor = Color(0xffE1E1E1);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
//        leading: Icon(Icons.expand_less),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          Consumer<Cart>(
            builder: (context, cartP, ch) => Badge(
              value: cartP.itemCount.toString(),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Image.asset(
                  loadedProduct.img,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  loadedProduct.title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "\$${loadedProduct.price}",
                  style: TextStyle(color: Color(0xff667EEA), fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 10,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 8,
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 65,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Color(0xff667EEA),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          loadedProduct.review.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Very Good",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "49 Reviews",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff667EEA),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  loadedProduct.description,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 10,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Select Size",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Select Color",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BuildContainerSize(
                    size: "S",
                    color: selectedSize == sizeType.S
                        ? activeCardColor
                        : inActiveColor,
                    onTap: () {
                      setState(() {
                        selectedSize = sizeType.S;
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  BuildContainerSize(
                    size: "M",
                    color: selectedSize == sizeType.M
                        ? activeCardColor
                        : inActiveColor,
                    onTap: () {
                      setState(() {
                        selectedSize = sizeType.M;
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  BuildContainerSize(
                    size: "L",
                    color: selectedSize == sizeType.L
                        ? activeCardColor
                        : inActiveColor,
                    onTap: () {
                      setState(() {
                        selectedSize = sizeType.L;
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSize = sizeType.XXL;
                      });
                    },
                    child: Text(
                      "XLL",
                      style: TextStyle(
                        color: selectedSize == sizeType.XXL
                            ? activeCardColor
                            : inActiveColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        color: Color(0xffD8D6D6),
                        textColor: Colors.white,
                        onPressed: () => cartPro.addItem(
                          loadedProduct.id,
                          loadedProduct.price,
                          loadedProduct.title,
                          loadedProduct.img,
                        ),
                        child: Text(
                          "ADD TO CART",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        textColor: Colors.white,
                        color: Color(0XFF667EEA),
                        onPressed: () {},
                        child: Text(
                          "BUY NOW",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
