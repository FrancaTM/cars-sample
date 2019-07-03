import 'package:flutter/material.dart';

import 'package:cars_sample/utils/prefs.dart';
import 'package:cars_sample/domain/carro.dart';
import 'package:cars_sample/widgets/carros_list_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);

    Prefs.getInt('tabIndex').then((index) {
      tabController.index = index;
    });

    tabController.addListener(() async {
      int index = tabController.index;

      Prefs.setInt('tabIndex', index);
      print('tab $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'Clássicos', icon: Icon(Icons.directions_car)),
            Tab(text: 'Esportivos', icon: Icon(Icons.directions_car)),
            Tab(text: 'Luxo', icon: Icon(Icons.directions_car)),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CarrosListView(tipo: TipoCarro.classicos),
          CarrosListView(tipo: TipoCarro.esportivos),
          CarrosListView(tipo: TipoCarro.luxo),
        ],
      ),
    );
  }
}
