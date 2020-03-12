import 'package:carros/pages/carro/carro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatelessWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(carro.nome),
        ),
        body: _body());
  }

  _body() {
    return Container(
      child: Center(child: Image.network(carro.urlFoto),)
    );
  }
}
