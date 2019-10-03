import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mercado_livre_observable_mobile/constants.dart';
import 'package:mercado_livre_observable_mobile/data/product_repository.dart';
import 'package:mercado_livre_observable_mobile/domain/product.dart';
import 'package:mercado_livre_observable_mobile/domain/use_case/product/get_all_use_case.dart';
import 'package:mercado_livre_observable_mobile/ui/screens/Search.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductGetAllUseCase _productGetAllUseCase;
  List<Product> _products;

  @override
  void initState() {
    _getUseCase();

    super.initState();
  }

  void _clearProducts() {
    setState(() {
      _products = null;
    });
  }

  Future _getProducts() async {
    _clearProducts();
    var products = await _productGetAllUseCase.getAll();
    setState(() {
      _products = products;
    });
  }

  void _getUseCase() {
    _productGetAllUseCase =
        ProductGetAllUseCase(repository: ProductRepository());
    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ML Observador",
            style: TextStyle(color: Constants.secondaryColor)),
        backgroundColor: Constants.primaryColor,
      ),
      body: null == _products
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Constants.secondaryColor,
              ),
            )
          : RefreshIndicator(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: _products.map((product) {
                  return _buildItemProduct(product);
                }).toList(),
              ),
              onRefresh: _getProducts,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => SearchScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Constants.secondaryColor,
      ),
    );
  }

  Widget _buildItemProduct(Product product) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeInImage.memoryNetwork(
              image: product.thumbnail,
              width: 100,
              placeholder: kTransparentImage,
            ),
            SizedBox(
              width: 8.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  product.price.toString(),
                  style: TextStyle(fontSize: 24),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}