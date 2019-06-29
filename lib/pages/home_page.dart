import 'package:cars_sample/domain/services/carro_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: _buildListView(),
      ),
    );
  }

  _buildListView() {
    final carros = CarroService.getCarros();

    return ListView.builder(
      itemCount: carros.length,
      itemBuilder: (context, index) {
        final c = carros[index];

        return Container(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(child: Image.network(c.urlFoto)),
                  Text(
                    c.nome,
                    style: TextStyle(color: Colors.black, fontSize: 24.0),
                  ),
                  Text(
                    'Descrição',
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
