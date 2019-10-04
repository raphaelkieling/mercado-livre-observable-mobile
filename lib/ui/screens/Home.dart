import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mercado_livre_observable_mobile/constants.dart';
import 'package:mercado_livre_observable_mobile/data/product_repository.dart';
import 'package:mercado_livre_observable_mobile/domain/product.dart';
import 'package:mercado_livre_observable_mobile/domain/use_case/product/get_all_use_case.dart';
import 'package:mercado_livre_observable_mobile/ui/screens/Search.dart';
import 'package:mercado_livre_observable_mobile/ui/widgets/EmptyList.dart';
import 'package:mercado_livre_observable_mobile/ui/widgets/ProductCard.dart';

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
        title: Text(Constants.appName,
            style: TextStyle(color: Constants.secondaryColor)),
        backgroundColor: Constants.primaryColor,
      ),
      backgroundColor: Colors.white,
      body: null == _products
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Constants.secondaryColor,
              ),
            )
          : 0 == _products.length
              ? Center(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    EmptyListWidget(),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: RaisedButton(
                        child: Text("Recarregar"),
                        color: Constants.primaryColor,
                        onPressed: () {
                          _getProducts();
                        },
                      ),
                    )
                  ],
                ))
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
            MaterialPageRoute(builder: (context) => SearchScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Constants.secondaryColor,
      ),
    );
  }

  Widget _buildItemProduct(Product product) {
    return ProductCardWidget(product: product);
  }
}
