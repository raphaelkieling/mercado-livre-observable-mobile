import 'package:flutter/material.dart';
import 'package:mercado_livre_observable_mobile/ui/screens/Login.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  /**
   * References about routes
   * 
   * https://flutter.dev/docs/cookbook/navigation/named-routes
   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {'/': (context) => LoginScreen()},
    );
  }
}
