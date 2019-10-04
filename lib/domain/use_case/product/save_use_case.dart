import 'package:flutter/material.dart';
import 'package:mercado_livre_observable_mobile/data/product_repository.dart';
import 'package:mercado_livre_observable_mobile/storage.dart';

class ProductSaveUseCase {
  final ProductRepository repository;

  ProductSaveUseCase({@required this.repository}) : assert(repository != null);

  Future save({@required List<String> ids}) async {
    String email = await Storage.getEmail();
    return await repository.save(ids: ids, userEmail: email);
  }
}
