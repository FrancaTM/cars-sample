import 'package:cars_sample/domain/services/carro_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _buildListView(),
    );
  }

  _buildListView() {
    final carros = CarroService.getCarros();

    return ListView.builder(
      itemCount: carros.length,
      itemBuilder: (context, index) {
        final c = carros[index];

        return Text(
          c.nome,
          style: TextStyle(fontSize: 30.0, color: Colors.blue),
        );
      },
    );
  }
}
