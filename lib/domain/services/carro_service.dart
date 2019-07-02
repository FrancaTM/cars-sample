import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:cars_sample/domain/carro.dart';

class CarroService {
  static Future<List<Carro>> getCarros() async {
    final url = 'http://livrowebservices.com.br/rest/carros';
//    print('> get: $url');

    final response = await http.get(url);
//    print('< : ${response.body}');

    final mapCarros = json.decode(response.body).cast<Map<String, dynamic>>();
    final carros =
        mapCarros.map<Carro>((json) => Carro.fromJson(json)).toList();

    return carros;
  }
}
