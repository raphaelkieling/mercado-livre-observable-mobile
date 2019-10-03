import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mercado_livre_observable_mobile/config.dart';
import 'package:mercado_livre_observable_mobile/domain/product.dart';

class ProductRepository with Config {
  Future<List<Product>> getAll({@required String userEmail}) async {
    var source = await http.get(
      apiUrl + "/item",
      headers: {'user_email': userEmail},
    );
    var data = json.decode(utf8.decode(source.bodyBytes));
    return Product.fromJsonList(data);
  }

  search({@required String query}) {
    print("Hello query");
  }
}
