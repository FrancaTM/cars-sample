import 'package:flutter/material.dart';

import 'package:cars_sample/domain/carro.dart';
import 'package:cars_sample/domain/services/carro_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          bottom: TabBar(tabs: [
            Tab(text: 'Clássicos', icon: Icon(Icons.directions_car)),
            Tab(text: 'Esportivos', icon: Icon(Icons.directions_car)),
            Tab(text: 'Luxo', icon: Icon(Icons.directions_car)),
          ]),
        ),
        body: TabBarView(children: [
          _buildBody(TipoCarro.classicos),
          _buildBody(TipoCarro.esportivos),
          _buildBody(TipoCarro.luxo),
        ]),
      ),
    );
  }

  _buildBody(String tipo) {
    Future future = CarroService.getCarros(tipo);

    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder<List<Carro>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildListView(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Dados inexistentes',
                style: TextStyle(fontSize: 26.0, color: Colors.grey),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  _buildListView(List<Carro> carros) {
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 24.0),
                  ),
                  Text(
                    c.desc,
                    maxLines: 1,
                    style: TextStyle(color: Colors.grey, fontSize: 16.0),
                  ),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(onPressed: () {}, child: Text('DETALHES')),
                        FlatButton(onPressed: () {}, child: Text('SHARE')),
                      ],
                    ),
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
