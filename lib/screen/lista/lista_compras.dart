import 'dart:async';

import 'package:cdma31/audio_teste/demo2.dart';
import 'package:cdma31/model/lista.dart';
import 'package:cdma31/redux/app_state.dart';

import 'package:cdma31/screen/lista/card_lista.dart';
import 'package:cdma31/screen/config/viewmodel/user_screen_viewmodel.dart';
import 'package:cdma31/scroll/scrollable_positioned_list.dart';
import 'package:cdma31/util/app_localization.dart';
import 'package:cdma31/util/platform_widget_native.dart';
import 'package:cdma31/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import '../../app_config.dart';
import '../base_stateless_screen.dart';
import 'add/cria_lista.dart';
import 'lista_compras_viewmodel.dart';

class ListaCompras extends BaseStatelessScreen {

  final BuildContext context;

  ListaCompras(this.context);

  @override
  _ListaComprasState createState() => _ListaComprasState();

  @override
  String get title => AppLocalizations.of(context).shopping;

  @override
  IconData get androidIcon => FontAwesomeIcons.shoppingCart;

  @override
  IconData get iosIcon => FontAwesomeIcons.shoppingCart;
}

class _ListaComprasState extends State<ListaCompras>
    with TickerProviderStateMixin {
  List<Color> cores = [
    const Color.fromRGBO(77, 85, 225, 1.0),
    const Color.fromRGBO(93, 167, 231, 1.0)
  ];

  LinearGradient backgroundGradient;
  bool buscaPrimeiro = true;
  Widget nomeUser;
  Widget appBarTitle;

  List<String> lista = [];

  List<Widget> get teste => lista.map((f) => Text("")).toList();

  @override
  void initState() {
    super.initState();
    backgroundGradient = LinearGradient(
        colors: cores, begin: Alignment.bottomCenter, end: Alignment.topCenter);

    nomeUser = StoreConnector<AppState, UserScreenViewModel>(
      builder: ((context, vm) {
        return Text(
          AppLocalizations.of(context).hello(vm.user.name.split(' ')[0]),
          style: TextStyle(
              fontSize: 30.0, color: Theme.of(context).textTheme.title.color),
        );
      }),

      converter: UserScreenViewModel.fromStore(),
      distinct: true,
//    onInitialBuild: _setInitialEditState,
    );

    appBarTitle = nomeUser;
  }

  Icon actionIcon = Icon(Icons.add);
  String filter = "";

  Widget _buildAndroid(BuildContext context) {
    return Stack(
      children: [
        buildWidget(),
        SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).iconTheme.color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 3.0,
                      // has the effect of softening the shadow
                      spreadRadius: 2.0,
                      // has the effect of extending the shadow
                      offset: Offset(
                        .0, // horizontal, move right 10
                        5.0, // vertical, move down 10
                      ),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 2),
                child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  heroTag: 'actionMenu',
                  onPressed: () => Scaffold.of(context).openDrawer(),
//                                    backgroundColor: Colors.transparent,
                  mini: true,
                  child: Icon(Icons.menu),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIos(BuildContext context) {
    return buildWidget();
  }

  @override
  Widget build(context) {
    return PlatformWidgetNative(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
      appBuilder: _buildIos,
    );
  }

  int _currentIndex = 0;

  Widget buildWidget() {
    var size = MediaQuery.of(context).size;

    Widget retorno = Container(
      decoration: BoxDecoration(gradient: backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: appBarTitle,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Theme.of(context).iconTheme.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 3.0,
                        // has the effect of softening the shadow
                        spreadRadius: 2.0,
                        // has the effect of extending the shadow
                        offset: Offset(
                          .0, // horizontal, move right 10
                          5.0, // vertical, move down 10
                        ),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    heroTag: 'heroVerde',
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.criarLista),
//                                    backgroundColor: Colors.transparent,
                    mini: true,
                    child: actionIcon,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
//                        positionsView,
                        Expanded(
//                              child: ScrollablePositionedListPage()
                          child:
                              StoreConnector<AppState, ListaComprasViewModel>(
                            distinct: true,
                            converter: ListaComprasViewModel.fromStore,
                            builder: (context, vm) {
                              if (!vm.hasData) {
                                return Center(
                                    child: Container(
                                  height: size.height,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Expanded(
                                          child: Container(
                                        height: size.height - 200,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                AppLocalizations.of(context).searchingShoppingList,
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 17.0),
                                              ),
                                            ),
                                            CircularProgressIndicator(),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ));
                              }

//                              return MyApp();
                              if (vm.listaCompras != null) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          child: Center(
                                        child: Text(
                                          AppLocalizations.of(context).shoppingListCount(vm.listaCompras.length),
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .subtitle
                                                  .color),
                                        ),
                                      )),
                                      Expanded(
                                        child: Stack(
                                          children: <Widget>[
                                            vm.listaCompras.length == 0
                                                ? Container(
//                                                height: 400,
                                                    child: Center(
                                                    child: Text(
                                                        AppLocalizations.of(context).noHaveShoppingList,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white70,
                                                            fontSize: 20.0)),
                                                  ))
                                                : Container(),
                                            ScrollablePositionedList.builder(
//                                          reverse: true,
                                              itemCount: vm.listaCompras.length,
                                              itemBuilder: (context, index) {
                                                if (vm.listaCompras.length ==
                                                    0) {
                                                  return Container();
                                                }
                                                Lista lista =
                                                    vm.listaCompras[index];
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      top: index == 0 ? 17 : 0,
                                                      bottom: index ==
                                                              vm.listaCompras
                                                                      .length -
                                                                  1
                                                          ? 20
                                                          : 0),
                                                  child: SafeArea(
                                                    top: false,
                                                    left: false,
                                                    right: false,
                                                    bottom: defaultTargetPlatformNative ==
                                                            TargetPlatformNative
                                                                .android
                                                        ? false
                                                        : index ==
                                                                vm.listaCompras
                                                                        .length -
                                                                    1
                                                            ? true
                                                            : false,
                                                    child: Dismissible(
                                                      key: new ObjectKey(
                                                          lista.id),
                                                      child: CardLista(
                                                        lista: lista,
                                                        contextpai: context,
                                                      ),
                                                      confirmDismiss:
                                                          (DismissDirection
                                                              direction) async {
                                                        return await showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title:  Text(
                                                                  AppLocalizations.of(context).confirm),
                                                              content:  Text(
                                                                  AppLocalizations.of(context).confirDelete),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              true);
                                                                      lista
                                                                          .produtosRef
                                                                          .setData({
                                                                        "status":
                                                                            "INATIVO"
                                                                      }, merge: true);
                                                                    },
                                                                    child:  Text(
                                                                        AppLocalizations.of(context).yes)),
                                                                FlatButton(
                                                                  onPressed: () =>
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              false),
                                                                  child:
                                                                       Text(
                                                                          AppLocalizations.of(context).no),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                              scrollDirection: Axis.vertical,
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]);
                              } else {
                                // TODO: Proper empty state screen
                                return Scaffold();
                              }
                            },
                          ),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: [
        retorno,
        Align(
          alignment: Alignment.bottomRight,
          child: SafeArea(
            bottom: true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                key: Key("get-todos-button"),
                onPressed: () => recorAudio(),
                child: Icon(Icons.record_voice_over),
              ),
            ),
          ),
        )
      ],
    );
  }


  recorAudio(){

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AudioTesteDemo()),
    );

  }

}