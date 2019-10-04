import 'package:flutter/material.dart';
import 'package:mercado_livre_observable_mobile/storage.dart';
import 'package:mercado_livre_observable_mobile/ui/screens/Home.dart';
import 'package:mercado_livre_observable_mobile/ui/screens/Login.dart';

void main() {
  Storage.getEmail().then((email) {
    runApp(Main(
      isLogged: email != "",
    ));
  });
}

class Main extends StatelessWidget {
  bool isLogged;

  Main({this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: new ThemeData(
        canvasColor: Colors.transparent,
      ),
      routes: {
        '/': (context) => isLogged ? HomeScreen() : LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
