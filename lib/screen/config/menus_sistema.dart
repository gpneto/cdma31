import 'package:cdma31/screen/lista/lista_compras.dart';
import 'package:cdma31/screen/produtos/cadastro_produtos.dart';
import 'package:cdma31/util/app_localization.dart';
import 'package:cdma31/util/prefs.dart';
import 'package:cdma31/util/reorderable_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../../app_config.dart';
import '../base_stateless_screen.dart';
import 'info_list_section.dart';

class MenusSistema extends StatefulWidget {
  final BuildContext contextPai;

  const MenusSistema({Key key, this.contextPai}) : super(key: key);

  @override
  _MenusSistemaState createState() => _MenusSistemaState();
}

enum DraggingMode {
  iOS,
  Android,
}

class _MenusSistemaState extends State<MenusSistema> {


  @override
  void initState() {
    super.initState();
    menusDisponiveis = [ListaCompras(context),CadastroProdutos(context)];
    Prefs.singleton()
        .addListenerForPref(Prefs.MENUS_DISABLED_PREF, changeListenerMenu, executar: false);


  }


  PrefsListener changeListenerMenu(String key, Object value) {
    if (mounted) {
      setState(() {
        montaMenus(value, context);

      });
    }
  }


  List<BaseStatelessScreen> menusDisponiveis = [];

  List<Icon> menusDisponiveisIcone = [
  Icon( FontAwesomeIcons.shoppingCart),
    Icon( FontAwesomeIcons.shoppingBag)
//    TarefasUsuarioPage.iosIcon,
//    Icon(ViewNavegadorCompras.iosIcon)
  ];

  bool pimeiroAcesso = true;




  void montaMenus(Object value, BuildContext context) {
    menus = [];

    List<String> ordemMenus = Prefs.singleton().getOrdemMenu();

    menusDisponiveis.asMap().forEach((index, menuStr) {
      int index_inicial = ordemMenus.indexWhere((String d) => d == menuStr.id);
      List<String> menusD = value;
      var menuTarefas = CupertinoSwitch(
        value: menusD.where((t) => t == menuStr.id).length == 0,
        onChanged: (bool value) {
          if (mounted) {
            if (value) {
              Prefs.singleton().setTheme(Prefs.singleton().getTheme());
              Prefs.singleton().setMenuDisabledRemove(menuStr.id);
            } else {
              if (verificaQuantosMenusAtivos(menuStr.id)) {
                Prefs.singleton().setTheme(Prefs.singleton().getTheme());
                Prefs.singleton().setMenuDisabled(menuStr.id);
              } else {
                if (defaultTargetPlatformNative ==
                    TargetPlatformNative.android) {
//
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(AppLocalizations.of(context).attention),
                        content: Text( AppLocalizations.of(context).oneMenu),
                        actions: [
                          FlatButton(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    },
                  );

                }else{
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (context) {
                      return CupertinoActionSheet(
                        title: Text(AppLocalizations.of(context).attention),
                        message: Text( AppLocalizations.of(context).oneMenu),
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text('OK'),
                          isDefaultAction: true,
                          onPressed: () => Navigator.pop(context),
                        ),
                      );
                    },
                  );
                }
              }
            }

          }
        },
      );

      var menuTarefasColumn = Column(
        key: ValueKey(index),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              menusDisponiveisIcone[index],
              Container(

                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(left: 10),


                child:Text(
                  menuStr.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.body2.color),
                ),
              ),

              Expanded(child: Container(),),

              menuTarefas
            ],
          ),
          SizedBox(height: 20.0),
        ],
      );

      menus.add(
        Item(
            key: ValueKey(index),
            data: menuTarefasColumn,
            nome: menuStr.id,
            // first and last attributes affect border drawn during dragging
            isFirst: index == 0,
            isLast: index == menus.length - 1,
            draggingMode: _draggingMode,
            ordem: index_inicial == -1 ? index : index_inicial),
      );


    });

//    menus.sort()
    menus.sort((a, b) => a.ordem.compareTo(b.ordem));
  }




  bool verificaQuantosMenusAtivos(String title) {
    if (Prefs.singleton().getMenusDisabled().where((t) => t != title).length +
            1 ==
        menusDisponiveis.length) {
      return false;
    }

    return true;
  }

  List<Item> menus = [];

  // Returns index of item with given key
  int _indexOfKey(Key key) {
    return menus.indexWhere((Widget d) => d.key == key);
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    // Uncomment to allow only even target reorder possition
    // if (newPositionIndex % 2 == 1)
    //   return false;

    final draggedItem = menus[draggingIndex];
    setState(() {
      debugPrint("Reordering $item -> $newPosition");
      menus.removeAt(draggingIndex);
      menus.insert(newPositionIndex, draggedItem);
    });
    return true;
  }

  void _reorderDone(Key item) {
    final draggedItem = menus[_indexOfKey(item)];
    Prefs.singleton().setOrdemMenu(menus.map((f) => f.nome).toList());
    Prefs.singleton().setTheme(Prefs.singleton().getTheme());
    debugPrint("Reordering finished for ${draggedItem.key}}");
  }

  //
  // Reordering works by having ReorderableList widget in hierarchy
  // containing ReorderableItems widgets
  //

  DraggingMode _draggingMode = DraggingMode.iOS;

  Widget build(BuildContext context) {

    if(pimeiroAcesso){
      pimeiroAcesso = false;
      montaMenus(Prefs.singleton().getMenusDisabled(), context);
    }
    return InfoListSection(
      key: widget.key,
      title: AppLocalizations.of(context).menus,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("${AppLocalizations.of(context).active}:", style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.body2.color),),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 5),
                child: Text("${AppLocalizations.of(context).order}:", style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.body2.color),),
              ),
            ],
          ),
          ReorderableList(
            onReorder: this._reorderCallback,
            onReorderDone: this._reorderDone,
            child: Column(children: menus),
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  Item({
    Key key,
    this.data,
    this.isFirst,
    this.isLast,
    this.draggingMode,
    this.ordem,
    this.nome,
  }) : super(key: key);

  final Widget data;
  final bool isFirst;
  final bool isLast;
  final DraggingMode draggingMode;
  final int ordem;
  final String nome;

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
            top: isFirst && !placeholder
                ? Divider.createBorderSide(context) //
                : BorderSide.none,
            bottom: isLast && placeholder
                ? BorderSide.none //
                : Divider.createBorderSide(context),
          ),
          color: placeholder ? null : Colors.white);
    }

    // For iOS dragging mdoe, there will be drag handle on the right that triggers
    // reordering; For android mode it will be just an empty container
    Widget dragHandle = draggingMode == DraggingMode.iOS
        ? ReorderableListener(
            child: Container(
              padding: EdgeInsets.only(right: 18.0, left: 18.0),
              color: Color(0x08000000),
              child: Center(
                child: Icon(Icons.reorder, color: Color(0xFF888888)),
              ),
            ),
          )
        : Container();

    Widget content = Container(
//      decoration: decoration,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Opacity(
          // hide content for placeholder
          opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                    child: data,
                  ),
                ),
                // Triggers the reordering
                dragHandle,
              ],
            ),
          ),
        ),
      ),
    );

    // For android dragging mode, wrap the entire content in DelayedReorderableListener
    if (draggingMode == DraggingMode.Android) {
      content = DelayedReorderableListener(
        child: content,
      );
    }

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
        key: data.key, //
        childBuilder: _buildChild);
  }
}
