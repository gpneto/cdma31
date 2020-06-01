
import 'package:cdma31/screen/categoria/cadastro_categoria.dart';
import 'package:cdma31/screen/config/home.dart';
import 'package:cdma31/screen/lista/lista_compras.dart';
import 'package:cdma31/screen/produtos/cadastro_produtos.dart';
import 'package:cdma31/util/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import '../../../app_config.dart';
import '../../../application.dart';
import '../../base_stateless_screen.dart';
import '../home_abstract.dart';
import '../menu_item.dart';

class AppHomeTheme extends HomeAbstract {
  AppHomeTheme(Key key, BuildContext context, State<StatefulWidget> stateHome)
      : super(key, context, stateHome);

  factory AppHomeTheme.init(key, context, stateHome) {
    var home = AppHomeTheme(key, context, stateHome);
    home.menusDisponiveis = [
      ListaCompras(context),
      CadastroProdutos(context),
      CadastroCategoria(context)
    ];
    Prefs.singleton()
        .addListenerForPref(Prefs.MENUS_DISABLED_PREF, home.changeListenerMenu);

    return home;
  }


  String titleConfig  = "";

  List<BaseStatelessScreen> menusDisponiveis ;
  @override
  PrefsListener changeListenerMenu(String key, Object value) {
    menus = [];

    List<String> ordemMenus = Prefs.singleton().getOrdemMenu();

    var indexInfo = 0;

    List<String> menuList = value;



    menusDisponiveis.asMap().forEach((index, menu) {
      if (menuList.where((t) => t == menu.id).length == 0) {
        MenuItem menuItem = MenuItem(
            id: menu.id,
            nome: menu.title,
            menu: TabItem(
                menu.iosIcon, menu.title, Colors.blue,
                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            body: menu,
            beforeOpen: () => {},
            index: indexInfo);

        menus.add(menuItem);
        indexInfo++;
      }

    });


    ordemMenus.asMap().forEach((index, menu) {
      int draggingIndex = menus.indexWhere((bt) {
        return bt.id == menu;
      });

      if (draggingIndex != -1) {
        final draggedItem = menus[draggingIndex];

        menus.removeAt(draggingIndex);
        var indexInsert = index > menus.length ? menus.length : index;
        draggedItem.index = indexInsert;
        menus.insert(indexInsert, draggedItem);
      }
    });


    ConfigPage config = ConfigPage(pai: stateHome);

    titleConfig = config.id;

    MenuItem menuItem = MenuItem(
        id: config.id,
        nome: config.title,
        menu: TabItem(FontAwesomeIcons.userCog, config.title, Colors.teal,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        body: ConfigPage(pai: stateHome),
        beforeOpen: () => {},
        index: indexInfo);

    menus.add(menuItem);
//    menus[0].beforeOpen();
  }

  // In Material, this app uses the hamburger menu paradigm and flatly lists
  // all 4 possible tabs. This drawer is injected into the songs tab which is
  // actually building the scaffold around the drawer.
  Widget buildHomePage(BuildContext context) {
    return _buildAppHomePage(homeAbstract: this, titleConfig:titleConfig,);
  }
}

class _buildAppHomePage extends StatefulWidget {
  final HomeAbstract homeAbstract;
  final String titleConfig;

  const _buildAppHomePage({Key key, this.homeAbstract, this.titleConfig}) : super(key: key);

  @override
  __buildAppHomePageState createState() => __buildAppHomePageState();
}

class __buildAppHomePageState extends State<_buildAppHomePage> {
  int selectedPos = 0;
  double bottomNavBarHeight = 75;

  bool isInConfig = false;

  CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    print('Abrindo a Tela Principal:' + DateTime.now().toString());

    _navigationController = new CircularBottomNavigationController(selectedPos);

    super.initState();

    // cancel previous message subscription


//    if (widget.controllerListenIncidente.hasListener) {
//      widget.controllerListenIncidente.close();
//    }

//    bucarIncidenteLinkSubscription =
//        widget.controllerListenIncidente.stream.listen((p) {
//          setState(() {
//            this.incidente = p;
//            this.selectedPos = 2;
//            _navigationController.value = this.selectedPos;
//            print(_navigationController.value);
//          });
//        });
  }

  @override
  Widget build(BuildContext context) {
    if (isInConfig) {
      selectedPos = widget.homeAbstract.menus.length - 1;
      _navigationController.value = this.selectedPos;
    }

    return Scaffold(
      key: widget.homeAbstract.key,
      body: Stack(
        children: <Widget>[
          bodyContainer(),
          Align(alignment: Alignment.bottomCenter, child: bottomNav()),
        ],
      ),
    );
  }

  Widget bodyContainer() {
    return Padding(
      padding: EdgeInsets.only(
          bottom:
              defaultTargetPlatformNative == TargetPlatformNative.app ? 40 : 0),
      child: widget.homeAbstract.menus[selectedPos].body,
    );
  }

  Widget bottomNav() {
    if (isInConfig) {
      selectedPos = widget.homeAbstract.menus.length - 1;
      _navigationController = CircularBottomNavigationController(selectedPos);
    }

    return CircularBottomNavigation(
      UniqueKey(),
      widget.homeAbstract.menus.map((menuItem) {
        return menuItem.menu as TabItem;
      }).toList(),
      controller: _navigationController,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      selectedPos: selectedPos >= widget.homeAbstract.menus.length
          ? widget.homeAbstract.menus.length - 1
          : selectedPos,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int selectedPos) {
        setState(() {
          widget.homeAbstract.menus[selectedPos].beforeOpen();
          if (widget.homeAbstract.menus[selectedPos].id == widget.titleConfig) {
            isInConfig = true;
          } else {
            isInConfig = false;
          }
          this.selectedPos = selectedPos;
        });
      },
    );
  }

  _onError(error) async {
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        duration: Duration(seconds: 4),
        backgroundColor: Colors.red,
        content: Text(
          error.toString().replaceFirst("Exception: ", ""),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
