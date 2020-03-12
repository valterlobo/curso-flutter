import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carro-dao.dart';
import 'package:carros/pages/simple_bloc.dart';
import 'package:carros/utils/network.dart';

class CarroBloc extends SimpleBloc<List<Carro>> {
  fetch(String tipo) async {
    try {
      List<Carro> carros = [];
      bool networkOn = await isNetworkOn();

      if (!networkOn) {
        carros = await CarroDAO().findAllByTipo(tipo);
      } else {
        carros = await CarrosApi.getCarros(tipo);

        final carroDAO = new CarroDAO();
        for (Carro c in carros) {
          carroDAO.save(c);
        }
      }

      add(carros);
    } catch (e) {
      addError(e);
    }
  }
}
