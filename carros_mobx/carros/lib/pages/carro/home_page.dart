import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listview.dart';
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

    _tabController = TabController(length: 3, vsync: this);

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
                ],
              )
            : null,
      ),
      body: _tabController != null
          ? TabBarView(
              controller: _tabController,
              children: <Widget>[
                CarrosListView(TipoCarro.classicos),
                CarrosListView(TipoCarro.esportivos),
                CarrosListView(TipoCarro.luxo),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      drawer: DrawerList(),
    );
  }
}
