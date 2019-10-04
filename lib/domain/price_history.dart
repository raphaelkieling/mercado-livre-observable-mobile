class PriceHistory {
  double price;
  DateTime date;

  PriceHistory({this.price, this.date});

  PriceHistory.fromJson(Map<String, dynamic> source) {
    if (source != null) {
      price = source['price'].toDouble();
      date = DateTime.parse(source['date']);
    }
  }

  static List<PriceHistory> fromJsonList(List<dynamic> sources) {
    return sources.map((it) => PriceHistory.fromJson(it)).toList();
  }
}
