import 'package:cars_sample/domain/carro.dart';

class CarroService {
  static List<Carro> getCarros() {
    final carros = List.generate(22, (index) {
      return Carro(
          nome: 'Ferrari $index',
          urlFoto:
              'http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_Corvette.png');
    });

    return carros;
  }
}
