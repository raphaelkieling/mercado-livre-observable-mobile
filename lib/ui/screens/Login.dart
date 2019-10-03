import 'package:flutter/material.dart';
import 'package:mercado_livre_observable_mobile/constants.dart';
import 'package:mercado_livre_observable_mobile/storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  void onPressEnter() async {
    await Storage.saveEmail(emailController.text);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Constants.secondaryColor,
                        ),
                        border: InputBorder.none,
                        hintText: 'Entre com seu e-mail'),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: emailController.text == '' ? null : onPressEnter,
                        color: Constants.secondaryColor,
                        child: Text('Entrar',
                            style: TextStyle(color: Colors.white)),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
