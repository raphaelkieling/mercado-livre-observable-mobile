import 'package:flutter/material.dart';
import 'package:mercado_livre_observable_mobile/constants.dart';
import 'package:mercado_livre_observable_mobile/data/product_repository.dart';
import 'package:mercado_livre_observable_mobile/domain/product_mercado_livre.dart';
import 'package:mercado_livre_observable_mobile/domain/use_case/product/save_use_case.dart';
import 'package:mercado_livre_observable_mobile/domain/use_case/product/search_use_case.dart';
import 'package:mercado_livre_observable_mobile/ui/widgets/EmptyList.dart';
import 'package:mercado_livre_observable_mobile/ui/widgets/ProductMercadoLivreCard.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  ProductSearchUseCase _productSearchUseCase;
  ProductSaveUseCase _productSaveUseCase;
  List<ProductMercadoLivre> _products;
  bool _loading = false;
  bool _loadingSaveProduct = false;

  @override
  void initState() {
    _clearProducts();
    _getUseCase();
    super.initState();
  }

  void _getUseCase() {
    _productSearchUseCase =
        ProductSearchUseCase(repository: ProductRepository());

    _productSaveUseCase = ProductSaveUseCase(repository: ProductRepository());
  }

  void _clearProducts() {
    setState(() {
      _products = [];
    });
  }

  void onEditingCompleted() async {
    _clearProducts();
    await _getProducts();
  }

  Future _getProducts() async {
    setState(() {
      _loading = true;
    });

    var products =
        await _productSearchUseCase.search(query: _searchController.text);

    setState(() {
      _products = products;
      _loading = false;
    });
  }

  Future _saveProduct(ProductMercadoLivre productMercadoLivre) async {
    setState(() {
      _loadingSaveProduct = true;
    });
    await _productSaveUseCase.save(ids: [productMercadoLivre.id]);
    setState(() {
      _loadingSaveProduct = false;
    });
  }

  void _showDialog(
      BuildContext context, ProductMercadoLivre productMercadoLivre) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Tem certeza?"),
            content: _loadingSaveProduct
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: Constants.secondaryColor,
                      ),
                    ],
                  )
                : new Text("Deseja adicionar a sua lista?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "Fechar",
                  style: TextStyle(color: Constants.secondaryColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new RaisedButton(
                color: Constants.primaryColor,
                child: new Text(
                  "Claro!",
                  style: TextStyle(
                    color: Constants.secondaryColor,
                  ),
                ),
                onPressed: _loadingSaveProduct
                    ? null
                    : () async {
                        await _saveProduct(productMercadoLivre);
                        Navigator.of(context).pop();
                      },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisar",
            style: TextStyle(color: Constants.secondaryColor)),
        backgroundColor: Constants.primaryColor,
      ),
      backgroundColor: Colors.white,
      body: Container(
          child: Column(
        children: <Widget>[
          TextField(
            controller: _searchController,
            onEditingComplete: onEditingCompleted,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.search,
                  color: Constants.secondaryColor,
                ),
                hintText: 'Pesquise por algo:  Carro, Brinquedo...'),
          ),
          Expanded(
            child: Container(
              child: _loading
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Constants.secondaryColor,
                      ),
                    )
                  : 0 != _products.length
                      ? RefreshIndicator(
                          child: ListView(
                            padding: const EdgeInsets.all(8.0),
                            children: _products.map((product) {
                              return _buildItemProduct(product);
                            }).toList(),
                          ),
                          onRefresh: _getProducts,
                        )
                      : Center(child: EmptyListWidget()),
            ),
          )
        ],
      )),
    );
  }

  Widget _buildItemProduct(ProductMercadoLivre product) {
    return ProductMercadoLivreCardWidget(
      product: product,
      onPressSave: _showDialog,
    );
  }
}
