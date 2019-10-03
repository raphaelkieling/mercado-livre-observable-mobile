import 'package:flutter/material.dart';
import 'package:mercado_livre_observable_mobile/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ML Observador",
            style: TextStyle(color: Constants.secondaryColor)),
        backgroundColor: Constants.primaryColor,
      ),
      body: Container(
        child: Text('oi'),
      ),
    );
  }
}
