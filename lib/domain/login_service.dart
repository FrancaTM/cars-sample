import 'package:http/http.dart' as http;

class LoginService {
  static Future<bool> login(String login, String senha) async {
    var url = 'http://livrowebservices.com.br/rest/login';

    final response =
        await http.post(url, body: {'login': login, 'senha': senha});
    final body = response.body;

    print(body);

    return true;
  }
}
