import 'package:flutter/material.dart';

import 'package:cars_sample/domain/carro.dart';
import 'package:cars_sample/domain/services/carro_service.dart';
import 'package:cars_sample/utils/alerts.dart';

class CarroFormPage extends StatefulWidget {
  final Carro carro;

  const CarroFormPage({this.carro});

  @override
  _CarroFormPageState createState() => _CarroFormPageState();
}

class _CarroFormPageState extends State<CarroFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final tecNome = TextEditingController();
  final tecDesc = TextEditingController();
  final tecTipo = TextEditingController();

  int _radioIndex = 0;
  var _showProgress = false;

  get carro => widget.carro;

  @override
  void initState() {
    super.initState();

    if (carro != null) {
      tecNome.text = carro.nome;
      tecDesc.text = carro.desc;
      _radioIndex = getTipoInt(carro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro != null ? carro.nome : 'Novo Carro'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: _buildForm(),
      ),
    );
  }

  _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _buildHeaderFoto(),
          Text(
            'Clique na imagem para tirar uma foto',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
          Divider(),
          Text(
            'Tipo',
            style: TextStyle(fontSize: 20.0, color: Colors.blue),
          ),
          _buildRadioTipo(),
          Divider(),
          TextFormField(
            controller: tecNome,
            keyboardType: TextInputType.text,
            validator: _validateNome,
            style: TextStyle(fontSize: 20.0, color: Colors.blue),
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Nome',
            ),
          ),
          TextFormField(
            controller: tecDesc,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 20.0, color: Colors.blue),
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Descrição',
            ),
          ),
          Container(
            height: 50.0,
            margin: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
              color: Colors.blue,
              child: _showProgress
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                  : Text('Salvar',
                      style: TextStyle(fontSize: 22, color: Colors.white)),
              onPressed: () {
                _onPressedSalvar(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildHeaderFoto() {
    return carro != null && carro.urlFoto != null
        ? Image.network(carro.urlFoto)
        : Image.asset('assets/images/camera.png', height: 150);
  }

  _buildRadioTipo() {
    return Center(
      child: Row(
        children: <Widget>[
          Radio(value: 0, groupValue: _radioIndex, onChanged: _onClickTipo),
          Text(
            'Clássicos',
            style: TextStyle(fontSize: 15.0, color: Colors.blue),
          ),
          Radio(value: 1, groupValue: _radioIndex, onChanged: _onClickTipo),
          Text(
            'Esportivos',
            style: TextStyle(fontSize: 15.0, color: Colors.blue),
          ),
          Radio(value: 2, groupValue: _radioIndex, onChanged: _onClickTipo),
          Text(
            'Luxo',
            style: TextStyle(fontSize: 15.0, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  int getTipoInt(Carro carro) {
    switch (carro.tipo) {
      case 'classicos':
        return 0;
      case 'esportivos':
        return 1;
      default:
        return 2;
    }
  }

  void _onClickTipo(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  String _validateNome(String value) {
    if (value.isEmpty) {
      return 'Informe o nome do carro';
    }
    return null;
  }

  _onPressedSalvar(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    // cria carro
    var c = carro ?? Carro();
    c.nome = tecNome.text;
    c.desc = tecDesc.text;
    c.tipo = _getTipo();

    setState(() {
      _showProgress = true;
    });
    print('salvar o carro $c');

    final response = await CarroService.salvar(c);

    if (response.isOk()) {
      alert(context, 'Carro salvo', response.message);
    } else {
      alert(context, 'Erro', response.message);
    }

    setState(() {
      _showProgress = false;
    });
  }

  String _getTipo() {
    switch (_radioIndex) {
      case 0:
        return 'classicos';
      case 1:
        return 'esportivos';
      default:
        return 'luxo';
    }
  }
}
