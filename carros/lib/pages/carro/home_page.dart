import 'package:carros/pages/carro/carro_form_page.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/pages/carro/carros_page.dart';
import 'package:carros/pages/favoritos/favorito_page.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/utils/prefs.dart';
import 'package:carros/widgets/drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    print("initState");
    _initTabs();
  }

  _initTabs() async {
    int index = await Prefs.getInt("tabIdx");
    print('Index obtido Prefs: $index');

    _tabController = TabController(length: 4, vsync: this);

    setState(() {
      _tabController.index = index;
    });

    _tabController.addListener(() {
//      print("Tab ${_tabController.index}");

      Prefs.setInt("tabIdx", _tabController.index);
    });
    print("Tab index: ${_tabController.index}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: _tabController != null
            ? TabBar(
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    text: "Clássicos",
                  ),
                  Tab(
                    text: "Esportivos",
                  ),
                  Tab(
                    text: "Luxo",
                  ),
                  Tab(
                    text: "Favoritos",
                    icon: Icon(Icons.favorite),
                  )
                ],
              )
            : null,
      ),
      body: _tabController != null
          ? TabBarView(
              controller: _tabController,
              children: <Widget>[
                CarrosPage(TipoCarro.classicos),
                CarrosPage(TipoCarro.esportivos),
                CarrosPage(TipoCarro.luxo),
                FavoritosPage(),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.amber,
          onPressed: _onClickAdicionarCarro),
    );
  }

  void _onClickAdicionarCarro() {
    push(context, CarroFormPage());
  }
}
