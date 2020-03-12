import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:carros/pages/simple_bloc.dart';
import 'package:carros/utils/network.dart';

class FavoritosBloc extends SimpleBloc<List<Carro>> {
  fetch() async {
    try {
      List<Carro> carros = await FavoritoService.getCarros();
      add(carros);
    } catch (e) {
      print(e);
      addError(e);
    }
  }
}
