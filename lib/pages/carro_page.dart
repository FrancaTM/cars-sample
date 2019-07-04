import 'package:cars_sample/domain/db/CarroDB.dart';
import 'package:cars_sample/domain/services/carro_service.dart';
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
  bool _isFavorito = false;

  @override
  void initState() {
    super.initState();

    CarroDB.getInstance().exists(carro).then((b) {
      setState(() {
        _isFavorito = b;
      });
    });
  }

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
        _buildMiddleRow(),
        _buildBottomText(),
      ],
    );
  }

  Row _buildMiddleRow() {
    return Row(
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
          onTap: () {
            _onTapFavorito(context, carro);
          },
          child: Icon(
            Icons.favorite,
            color: _isFavorito ? Colors.red : Colors.grey,
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
    );
  }

  _buildBottomText() {
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            carro.desc,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          SizedBox(height: 10.0),
          FutureBuilder<String>(
            future: CarroService.getLoremIpsum(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Text(snapshot.data)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ],
      ),
    );
  }

  Future _onTapFavorito(BuildContext context, Carro carro) async {
    final db = CarroDB.getInstance();
    final exists = await db.exists(carro);

    if (exists) {
      db.deleteCarro(carro.id);
    } else {
      int id = await db.saveCarro(carro);
      print('carro salvo: $id');
    }

    setState(() {
      _isFavorito = !exists;
    });
  }
}
