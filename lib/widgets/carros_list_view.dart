import 'package:cars_sample/pages/carro_page.dart';
import 'package:flutter/material.dart';

import 'package:cars_sample/domain/carro.dart';
import 'package:cars_sample/domain/services/carro_service.dart';
import 'package:cars_sample/utils/nav.dart';

class CarrosListView extends StatefulWidget {
  final String tipo;

  const CarrosListView({this.tipo});

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return _buildBody(widget.tipo);
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
        //carro
        final c = carros[index];

        return Container(
          child: InkWell(
            onTap: () => _onPressedCarro(context, c),
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
                          FlatButton(
                              onPressed: () {
                                _onPressedCarro(context, c);
                              },
                              child: Text('DETALHES')),
                          FlatButton(onPressed: () {}, child: Text('SHARE')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onPressedCarro(BuildContext context, Carro c) {
    push(context, CarroPage(carro: c));
  }
}
