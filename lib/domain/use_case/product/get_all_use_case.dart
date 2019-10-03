import 'package:flutter/material.dart';
import 'package:mercado_livre_observable_mobile/data/product_repository.dart';
import 'package:mercado_livre_observable_mobile/domain/product.dart';
import 'package:mercado_livre_observable_mobile/storage.dart';

class ProductGetAllUseCase {
  final ProductRepository repository;

  ProductGetAllUseCase({@required this.repository})
      : assert(repository != null);

  Future<List<Product>> getAll() async {
    String email = await Storage.getEmail();
    return await repository.getAll(userEmail: email);
  }
}
