import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello/drawer_list.dart';
import 'package:flutter_hello/pages/hello_listview.dart';
import 'package:flutter_hello/pages/hello_page2.dart';
import 'package:flutter_hello/pages/extended_navbar.dart';
import 'package:flutter_hello/utils/nav.dart';
import 'package:flutter_hello/widgets/blue_button.dart';
import 'package:flutter_hello/widgets/fab_bottom_app_bar.dart';
import 'package:flutter_hello/widgets/fab_with_icons.dart';
import 'package:flutter_hello/widgets/layout.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  void _onItemTapped(int index, BuildContext context) {
    if (index == 1) {
      _onClickNavigator(context, ExtendedNavBar());
    } else if (index == 2) {
      _onClickNavigator(context, HelloPage2());
    } else {
      _onButtonPressed(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hello Flutter"),
          actions: [
            new BlueButton('Lista',
                onPressed: () => _onClickNavigator(context, HelloListView()))
          ],
          bottom: buildTabBar(),
        ),
        body: TabBarView(children: [
          _body(context),

          Container(
            color: Colors.blueAccent,
          ),
          Container(
            color: Colors.yellow,
          )
        ]),
        /**
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.monetization_on),
          onPressed: () {
            _onClickFab();
          },
        ),**/
        drawer: DrawerList(),

        /*bottomNavigationBar: FABBottomAppBar(

          centerItemText: 'Cobrar',
          color: Colors.indigo,
          backgroundColor:  Color(0xFFF2F3F8),
          selectedColor: Colors.red,
          notchedShape: CircularNotchedRectangle(),
          onTabSelected: (index) => _selectedTab(context , index),
          items: [
            //FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
            FABBottomAppBarItem(iconData: Icons.account_circle, text: 'Cobranças'),
            FABBottomAppBarItem(iconData: Icons.people, text: 'Clientes'),
            //FABBottomAppBarItem(iconData: Icons.dashboard, text: 'Bottom'),
            //FABBottomAppBarItem(iconData: Icons.monetization_on, text: 'Meu Dinheiro'),
          ],
        ), */
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: _buildFab(context),
        /****
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Business'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('School'),
            ),
          ],
          //currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: (index) => _onItemTapped(index, context),
        ),
        ***/
      ),
    );
  }

  TabBar buildTabBar() {
    return TabBar(tabs: [
      Tab(
        icon: Icon(Icons.monetization_on),
        text: "Meu Dinheiro",
      ),
      Tab(
        icon: Icon(Icons.content_paste),
        text: " Ultimas Atividades",
      ),
      Tab(
        icon: Icon(Icons.cached),
        text: "Fluxo do mês",
      ),
    ]);
  }

  _onClickFab() {
    print("Adicionar");
  }

  _body(context) {
    return Container(
        padding: EdgeInsets.only(top: 16),
        color: Colors.white,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _text(),
            _pageView(context),
            _buttons(context),
            // _buttomBar(),
          ],
        ),
    );
  }

  _pageView(BuildContext context) {
    return  Expanded(
      flex : 7, //. 200,
      child: PageView(
        scrollDirection: Axis.vertical,
        pageSnapping: true,
        allowImplicitScrolling: true,
        reverse: true,
        onPageChanged: (index) => {},
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          _img("assets/images/dog1.png"),
          _img("assets/images/dog2.png"),
          _img("assets/images/dog3.png"),
          _img("assets/images/dog4.png"),
          _img("assets/images/dog5.png")
        ],
      ),
    );
  }

  _buttons(BuildContext context) {
    return Builder(
      builder: (context) {
        return
          Expanded(
              flex : 3 ,
              child:  Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                BlueButton("ListView",
                    onPressed: () =>
                        _onClickNavigator(context, HelloListView())),
                BlueButton("Page 2",
                    onPressed: () => _onClickNavigator(context, HelloPage2())),
                BlueButton("Page 3",
                    onPressed: () => _onClickNavigator(context, ExtendedNavBar())),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                BlueButton("Snack", onPressed: () => _onClickSnack(context)),
                BlueButton("Dialog", onPressed: () => _onClickDialog(context)),
                BlueButton("Toast", onPressed: _onClickToast)
              ],
            )
          ],
        ));
      },
    );
  }

  void _onClickNavigator(BuildContext context, Widget page) async {
    String s = await push(context, page);

    print(">> $s");
  }

  _onClickSnack(context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Olá Flutter"),
        action: SnackBarAction(
          textColor: Colors.yellow,
          label: "OK",
          onPressed: () {
            print("OK!");
          },
        ),
      ),
    );
  }

  _onClickDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text("Flutter é muito legal"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                  print("OK !!!");
                },
              )
            ],
          ),
        );
      },
    );
  }

  _onClickToast() {
    Fluttertoast.showToast(
        msg: "Flutter é muito legal",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 5,
        backgroundColor: Colors.indigo,
        textColor: Colors.white,
        fontSize: 26.0);
  }

  _img(String img) {
    return Image.asset(
      img,
      fit: BoxFit.cover,
    );
  }

  _text() {
    return Text(
      "Hello World",
      style: TextStyle(
          color: Colors.blue,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
          decorationColor: Colors.red,
          decorationStyle: TextDecorationStyle.wavy),
    );
  }

  void _onButtonPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 280,
            child: Container(
              child: _buildBottomNavigationMenu(context),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  Column _buildBottomNavigationMenu(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('Flutter'),
          onTap: () => _selectItem('Flutter', context),
        ),
        ListTile(
          leading: Icon(Icons.accessibility_new),
          title: Text('Android'),
          onTap: () => _selectItem('Android', context),
        ),
        ListTile(
          leading: Icon(Icons.account_balance_wallet),
          title: Text('Carteira'),
          onTap: () => _selectItem('Carteira', context),
        ),
        ListTile(
          leading: Icon(Icons.transit_enterexit),
          title: Text('Deposito'),
          onTap: () => _selectItem('Deposito', context),
        ),
        ListTile(
          leading: Icon(Icons.assessment),
          title: Text('Kotlin'),
          onTap: () => _selectItem('Kotlin', context),
        ),
      ],
    );
  }

  void _selectItem(String name, BuildContext context) {
    if (name == 'Carteira') {
      _onClickNavigator(context, ExtendedNavBar());
    } else if (name == "Deposito") {
      _onClickNavigator(context, HelloPage2());
    } else {
      _onButtonPressed(context);
    }
  }

  Widget _buildFab(BuildContext context) {
    return
    Container( color:Colors.yellow,child:
      FloatingActionButton(
      onPressed: () => _selectedFab(context, 1),
      tooltip: 'Realizar Ação',
      child: ImageIcon(
        AssetImage("assets/images/bill.png"),
        //color: Color(0xFF3A5A98),
      ),
      elevation: 8.0,
    ));
    /*
    final icons = [ Icons.sms, Icons.mail, Icons.phone ];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped:  (index) =>  _selectedFab(context,index)
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () { },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );*/
  }

  void _selectedFab(BuildContext context, int index) {
    _onClickNavigator(context, ExtendedNavBar());
  }

  void _selectedTab(BuildContext context, int index) {
    _onClickNavigator(context, HelloPage2());
  }

  /*_buttomBar() {

    return Column(
      mainAxisSize: MainAxisSize.max,
         crossAxisAlignment: CrossAxisAlignment.end,
         children: [
           Container (
             height: 60,,
             color: Colors.deepPurple, child: Text("OLAS"),)
      ],
    );

  }*/
}
