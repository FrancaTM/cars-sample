import 'package:flutter/material.dart';

import 'package:cars_sample/domain/carro.dart';

class CarroPage extends StatefulWidget {
  final Carro carro;

  const CarroPage({this.carro});

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  get carro => widget.carro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return ListView(
      children: <Widget>[
        Image.network(carro.urlFoto),
      ],
    );
  }
}
