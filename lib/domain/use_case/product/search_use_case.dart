import 'package:flutter/material.dart';
import 'package:mercado_livre_observable_mobile/data/product_repository.dart';
import 'package:mercado_livre_observable_mobile/domain/product_mercado_livre.dart';

class ProductSearchUseCase {
  final ProductRepository repository;

  ProductSearchUseCase({@required this.repository})
      : assert(repository != null);

  Future<List<ProductMercadoLivre>> search({@required String query}) async {
    return await repository.search(query: query);
  }
}
