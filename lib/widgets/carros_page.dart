import 'package:flutter/material.dart';

import 'package:cars_sample/domain/carro.dart';
import 'package:cars_sample/domain/services/carro_service.dart';
import 'package:cars_sample/widgets/carros_list_view.dart';

class CarrosPage extends StatefulWidget {
  final String tipo;

  const CarrosPage({this.tipo});

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    // web service
    Future<List<Carro>> future = CarroService.getCarros(widget.tipo);

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
