import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:cars_sample/domain/response.dart';

class LoginService {
  static Future<Response> login(String login, String senha) async {
    var url = 'http://livrowebservices.com.br/rest/login';

    final response =
        await http.post(url, body: {'login': login, 'senha': senha});
    final s = response.body;
    print(s);

    final Map<String, dynamic> map = json.decode(s);

    final r = Response.fromJson(map);

    return r;
  }
}
