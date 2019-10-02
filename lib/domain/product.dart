import 'package:mercado_livre_observable_mobile/domain/price_history.dart';

class Product {
  String title;
  String id;
  double price;
  String condition;
  String thumbnail;
  double lastPrice;
  String currency;
  int quantity;
  String link;
  List<PriceHistory> priceHistory;

  Product(
      {this.title,
      this.id,
      this.price,
      this.condition,
      this.currency,
      this.lastPrice,
      this.link,
      this.priceHistory,
      this.quantity,
      this.thumbnail});

  Product.fromJson(Map<String, dynamic> source) {
    if (source != null) {
      condition = source['condition'];
      currency = source['currency'];
      id = source['_id'];
      lastPrice = source['last_price'].toDouble();
      link = source['link'];
      price = source['price'].toDouble();
      priceHistory = PriceHistory.fromJsonList(source['price_history']);
      quantity = source['quantity'];
      thumbnail = source['thumbnail'];
      title = source['title'];
    }
  }

  static List<Product> fromJsonList(List<dynamic> sources) {
    return sources.map((it) => Product.fromJson(it)).toList();
  }
}
