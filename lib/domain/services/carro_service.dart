import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:cars_sample/domain/carro.dart';
import 'package:cars_sample/domain/response.dart';

class CarroService {
  static Future<List<Carro>> getCarros(String tipo) async {
    final url = 'http://livrowebservices.com.br/rest/carros/tipo/$tipo';
    print('> get: $url');

    final response = await http.get(url);
//    print('< : ${response.body}');

    final mapCarros = json.decode(response.body).cast<Map<String, dynamic>>();
    final carros =
        mapCarros.map<Carro>((json) => Carro.fromJson(json)).toList();

    return carros;
  }

  static Future<String> getLoremIpsum() async {
    final url = 'https://loripsum.net/api';

    final response = await http.get(url);
    var body = response.body;

    body = body.replaceAll('<p>', '');
    body = body.replaceAll('</p>', '');

    return body;
  }

  static Future<Response> salvar(c) async {
    final url = 'http://livrowebservices.com.br/rest/carros';
    print('> post: $url');

    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(c.toMap());
    print('   > $body');

    final response = await http.post(url, headers: headers, body: body);

    final s = response.body;
    print('   < $s');

    final r = Response.fromJson(json.decode(s));
    return r;
  }
}
