class ProductMercadoLivre {
  String title;
  String id;
  double price;
  String condition;
  String thumbnail;
  String currency;
  int quantity;
  String link;
  String permalink;

  ProductMercadoLivre(
      {this.title,
      this.id,
      this.price,
      this.condition,
      this.currency,
      this.link,
      this.quantity,
      this.thumbnail,
      this.permalink});

  ProductMercadoLivre.fromJson(Map<String, dynamic> source) {
    if (source != null) {
      condition = source['condition'];
      currency = source['currency'];
      id = source['id'];
      link = source['link'];
      price = source['price'].toDouble();
      quantity = source['quantity'];
      thumbnail = source['thumbnail'];
      title = source['title'];
      permalink = source['permalink'];
    }
  }

  static List<ProductMercadoLivre> fromJsonList(List<dynamic> sources) {
    return sources.map((it) => ProductMercadoLivre.fromJson(it)).toList();
  }
}
