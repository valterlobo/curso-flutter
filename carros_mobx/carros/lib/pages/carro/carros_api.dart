import 'dart:convert' as convert;
import 'dart:io';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    Usuario usuario = await Usuario.get();
    Map<String, String> headers =
    {
      "Content-Type": "application/json" ,
       "Authorization" : "Bearer ${usuario.token}"

    };

    print("GET > $headers");


    print("GET > $url");

    var response = await http.get(url , headers: headers);

    String json = response.body;

    List list = convert.json.decode(json);

    List<Carro> carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();

    return carros;
  }
}
