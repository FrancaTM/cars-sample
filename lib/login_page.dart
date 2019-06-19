import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _loginController = TextEditingController(text: 'tulio');
  final _senhaController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Form(
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _loginController,
            decoration: InputDecoration(
              labelText: 'Login',
              labelStyle: TextStyle(color: Colors.blue, fontSize: 25.0),
              hintText: 'Digite o seu login',
            ),
            keyboardType: TextInputType.text,
          ),
          TextFormField(
            controller: _senhaController,
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
              onPressed: _onPressedLogin,
            ),
          ),
        ],
      ),
    );
  }

  _onPressedLogin() {
    final login = _loginController.text;
    final senha = _senhaController.text;

    print('$login, $senha');
  }
}
