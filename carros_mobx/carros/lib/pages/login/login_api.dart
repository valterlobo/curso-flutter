import 'dart:convert';
import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      Map mapResponse;
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';

      Map<String, String> headers = {"Content-Type": "application/json"};

      final Map params = {
        "username": login,
        "password": senha,
      };

      String sParams = json.encode(params);

      var response = await http.post(url, body: sParams, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);
        String nome = mapResponse['nome'];
        String email = mapResponse['email'];
        user.save();

        var user2 = await Usuario.get();
        print ("user2 ${user2}");
        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse["error"]);
    } catch (error, exeception) {
      print("erro no login");
      return ApiResponse.error('erro no login');
    }
  }
}
