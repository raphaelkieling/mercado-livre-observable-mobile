import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptyListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.search,
          size: 90,
          color: Colors.black38,
        ),
        Text(
          "Nenhum objeto encontrado",
          style: TextStyle(color: Colors.black38, fontSize: 18),
        )
      ],
    );
  }
}
