import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text-error.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CarrosListView extends StatelessWidget {

  final List<Carro> carros;

  CarrosListView(this.carros);


  @override
  Widget build(BuildContext context) {

     return _listView(carros);

  }

  Container _listView(List<Carro> carros) {
    if (carros != null && carros.length > 0) {
      return Container(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
              itemCount: carros != null ? carros.length : 0,
              itemBuilder: (context, index) {
                var carro = carros[index];

                return Card(
                  color: Colors.orange[80],
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(children: <Widget>[
                      CachedNetworkImage(
                        imageUrl:
                        carro.urlFoto ??
                            "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
                        width: 250,
                      ),
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
                            onPressed: () => _onClickCarro(context , carro),
                          ),
                          FlatButton(
                            child: const Text('SHARE'),
                            onPressed: () => _onShareCarro(context, carro),
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

  _onClickCarro(context, Carro c) {
    push(context, CarroPage(c));
  }

  _onShareCarro(context , Carro c) {
       Share.share(c.urlFoto);
  }


}
