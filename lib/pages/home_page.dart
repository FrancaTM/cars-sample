import 'package:flutter/material.dart';

import 'package:cars_sample/domain/carro.dart';
import 'package:cars_sample/widgets/carros_list_view.dart';

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
          CarrosListView(tipo: TipoCarro.classicos),
          CarrosListView(tipo: TipoCarro.esportivos),
          CarrosListView(tipo: TipoCarro.luxo),
        ]),
      ),
    );
  }
}
