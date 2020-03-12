import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text-error.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatefulWidget {
  String tipo;

  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  @override
  bool get wantKeepAlive => true;
  List<Carro> carros;
  final _bloc = new CarroBloc();


  @override
  void initState() {
    super.initState();
    _bloc.fetch(widget.tipo);
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (contex, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os carros");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;

        return _listView(carros);
      },
    );
  }

  Container _listView(List<Carro> carros) {
    if (carros != null && carros.length > 0) {
      return Container(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
              itemCount: carros != null ? carros.length : 0,
              itemBuilder: (context, index) {
                Carro carro = carros[index];
                return Card(
                  color: Colors.orange[80],
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(children: <Widget>[
                      Image.network(
                          carro.urlFoto ??
                              "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
                          width: 250),
                      Text(
                        carro.nome,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        carro.descricao,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('DETALHES'),
                            onPressed: () => _onClickCarro(carro),
                          ),
                          FlatButton(
                            child: const Text('SHARE'),
                            onPressed: () {/* ... */},
                          ),
                        ],
                      ),
                    ]),
                  ),
                );
              }));
    } else {
      return Container(
        child: Text("Algo deu errado?"),
      );
    }
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
