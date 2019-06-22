import 'package:cars_sample/domain/services/login_service.dart';
import 'package:cars_sample/pages/home_page.dart';
import 'package:cars_sample/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:cars_sample/utils/alerts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginController = TextEditingController(text: 'tulio');
  final _senhaController = TextEditingController(text: '123');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _isLoading = false;

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
              child: _isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Text(
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

    setState(() {
      _isLoading = true;
    });

    final response = await LoginService.login(login, senha);

    if (response.isOk()) {
      print('login ok');
      pushReplacement(context, HomePage());
    } else {
      alert(context, 'Erro', response.message);
    }

    setState(() {
      _isLoading = false;
    });

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
