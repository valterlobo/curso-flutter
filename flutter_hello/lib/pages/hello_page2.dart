import 'package:flutter/material.dart';
import 'package:flutter_hello/widgets/blue_button.dart';

class HelloPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 2"),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Container(
      color: Colors.deepPurple,
      child:Row (
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.center,
         //mainAxisSize: MainAxisSize.min,
        children: [BlueButton("Teste"), BlueButton("teste 2"),BlueButton("Teste x")],
      ),
    );
  }

  _onClickVoltar(context) {
    Navigator.pop(context, "Tela 2");
  }
}
