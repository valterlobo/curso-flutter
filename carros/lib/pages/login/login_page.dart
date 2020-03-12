import 'dart:async';
import 'dart:math';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _focusSenha = FocusNode();

  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    var futureUser = Usuario.get();

    futureUser.then((Usuario user) {
      if (user != null) {
        push(context, HomePage(), replace: true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(18),
        child: ListView(
          children: <Widget>[
            AppText("Login", "Digite seu login",
                controller: _tLogin,
                validator: _validateLogin,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                nextFocus: _focusSenha),
            SizedBox(
              height: 10,
            ),
            AppText("Senha", "Digite sua senha",
                controller: _tSenha,
                password: true,
                validator: _validateSenha,
                keyboardType: TextInputType.number,
                focusNode: _focusSenha),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
              stream: _loginBloc.stream,
              builder: (context, snapshot) {
                return AppButton("OK",
                    onPressed: _onClickLogin,
                    showProgress: snapshot.data ?? false);
              },
            )
          ],
        ),
      ),
    );
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    String login = _tLogin.text;
    String senha = _tSenha.text;
    print("Login: $login, Senha: $senha");


    ApiResponse response = await _loginBloc.login(login, senha);

    if (response.ok) {
      var user = response.result;
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }

  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 3) {
      return "A senha precisa ter pelo menos 3 números";
    }
    return null;
  }
}
