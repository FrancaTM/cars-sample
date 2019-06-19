import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
            decoration: InputDecoration(
              labelText: 'Login',
              labelStyle: TextStyle(color: Colors.blue, fontSize: 25.0),
              hintText: 'Digite o seu login',
            ),
            keyboardType: TextInputType.text,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Senha',
              labelStyle: TextStyle(color: Colors.blue, fontSize: 25.0),
              hintText: 'Digite a sua senha',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
