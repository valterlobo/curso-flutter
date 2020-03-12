import 'dart:convert' as convert;
import 'package:carros/utils/prefs.dart';

class Usuario {
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  Usuario(
      {this.login,
      this.nome,
      this.email,
      this.urlFoto,
      this.token,
      this.roles});

  Usuario.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    nome = json['nome'];
    email = json['email'];
    urlFoto = json['urlFoto'];
    token = json['token'];
    roles = json['roles'] != null ? json['roles'].cast<String>() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  @override
  String toString() {
    return 'Usuario{login: $login, nome: $nome}';
  }

  void save() {
    Prefs.setString("user.prefs", convert.json.encode(this.toJson()));
  }

  static Future<Usuario> get() async {
    String strUser = await Prefs.getString("user.prefs");
    if (strUser.isEmpty) return null;

    Usuario usuario = Usuario.fromJson(convert.json.decode(strUser));
    return usuario;
  }

  static void clear() {
    Prefs.setString("user.prefs" , '');
  }



}
