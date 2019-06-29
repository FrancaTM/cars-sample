import 'package:cars_sample/domain/carro.dart';

class CarroService {
  static List<Carro> getCarros() {
    final carros = List.generate(22, (index) {
      var urlFoto =
          'http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_Corvette.png';
      var urlFoto2 =
          'https://abrilquatrorodas.files.wordpress.com/2019/02/dc5aeab5-ferrari-f8-tributo-1.jpg';
      return Carro(nome: 'Ferrari $index', urlFoto: urlFoto);
    });

    return carros;
  }
}
