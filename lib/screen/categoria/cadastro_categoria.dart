import 'package:cdma31/model/categoria.dart';
import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/categoria.dart';
import 'package:cdma31/redux/app_state.dart';
import 'package:cdma31/redux/categoria/categoria_actions.dart';
import 'package:cdma31/screen/categoria/card_categoria.dart';
import 'package:cdma31/screen/lista/card_lista.dart';
import 'package:cdma31/screen/lista/lista_compras_viewmodel.dart';
import 'package:cdma31/screen/categoria/categoria_viewmodel.dart';
import 'package:cdma31/scroll/scrollable_positioned_list.dart';
import 'package:cdma31/util/app_localization.dart';
import 'package:cdma31/util/platform_widget_native.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app_config.dart';
import '../../application.dart';
import '../base_stateless_screen.dart';


class CadastroCategoria extends BaseStatelessScreen {


  final BuildContext context;

  CadastroCategoria(this.context);

  @override
  String get title => AppLocalizations.of(context).category;

  IconData get androidIcon => FontAwesomeIcons.boxes;

  @override
  IconData get iosIcon => FontAwesomeIcons.boxes;

  @override
  String get id => "Categoria";

  @override
  _CadastroCategoriaState createState() => _CadastroCategoriaState();
}

class _CadastroCategoriaState extends State<CadastroCategoria>
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
  }

  Icon actionIcon = Icon(Icons.search);
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

  bool primeiroacesso = true;

  Widget buildWidget() {
    var size = MediaQuery.of(context).size;
    nomeUser = Text(
//          "Olá, ${vm.user.name.split(' ')[0]}.",
      AppLocalizations.of(context).categories,
      style: TextStyle(
          fontSize: 30.0, color: Theme.of(context).textTheme.title.color),
    );
    if (primeiroacesso) {
      appBarTitle = nomeUser;
      primeiroacesso = false;
    }

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
                            onPressed: () => showFancyCustomDialog(context),
//                                    backgroundColor: Colors.transparent,
                            mini: true,
                            child: Icon(Icons.add),
                          )))),
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
                            heroTag: 'actionIconTGG',
                            onPressed: () => {
                              setState(() {
                                if (this.actionIcon.icon == Icons.search) {
                                  this.actionIcon = new Icon(Icons.close);
                                  this.appBarTitle = new TextField(
                                    onChanged: (on) {
                                      setState(() {
                                        filter = on;
                                      });
                                    },
                                    autofocus: true,
                                    decoration: new InputDecoration(
                                      prefixIcon: new Icon(Icons.search,
                                          color: Colors.white),
                                      hintText: AppLocalizations.of(context).search,
                                    ),
                                  );
                                } else {
                                  filter = '';

                                  this.actionIcon = new Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  );
                                  this.appBarTitle = nomeUser;
                                }
                              })
                            },
//                                    backgroundColor: Colors.transparent,
                            mini: true,
                            child: actionIcon,
                          )))),
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
                          child: StoreConnector<AppState, CategoriaViewModel>(
                            distinct: true,
                            converter: CategoriaViewModel.fromStore,
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
                                                AppLocalizations.of(context).searchCategories,
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
                              if (vm.categoria != null) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Stack(
                                          children: <Widget>[
                                            vm.categoria.length == 0
                                                ? Container(
//                                                height: 400,
                                                    child: Center(
                                                    child: Text(AppLocalizations.of(context).noCategories,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white70,
                                                            fontSize: 20.0)),
                                                  ))
                                                : Container(),
                                            ScrollablePositionedList.builder(
//                                          reverse: true,
                                              itemCount: vm.categoria.length,
                                              itemBuilder: (context, index) {
                                                if (vm.categoria.length == 0) {
                                                  return Container();
                                                }
                                                Categoria categoria =
                                                    vm.categoria[index];
                                                return Padding(
                                                    padding: EdgeInsets.only(
                                                        top:
                                                            index == 0 ? 17 : 0,
                                                        bottom: index ==
                                                                vm.categoria
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
                                                                    vm.categoria
                                                                            .length -
                                                                        1
                                                                ? true
                                                                : false,
                                                        child: Dismissible(
                                                          key: ObjectKey(
                                                              categoria.id),
                                                          child:
                                                          InkWell(
                                                            onTap: () async {
                                                              //Abre a tela com os detalhes
                                                              showFancyCustomDialog(
                                                                  context,
                                                                  cateforiaSelecionada:
                                                                  categoria);
                                                            },
                                                            child: CardCategoria(
                                                              categoria: categoria,
                                                              contextpai: context,
                                                            ),
                                                          )

                                                          ,
                                                          onDismissed:
                                                              (direction) {
                                                            // Remove the item from the data source.
//                                                          categoria.path
                                                            categoria.ref
                                                                .setData({
                                                              "status":
                                                                  "INATIVO"
                                                            }, merge: true);
                                                            // Show a snackbar. This snackbar could also contain "Undo" actions.
                                                            Scaffold.of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text(AppLocalizations.of(context).removedCategory)));
                                                          },
                                                        )));
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
                      ])),
                ),
              ],
            ),
          ),
        ));

    return retorno;
  }

  final _formKey = GlobalKey<FormState>();


  void showFancyCustomDialog(BuildContext context, {Categoria cateforiaSelecionada}) {
    Categoria categoria = cateforiaSelecionada;

    if (categoria == null) {
      categoria = Categoria();
    }

    StatefulBuilder fancyDialog = StatefulBuilder(builder: (context, setState) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),

          ),
          height: 250.0,
//          width: 300.0,
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
//                height: 400,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    categoria.ref != null ? AppLocalizations.of(context).toEdit :   AppLocalizations.of(context).category,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child:   Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: TextEditingController(text: categoria.nome),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).nameOfCategory,
                            contentPadding: EdgeInsets.all(15.0),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintStyle:  TextStyle(color: Colors.black.withAlpha(100)),

                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context).enterName;
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            categoria = categoria.rebuild((p) => p..nome = value);
                          },
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: TextEditingController(text: categoria.descricao),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).description,
                            contentPadding: EdgeInsets.all(15.0),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintStyle:  TextStyle(color: Colors.black.withAlpha(100)),

                          ),
                          validator: (String value) {
//                            if (value.isEmpty) {
//                              return AppLocalizations.of(context).enter;
//                            }
                            return null;
                          },
                          onSaved: (String value) {
                            categoria = categoria.rebuild((p) => p..descricao = value);
                          },
                          style: TextStyle(color: Colors.black),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {

                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      StoreProvider.of<AppState>(context)
                          .dispatch(SalvarCategoria(categoria));

                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context).save,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                // These values are based on trial & error method
                alignment: Alignment(1.05, -1.05),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }


}
