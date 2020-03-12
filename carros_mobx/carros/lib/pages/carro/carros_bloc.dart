import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:mobx/mobx.dart';

part 'carros_model.g.dart';

class CarrosModel = _CarrosModel with _$CarrosModel;

abstract class _CarrosModel with Store {
  @observable
  List<Carro> carros;

  @observable
  Exception error;

  @action
  fetch(String tipo) async {
    try {
      this.carros = await CarrosApi.getCarros(tipo);
    } catch (e) {
      error = e;
    }
  }
}
