import 'package:flutter/material.dart';

import 'package:cars_sample/domain/carro.dart';

class CarroPage extends StatefulWidget {
  final Carro carro;

  const CarroPage({this.carro});

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  get carro => widget.carro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.place), onPressed: () {}),
          IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (string) {},
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text('Editar')),
                PopupMenuItem(child: Text('Deletar')),
                PopupMenuItem(child: Text('Share')),
              ];
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        Image.network(carro.urlFoto),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    carro.nome,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    carro.tipo,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 36.0,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.share,
                size: 36.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
