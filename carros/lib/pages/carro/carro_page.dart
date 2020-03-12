import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_form_page.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/loripsum_api.dart';
import 'package:carros/pages/carro/video_page.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  final Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumBloc();

  Color color = Colors.grey;

  Carro get carro => widget.carro;

  @override
  void initState() {
    super.initState();

    FavoritoService.isFavorito(carro).then( (bool favorito){

      setState(() {
        color   =  favorito ? Colors.red : Colors.grey ; 
      });
    });
    _loripsumApiBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    _loripsumApiBloc.fetch();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(carro.nome),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.place),
              onPressed: _onClickMapa,
            ),
            IconButton(
              icon: Icon(Icons.videocam),
              onPressed: _onClicVideo,
            ),
            PopupMenuButton<String>(
                onSelected: _onClickPopupMenu,
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 'editar',
                      child: Text('Editar'),
                    ),
                    PopupMenuItem(
                      value: 'deletar',
                      child: Text('Deletar'),
                    ),
                    PopupMenuItem(
                      value: 'share',
                      child: Text('Share'),
                    )
                  ];
                })
          ],
        ),
        body: _body());
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          CachedNetworkImage(
              imageUrl: widget.carro.urlFoto ??
                  "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png"),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
      ),
    );
  }

  void _onClickMapa() {}

  void _onClicVideo() {

    if(carro.urlVideo != null && carro.urlVideo.isNotEmpty) {
        push(context , VideoPage(carro));
    } else {
      alert(context, "Este carro não possui nenhum vídeo");
    }
  }

  void _onClickPopupMenu(String value) {
    switch (value) {
      case "editar":
        push(context, CarroFormPage(carro: carro));
        break;
      case "deletar":
        deletar();
        break;
      case "share":
        print("Share !!!");
        break;
    }
  }

  _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text(carro.nome, fontSize: 20, bold: true),
              text(carro.tipo, fontSize: 16)
            ],
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: color,
                size: 40,
              ),
              onPressed: _onClickFavorito,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 40,
              ),
              onPressed: _onClickFavoritockShare,
            )
          ],
        )
      ],
    );
  }

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        text(carro.descricao, fontSize: 16, bold: true),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<String>(
          stream: _loripsumApiBloc.stream,
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return text(snapshot.data, fontSize: 16);
          },
        ),
      ],
    );
  }

  void _onClickFavorito() async {

    bool favorito = await FavoritoService.favoritar(context, carro);

   setState(() {
     color = favorito ? Colors.red : Colors.grey;
   });
  }

  void _onClickFavoritockShare() {}


  void deletar() async {
    ApiResponse<bool> response = await CarrosApi.delete(carro);

    if(response.ok) {
      alert(context, "Carro deletado com sucesso", callback: (){
        pop(context);
      });
    } else {
      alert(context, response.msg);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _loripsumApiBloc.dispose();
  }
}
