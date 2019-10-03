import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mercado_livre_observable_mobile/domain/product.dart';
import 'package:transparent_image/transparent_image.dart';

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
        child: Row(
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
                  Text(
                    "Anterior: R\$ ${product.lastPrice.toString()}",
                    style: TextStyle(fontSize: 14, color: Colors.black38),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
