import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mercado_livre_observable_mobile/config.dart';
import 'package:mercado_livre_observable_mobile/domain/product.dart';
import 'package:mercado_livre_observable_mobile/domain/product_mercado_livre.dart';

class ProductRepository with Config {
  Future<List<Product>> getAll({@required String userEmail}) async {
    var uri = Uri.https(apiUrl, "/item");
    var source = await http.get(
      uri,
      headers: {'user_email': userEmail},
    );
    var data = json.decode(utf8.decode(source.bodyBytes));
    return Product.fromJsonList(data);
  }

  Future<List<ProductMercadoLivre>> search({@required String query}) async {
    var queryParameters = {
      'q': query,
    };
    var uri = Uri.https(apiUrl, "/search", queryParameters);
    var source = await http.get(uri);
    var data = json.decode(utf8.decode(source.bodyBytes));
    return ProductMercadoLivre.fromJsonList(data);
  }

  Future save({@required List<String> ids, @required String userEmail}) async {
    var queryParameters = {
      'ids': ids.join(','),
    };
    var uri = Uri.https(apiUrl, "/save", queryParameters);
    var source = await http.post(
      uri,
      headers: {'user_email': userEmail},
    );
    var data = json.decode(utf8.decode(source.bodyBytes));
    return ProductMercadoLivre.fromJsonList(data);
  }

  Future delete({@required String id}) async {
    var uri = Uri.https(apiUrl, "/item/$id");
    var source = await http.delete(uri);
    var data = json.decode(utf8.decode(source.bodyBytes));
    return ProductMercadoLivre.fromJson(data);
  }
}
