import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mercado_livre_observable_mobile/config.dart';
import 'package:mercado_livre_observable_mobile/domain/product.dart';

class ProductRepository with Config {
  Future<List<Product>> getAll() async {
    var source = await http.get(apiUrl + "/item");
    var data = json.decode(utf8.decode(source.bodyBytes));
    return Product.fromJsonList(data);
  }

  search({@required String query}) {
    print("Hello query");
  }
}
