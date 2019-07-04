import 'package:flutter/material.dart';

import 'package:cars_sample/domain/carro.dart';
import 'package:cars_sample/widgets/carros_list_view.dart';
import 'package:cars_sample/domain/db/CarroDB.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    Future<List<Carro>> future = CarroDB.getInstance().getCarros();

    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder<List<Carro>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Carro> carros = snapshot.data;

            return CarrosListView(carros: carros);
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
}
