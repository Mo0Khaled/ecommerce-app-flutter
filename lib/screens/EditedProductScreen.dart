import 'package:boltecommerce/providers/product.dart';
import 'package:boltecommerce/providers/productProviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditedProductScreen extends StatefulWidget {
  static const routeId = '/EditedProductScreen';

  @override
  _EditedProductScreenState createState() => _EditedProductScreenState();
}

class _EditedProductScreenState extends State<EditedProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _discountFocusNode = FocusNode();
  final _categoryFocusNode = FocusNode();
  final _imgFocusNode = FocusNode();
  final _imgController = TextEditingController();
  final _imgUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    categoryId: 'men',
    title: "",
    review: null,
    discount: 0,
    shipping: 0,
    description: "",
    img: "",
    price: 0,
  );
  var _initValue = {
    'title': '',
    'category_id': '',
    'description': '',
    'price': '',
    'discount': '',
    'img': '',
  };
  var _isInit = true;

  @override
  void initState() {
    _imgFocusNode.addListener(_upDateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<ProductProviders>(context).findById(productId);
        _initValue = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'discount': _editedProduct.discount.toString(),
          'category_id': _editedProduct.categoryId,
          'img': '',
        };
        _imgController.text = _editedProduct.img;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imgUrlFocusNode.removeListener(_upDateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imgFocusNode.dispose();
    _imgController.dispose();
    _categoryFocusNode.dispose();
    super.dispose();
  }

  void _upDateImageUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      if ((!_imgController.text.startsWith("http") &&
              !_imgController.text.startsWith("https")) ||
          (!_imgController.text.endsWith("png") &&
              !_imgController.text.endsWith("jpg") &&
              !_imgController.text.endsWith("jpeg"))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedProduct.id != null) {
      Provider.of<ProductProviders>(context, listen: false)
          .upDateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<ProductProviders>(context, listen: false)
          .addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  String initialValue = 'men';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edited Product"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValue['title'],
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter a Title";
                  }
                  return null;
                },
                onSaved: (val) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    categoryId: _editedProduct.categoryId,
                    title: val,
                    review: _editedProduct.review,
                    discount: _editedProduct.discount,
                    shipping: _editedProduct.shipping,
                    description: _editedProduct.description,
                    img: _editedProduct.img,
                    price: _editedProduct.price,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValue['price'],
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter a Price";
                  }
                  if (double.tryParse(val) == null) {
                    return "Please Enter a Valid Number!";
                  }
                  if (double.tryParse(val) <= 0) {
                    return "Please Enter a Number Greater Than 0";
                  }
                  return null;
                },
                onSaved: (val) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    categoryId: _editedProduct.categoryId,
                    title: _editedProduct.title,
                    review: _editedProduct.review,
                    discount: _editedProduct.discount,
                    shipping: _editedProduct.shipping,
                    description: _editedProduct.description,
                    img: _editedProduct.img,
                    price: double.parse(val),
                  );
                },
              ),
              TextFormField(
                initialValue: _initValue['description'],
                decoration: InputDecoration(labelText: "Description"),
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter a Description";
                  }
                  if (val.length < 10) {
                    return "Should be at lease 10 char";
                  }
                  return null;
                },
                onSaved: (val) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    categoryId: _editedProduct.categoryId,
                    title: _editedProduct.title,
                    review: _editedProduct.review,
                    discount: _editedProduct.discount,
                    shipping: _editedProduct.shipping,
                    description: val,
                    img: _editedProduct.img,
                    price: _editedProduct.price,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValue['discount'],
                decoration: InputDecoration(labelText: "Discount"),
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_categoryFocusNode);
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter a Discount";
                  }
                  return null;
                },
                onSaved: (val) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    categoryId: _editedProduct.categoryId,
                    title: _editedProduct.title,
                    review: _editedProduct.review,
                    discount: double.parse(val),
                    shipping: _editedProduct.shipping,
                    description: _editedProduct.description,
                    img: _editedProduct.img,
                    price: _editedProduct.price,
                  );
                },
              ),
              DropdownButton<String>(
                value: initialValue,
                items: <String>['men', 'women', 'kids']
                    .map<DropdownMenuItem<String>>((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (String newValue) {
                  setState(() {
                    initialValue = newValue;
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      categoryId: initialValue,
                      title: _editedProduct.title,
                      review: _editedProduct.review,
                      discount: _editedProduct.discount,
                      shipping: _editedProduct.shipping,
                      description: _editedProduct.description,
                      img: _editedProduct.img,
                      price: _editedProduct.price,
                    );
                  });
                },
              ),

//              TextFormField(
//                initialValue: _initValue['category_id'],
//                decoration: InputDecoration(labelText: "Category"),
//                keyboardType: TextInputType.text,
//                focusNode: _categoryFocusNode,
//                validator: (val) {
//                  if (val.isEmpty) {
//                    return "Please Enter a Category";
//                  }
//                  return null;
//                },
//                onSaved: (val) {
//                  _editedProduct = Product(
//                    id: _editedProduct.id,
//                    categoryId: val,
//                    title: _editedProduct.title,
//                    review: _editedProduct.review,
//                    discount: _editedProduct.discount,
//                    shipping: _editedProduct.shipping,
//                    description: _editedProduct.description,
//                    img: _editedProduct.img,
//                    price: _editedProduct.price,
//                  );
//                },
//              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Img Url"),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.url,
                focusNode: _imgUrlFocusNode,
                controller: _imgController,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter a ImgUrl";
                  }
                  if (!val.startsWith("http") && !val.startsWith("https")) {
                    return "Please Enter Valid Url";
                  }
                  if (!val.endsWith("png") &&
                      !val.endsWith("jpg") &&
                      !val.endsWith("jpeg")) {
                    return "Enter a Valid img";
                  }
                  return null;
                },
                onSaved: (val) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    categoryId: _editedProduct.categoryId,
                    title: _editedProduct.title,
                    review: _editedProduct.review,
                    discount: _editedProduct.discount,
                    shipping: _editedProduct.shipping,
                    description: _editedProduct.description,
                    img: val,
                    price: _editedProduct.price,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
