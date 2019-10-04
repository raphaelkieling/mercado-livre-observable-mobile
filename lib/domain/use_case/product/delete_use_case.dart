import 'package:flutter/material.dart';
import 'package:mercado_livre_observable_mobile/data/product_repository.dart';
import 'package:mercado_livre_observable_mobile/domain/product.dart';
import 'package:mercado_livre_observable_mobile/storage.dart';

class ProductDeleteUseCase {
  final ProductRepository repository;

  ProductDeleteUseCase({@required this.repository})
      : assert(repository != null);

  Future<Product> delete(String id) async {
    return await repository.delete(id: id);
  }
}
