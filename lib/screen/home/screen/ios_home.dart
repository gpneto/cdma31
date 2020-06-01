import 'package:cdma31/screen/categoria/cadastro_categoria.dart';
import 'package:cdma31/screen/config/home.dart';
import 'package:cdma31/screen/lista/lista_compras.dart';
import 'package:cdma31/screen/produtos/cadastro_produtos.dart';
import 'package:cdma31/util/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:circular_bottom_navigation/tab_item.dart';

import '../../../app_config.dart';
import '../../base_stateless_screen.dart';
import '../home_abstract.dart';
import '../menu_item.dart';

class IosHome extends HomeAbstract {
  factory IosHome.init(key, context, stateHome) {
    var iosHome = IosHome(key, context, stateHome);
    iosHome.menusDisponiveis = [
      ListaCompras(context),
      CadastroProdutos(context),
      CadastroCategoria(context)
    ];

    Prefs.singleton().addListenerForPref(
        Prefs.MENUS_DISABLED_PREF, iosHome.changeListenerMenu);
    return iosHome;
  }

  IosHome(key, context, stateHome) : super(key, context, stateHome);

  List<BaseStatelessScreen> menusDisponiveis = [];

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
            menu: TabItem(menu.iosIcon, menu.title, Colors.green,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
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

    ConfigPage c = ConfigPage(pai: stateHome);
    MenuItem menuItem = MenuItem(
         id: c.id,
        nome: c.title,
        menu: TabItem(FontAwesomeIcons.userCog, c.title, Colors.teal,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        body: c,
        beforeOpen: () => {},
        index: indexInfo);

    menus.add(menuItem);
  }

  // In Material, this app uses the hamburger menu paradigm and flatly lists
  // all 4 possible tabs. This drawer is injected into the songs tab which is
  // actually building the scaffold around the drawer.
  Widget buildIosHomePage(BuildContext context) {
    return _buildAppHomePage(homeAbstract: this);
  }
}

class _buildAppHomePage extends StatefulWidget {
  final HomeAbstract homeAbstract;

  const _buildAppHomePage({Key key, this.homeAbstract}) : super(key: key);

  @override
  __buildAppHomePageState createState() => __buildAppHomePageState();
}

class __buildAppHomePageState extends State<_buildAppHomePage> {
  int selectedPos = 0;
  double bottomNavBarHeight = 75;

  bool isInConfig = false;

  @override
  void initState() {
    print('Abrindo a Tela Principal:' + DateTime.now().toString());

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
    }

    final MediaQueryData existingMediaQuery = MediaQuery.of(context);
    MediaQueryData newMediaQuery = MediaQuery.of(context);

    Widget content = bodyContainer();
    EdgeInsets contentPadding = EdgeInsets.zero;

    // Remove the view inset and add it back as a padding in the inner content.
    newMediaQuery = newMediaQuery.removeViewInsets(removeBottom: true);
    contentPadding =
        EdgeInsets.only(bottom: existingMediaQuery.viewInsets.bottom);

    var tabBar = bottomNav();

    if (
        // Only pad the content with the height of the tab bar if the tab
        // isn't already entirely obstructed by a keyboard or other view insets.
        // Don't double pad.
        (tabBar.preferredSize.height > existingMediaQuery.viewInsets.bottom)) {
      // TODO(xster): Use real size after partial layout instead of preferred size.
      // https://github.com/flutter/flutter/issues/12912
      final double bottomPadding =
          tabBar.preferredSize.height + existingMediaQuery.padding.bottom;

      // If tab bar opaque, directly stop the main content higher. If
      // translucent, let main content draw behind the tab bar but hint the
      // obstructed area.
      if (tabBar.opaque(context)) {
        contentPadding = EdgeInsets.only(bottom: bottomPadding);
      } else {
        newMediaQuery = newMediaQuery.copyWith(
          padding: newMediaQuery.padding.copyWith(
            bottom: bottomPadding,
          ),
        );
      }
    }

    content = MediaQuery(
      data: newMediaQuery,
      child: Padding(
        padding: contentPadding,
        child: content,
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
      ),
      child: Stack(
        children: <Widget>[
          // The main content being at the bottom is added to the stack first.
          content,
          MediaQuery(
            data: existingMediaQuery.copyWith(textScaleFactor: 1),
            child: Align(
              alignment: Alignment.bottomCenter,
              // Override the tab bar's currentIndex to the current tab and hook in
              // our own listener to update the [_controller.currentIndex] on top of a possibly user
              // provided callback.
              child: tabBar,
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyContainer() {
    setState(() {
      this.selectedPos = this.selectedPos >= widget.homeAbstract.menus.length
          ? widget.homeAbstract.menus.length - 1
          : this.selectedPos;
    });

    return Padding(
      padding: EdgeInsets.only(
          bottom:
              defaultTargetPlatformNative == TargetPlatformNative.app ? 40 : 0),
      child: widget.homeAbstract.menus[selectedPos].body,
    );
  }

  CupertinoTabBar bottomNav() {
//    return CircularBottomNavigation(
//      widget.homeAbstract.menus.map((menuItem) {
//        return menuItem.menu as TabItem;
//      }).toList(),
//      controller: _navigationController,
//      barHeight: bottomNavBarHeight,
//      barBackgroundColor: Colors.white,
//      selectedPos: selectedPos > widget.homeAbstract.menus.length ? widget.homeAbstract.menus.length   : selectedPos ,
//      animationDuration: Duration(milliseconds: 300),
//      selectedCallback: (int selectedPos) {
//        setState(() {
//          widget.homeAbstract.menus[selectedPos].beforeOpen();
//          if (widget.homeAbstract.menus[selectedPos].nome == InfoPage.title) {
//            isInConfig = true;
//          } else {
//            isInConfig = false;
//          }
//          this.selectedPos = selectedPos;
//        });
//      },
//    );

    return CupertinoTabBar(
        onTap: (index) {
          setState(() {
            widget.homeAbstract.menus[index].beforeOpen();
            if (widget.homeAbstract.menus[index].id == "Config") {
              isInConfig = true;
            } else {
              isInConfig = false;
            }
            this.selectedPos = index >= widget.homeAbstract.menus.length
                ? widget.homeAbstract.menus.length - 1
                : index;
          });
        },
        currentIndex: this.selectedPos,
        backgroundColor: CupertinoColors.quaternarySystemFill.withOpacity(0.5),
        activeColor: Colors.white.withOpacity(0.7),
        inactiveColor: CupertinoColors.black.withOpacity(0.6),
        items: widget.homeAbstract.menus
            .map((menuItem) => BottomNavigationBarItem(
                icon: Icon((menuItem.menu as TabItem).icon),
                title: Text((menuItem.menu as TabItem).title)))
            .toList());
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
