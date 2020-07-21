

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hello/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: Colors.blue,
        focusColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: HomePage(),
    );
  }
}
