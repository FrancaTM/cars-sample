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
          height: 150,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text(c.nome),
                  subtitle: Text('desc'),
                  leading: Image.network(
                    c.urlFoto,
                    width: 120,
                  ),
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('BUY TICKETS'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      FlatButton(
                        child: const Text('LISTEN'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
