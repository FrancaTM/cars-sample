import 'package:flutter/material.dart';

import 'package:cars_sample/pages/carro_page.dart';
import 'package:cars_sample/domain/carro.dart';
import 'package:cars_sample/utils/nav.dart';

class CarrosListView extends StatelessWidget {
  final List<Carro> carros;

  const CarrosListView({this.carros});

  @override
  Widget build(BuildContext context) {
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
                    Center(
                        child: Image.network(c.urlFoto ??
                            'http://www.livroandroid.com.br/livro/carros/esportivos/Audi_Spyder.png')),
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
