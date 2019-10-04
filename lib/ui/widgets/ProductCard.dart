import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mercado_livre_observable_mobile/domain/price_history.dart';
import 'package:mercado_livre_observable_mobile/domain/product.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCardWidget extends StatelessWidget {
  ProductCardWidget({this.product}) : super();

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInImage.memoryNetwork(
                    image: product.thumbnail,
                    width: 100,
                    placeholder: kTransparentImage,
                  ),
                  Flexible(
                      child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          product.title,
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "R\$ ${product.price.toString()}",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        product.lastPrice == product.price
                            ? Text(
                                'Sem valor anterior',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black38),
                              )
                            : Text(
                                "Anterior: R\$ ${product.lastPrice.toString()}",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black38),
                              )
                      ],
                    ),
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.link),
                    onPressed: () async {
                      if (await canLaunch(product.link)) {
                        await launch(product.link);
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.data_usage),
                    onPressed: () {
                      _openBottomSheet(context);
                    },
                  )
                ],
              )
            ],
          )),
    );
  }

  List<Series<PriceHistory, DateTime>> _createDataChart(Product product) {
    return [
      new Series<PriceHistory, DateTime>(
        id: 'History',
        data: product.priceHistory,
        domainFn: (PriceHistory priceHistory, _) => priceHistory.date,
        measureFn: (PriceHistory priceHistory, _) => priceHistory.price,
      )
    ];
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.transparent,
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.link),
                          onPressed: () async {
                            if (await canLaunch(product.link)) {
                              await launch(product.link);
                            }
                          },
                        )
                      ],
                    ),
                    FadeInImage.memoryNetwork(
                      image: product.thumbnail,
                      width: 100,
                      placeholder: kTransparentImage,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        product.title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "R\$ ${product.price.toString()}",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Expanded(
                      child: new TimeSeriesChart(_createDataChart(product)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
