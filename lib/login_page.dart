import 'package:cars_sample/domain/login_service.dart';
import 'package:flutter/material.dart';
import 'package:cars_sample/utils/alerts.dart';

class LoginPage extends StatelessWidget {
  final _loginController = TextEditingController(text: '');
  final _senhaController = TextEditingController(text: '');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBody(context),
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return 'Informe o login';
    }

    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return 'Informe a senha';
    }

    if (text.length <= 2) {
      return 'Senha precisa ter mais de 2 números';
    }

    return null;
  }

  Widget _buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _loginController,
            validator: _validateSenha,
            decoration: InputDecoration(
              labelText: 'Login',
              labelStyle: TextStyle(color: Colors.blue, fontSize: 25.0),
              hintText: 'Digite o seu login',
            ),
            keyboardType: TextInputType.text,
          ),
          TextFormField(
            controller: _senhaController,
            validator: _validateLogin,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Senha',
              labelStyle: TextStyle(color: Colors.blue, fontSize: 25.0),
              hintText: 'Digite a sua senha',
            ),
            keyboardType: TextInputType.number,
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            height: 50.0,
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                'Login',
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
              onPressed: () {
                _onPressedLogin(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  _onPressedLogin(BuildContext context) async {
    final login = _loginController.text;
    final senha = _senhaController.text;

    if (!_formKey.currentState.validate()) {
      return;
    }

    final ok = await LoginService.login(login, senha);

    if (ok) {
      print('login ok');
    } else {
      alert(context, 'Erro', 'Erro de login');
    }

/*
    if (login.isEmpty || senha.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text('Informe corretamente o login e senha'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.pop(context), child: Text('OK')),
              ],
            );
          });
    }
*/
  }
}
