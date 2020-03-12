import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/pages/favoritos/favoritos_bloc.dart';
import 'package:carros/widgets/text-error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    //FavoritosBloc favoritosBloc = Provider.of<FavoritosBloc>(context, listen: false);
    //favoritosBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    FavoritosBloc favoritosBloc = Provider.of<FavoritosBloc>(context);

    return StreamBuilder(
      stream: favoritosBloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os carros");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;
        print("Carros qtde: ${carros.length}");

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(carros),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    //return Provider.of<FavoritosBloc>(context,listen: false).fetch();
  }
}
