import 'package:cdma31/redux/app_state.dart';
import 'package:cdma31/screen/config/home.dart';
import 'package:cdma31/screen/config/user_avatar.dart';
import 'package:cdma31/screen/config/viewmodel/user_screen_viewmodel.dart';
import 'package:cdma31/screen/lista/lista_compras.dart';
import 'package:cdma31/screen/login/login_screan.dart';
import 'package:cdma31/screen/produtos/cadastro_produtos.dart';
import 'package:cdma31/util/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';



import '../../../app_config.dart';
import '../../../application.dart';
import '../../base_stateless_screen.dart';
import '../home_abstract.dart';
import '../menu_item.dart';
import 'drawer_listener.dart';

class AndroidHome extends HomeAbstract {
  factory AndroidHome.init(key, context, stateHome) {

    var home = AndroidHome(key, context, stateHome);
    home.menusDisponiveis = [
      ListaCompras(context),
      CadastroProdutos(context)
    ];
    Prefs.singleton()
        .addListenerForPref(Prefs.MENUS_DISABLED_PREF, home.changeListenerMenu);
    return home;

  }

  String titleConfig  = "";

  AndroidHome(key, context, stateHome) : super(key, context, stateHome);

   List<BaseStatelessScreen> menusDisponiveis ;


  @override
  PrefsListener changeListenerMenu(String key, Object value) {
    menus = [];

    List<String> ordemMenus = Prefs.singleton().getOrdemMenu();

    var indexInfo = 0;

    List<String> menuList = value;

    menusDisponiveis.asMap().forEach((index, menu) {
      if (menuList.where((t) => t == menu.title).length == 0) {
        MenuItem menuItem = MenuItem(
            nome: menu.title,
            menu: ListTile(
              leading: Icon(menu.androidIcon),
              title: Text(menu.title),
            ),
            body: menu,
            beforeOpen: () => {},
            index: indexInfo);

        menus.add(menuItem);
        indexInfo++;
      }

    });




    ordemMenus.asMap().forEach((index, menu) {
      int draggingIndex = menus.indexWhere((bt) {
        return bt.nome == menu;
      });

      if (draggingIndex != -1) {
        final draggedItem = menus[draggingIndex];

        menus.removeAt(draggingIndex);
        var indexInsert = index > menus.length ? menus.length : index;
        draggedItem.index = indexInsert;
        menus.insert(indexInsert, draggedItem);
      }
    });

    MenuItem menuItemDivider = MenuItem(
        nome: "Divider",
        menu: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Divider(),
        ),
        beforeOpen: () => {},
        index: indexInfo);

    menus.add(menuItemDivider);

    indexInfo++;

    ConfigPage config = ConfigPage(pai: stateHome);

    titleConfig = config.title;

    MenuItem menuItem = MenuItem(
        nome: config.title,
        menu: ListTile(
          leading: Icon(config.androidIcon),
          title: Text(config.title),
        ),
        body: ConfigPage(pai: stateHome),
        beforeOpen: () => {},
        index: indexInfo);

    menus.add(menuItem);

    menus[0].beforeOpen();
  }

  // In Material, this app uses the hamburger menu paradigm and flatly lists
  // all 4 possible tabs. This drawer is injected into the songs tab which is
  // actually building the scaffold around the drawer.
  Widget buildAndroidHomePage(BuildContext context) {
    return _buildMenuLateral(homeAbstract: this, titleConfig: titleConfig,);
  }
}

class _buildMenuLateral extends StatefulWidget {
  final HomeAbstract homeAbstract;

  final String titleConfig;

  const _buildMenuLateral({Key key, this.homeAbstract, this.titleConfig}) : super(key: key);

  @override
  __buildMenuLateralState createState() => __buildMenuLateralState();
}

class __buildMenuLateralState extends State<_buildMenuLateral> {
  int _selectedIndex = 0;

  bool isInConfig = false;

  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  _handleDrawer() {
    _key.currentState.openDrawer();


    setState(() {
      ///DO MY API CALLS
//      _counter++;
//     if(Application.flutterWebViewPlugin.isShow){
//       if (!_key.currentState.isDrawerOpen) {
//         Application.flutterWebViewPlugin.show();
//       }else{
//         Application.flutterWebViewPlugin.hide();
//       }
//
//     }


    });
  }
  @override
  Widget build(BuildContext context) {
    if (isInConfig) {
      _selectedIndex = widget.homeAbstract.menus.length - 1;
    }

    if(_selectedIndex>=widget.homeAbstract.menus.length){
      _selectedIndex = widget.homeAbstract.menus.length - 1;
    }


    List<Widget> menus = [
      DrawerHeader(
        decoration: BoxDecoration(color: Colors.green),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            StoreConnector<AppState, UserScreenViewModel>(
              builder: ((context, vm) {
                return Column(
                  children: <Widget>[
                    new Text(
                      vm.user.name,
                      style: new TextStyle(
                          fontSize: 18.0,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Container(
                          child: UserAvatar(
                            user: vm.user,
                            size: 65,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),

              converter: UserScreenViewModel.fromStore(),
              distinct: true,
//    onInitialBuild: _setInitialEditState,
            ),
            OutlineButton(
              shape: StadiumBorder(),
              textColor:  Colors.blue,
              child: Text('Sair'),
              borderSide: BorderSide(
                  color: Colors.blue,
                  style: BorderStyle.solid,
                  width: 1),
              onPressed: () {
                //Faz o Logout
                FirebaseAuth.instance.signOut().then((valor){
                  Navigator.of(context)
                      .pushReplacement(new MaterialPageRoute(builder: (context) => new LoginPage()));
                });

              },
            )
          ],
        ),
      )
    ];

    menus.addAll(widget.homeAbstract.menus.map((menuitem) {
      if (menuitem.menu is ListTile) {
        return ListTile(
            title: (menuitem.menu as ListTile).title,
            leading: (menuitem.menu as ListTile).leading,
            selected: menuitem.index == _selectedIndex,
            onTap: () {
              menuitem.beforeOpen();
              if (menuitem.nome == widget.titleConfig || menuitem.nome == widget.titleConfig)  {
                isInConfig = true;
              } else {
                isInConfig = false;
              }
              _onSelectItem(menuitem.index);
            });
      } else {
        return menuitem.menu as Widget;
      }
    }).toList());

    return Scaffold(
      key: _key,
//        appBar: new AppBar(
//          title: new Text(widget.homeAbstract.menus[_selectedIndex].nome),
////          centerTitle: true,
////          leading: new IconButton(icon: new Icon(
////              Icons.menu
////          ),
////            onPressed:_handleDrawer,
////          ),
//        ),


      drawer:  DrawerListener(

          child:  Drawer(
            child: ListView(padding: EdgeInsets.zero, children: menus),
          ),


      ),



      body: getBody(),
    );
  }

  Widget getBody() {
    return widget.homeAbstract.menus[_selectedIndex].body;
  }
}
