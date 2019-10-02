class PriceHistory {
  double price;
  String date;

  PriceHistory({this.price, this.date});

  PriceHistory.fromJson(Map<String, dynamic> source) {
    if (source != null) {
      price = source['price'].toDouble();
      date = source['date'];
    }
  }

  static List<PriceHistory> fromJsonList(List<dynamic> sources) {
    return sources.map((it) => PriceHistory.fromJson(it)).toList();
  }
}
