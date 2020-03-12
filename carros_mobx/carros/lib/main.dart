import 'package:carros/pages/login/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Carros',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

