import 'package:carros/pages/carro/carro-dao.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/favorito.dart';
import 'package:carros/pages/favoritos/favorito_dao.dart';
import 'package:carros/pages/favoritos/favoritos_bloc.dart';
import 'package:provider/provider.dart';

class FavoritoService {
  static Future<bool> favoritar(context, Carro c) async {
    Favorito f = Favorito.fromCarro(c);

    final dao = FavoritoDAO();

    final exists = await dao.exists(c.id);

    if (exists) {
      // Remove dos favoritos
      dao.delete(c.id);

      Provider.of<FavoritosBloc>(context,listen: false).fetch();

      return false;
    } else {
      // Adiciona nos favoritos
      dao.save(f);

      Provider.of<FavoritosBloc>(context,listen: false).fetch();

      return true;
    }
  }

  static Future<List<Carro>> getCarros() async {
    // select * from carro c,favorito f where c.id = f.id
    List<Carro> carros = await CarroDAO()
        .query("select * from carro c,favorito f where c.id = f.id");

    return carros;
  }

  static Future<bool> isFavorito(Carro c) async {
    final dao = FavoritoDAO();

    bool exists = await dao.exists(c.id);

    return exists;
  }
}
