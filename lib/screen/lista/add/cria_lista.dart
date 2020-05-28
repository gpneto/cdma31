import 'package:cdma31/data/produtos_repository.dart';
import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/lista_add.dart';
import 'package:cdma31/model/lista_produto.dart';
import 'package:cdma31/model/produto.dart';
import 'package:cdma31/redux/app_actions.dart';
import 'package:cdma31/redux/app_state.dart';
import 'package:cdma31/screen/lista/detalhes/card_lista_produto.dart';
import 'package:cdma31/screen/lista/detalhes/detalhes_compras_viewmodel.dart';
import 'package:cdma31/screen/login/InputFields.dart';
import 'package:cdma31/screen/produtos/produtos_viewmodel.dart';
import 'package:cdma31/scroll/scrollable_positioned_list.dart';
import 'package:cdma31/util/MyCupertinoPageRoute.dart';
import 'package:cdma31/util/app_localization.dart';
import 'package:cdma31/util/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart' as intl;
import "package:built_collection/built_collection.dart";

class CriarLista extends StatefulWidget {
  Lista lista;
  List<ListaProduto> produtos;
  CriarLista(this.lista,this.produtos,{Key key}) : super(key: key);

  @override
  _CriarListaState createState() => _CriarListaState();
}

class _CriarListaState extends State<CriarLista> with TickerProviderStateMixin {
  double percentComplete;
  AnimationController animationBar;
  double barPercent = 0.0;
  Tween<double> animT;
  AnimationController scaleAnimation;

  List<ListaProduto> produtos = [];
  TextEditingController descricao;

  @override
  void initState() {
    descricao = TextEditingController(text: widget.lista == null ? "" :  widget.lista.descricao);
    produtos = widget.produtos == null ? [] :  widget.produtos;

    scaleAnimation = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        lowerBound: 0.0,
        upperBound: 1.0);

//    percentComplete = widget.todoObject.percentualExecuao.toDouble() / 100;
    barPercent = percentComplete;
    animationBar = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {
          barPercent = animT.lerp(animationBar.value);
        });
      });
    animT = Tween<double>(begin: percentComplete, end: percentComplete);
    scaleAnimation.forward();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/fundo_detalhes.jpg"),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: Text(
                          AppLocalizations.of(context).newList,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 25.0),
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 30,
                  ),
                ],
              ),
              leading: IconButton(
                color: Theme.of(context).iconTheme.color,
                icon: const BackButtonIcon(),
                onPressed: () {
                  if(widget.lista != null){
                    salvarLista();
                  }else{
                    voltar();
                  }
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Form(
                        child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        new InputFieldArea(
                          hint: AppLocalizations.of(context).description,
                          controller: descricao,
                          obscure: false,
                          color: Colors.black,
                          icon: Icons.person_outline,
//                              controller: username
                        ),
                      ],
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            AppLocalizations.of(context).products + ":",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25.0, color: Colors.green),
                            softWrap: false,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  right: 8, top: 10, bottom: 10),
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
                                      padding: const EdgeInsets.only(
                                          top: 2, bottom: 2),
                                      child: FloatingActionButton(
                                        backgroundColor: Colors.green,
                                        heroTag: 'heroVerde',
                                        onPressed: () => mostradialogo(),
//                                    backgroundColor: Colors.transparent,
                                        mini: true,
                                        child: Icon(Icons.add),
                                      )))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      type: MaterialType.transparency,
                      child: FadeTransition(
                        opacity: scaleAnimation,
                        child: ScaleTransition(
                          scale: scaleAnimation,
                          child: Container(
                              child: ListView.builder(
                            padding: const EdgeInsets.all(10.0),
                            itemBuilder: (BuildContext context, int index) {
                              ListaProduto lista = produtos[index];
                              return Dismissible(
                                key: UniqueKey(),
                                child: CardListaProduto(
                                  listaProduto: lista,
                                  isAdd: true,
                                ),
                                onDismissed: (direction) {
                                  // Remove the item from the data source.

                                  setState(() {
                                    produtos.removeAt(index);
                                  });

                                  // Show a snackbar. This snackbar could also contain "Undo" actions.
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text("removido")));
                                },
                              );
                            },
                            itemCount: produtos == null ? 0 : produtos.length,
                          )),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      color: Colors.green,
                      onPressed: () {
                        salvarLista();

                      },
                      elevation: 11,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.0))),
                      child:
                          Text(AppLocalizations.of(context).save, style: TextStyle(color: Colors.white70)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      onWillPop: () => salvarLista(),
    );
  }

  voltar(){
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.of(context).pop();
  }
  salvarLista(){
    FocusScope.of(context).requestFocus(FocusNode());
    //Salva a Lista no Firebase
    ListaAdd listaNova = ListaAdd((l) => l
      ..produtosSelecionados = ListBuilder(produtos)
      ..descricao = descricao.value.text);
    if(widget.lista != null){
      listaNova = listaNova.rebuild((l) => l..ref =  widget.lista.produtosRef);
      StoreProvider.of<AppState>(context).dispatch(EditaLista(listaNova));
      Navigator.of(context).pop();
    }else{
      StoreProvider.of<AppState>(context).dispatch(SalvaListaCompras(listaNova));
    }

    Navigator.of(context).pop();
  }

  var _itemSelecionado = null;
  var _nome = null;
  final _formKey = GlobalKey<FormState>();

  mostradialogo() async {
    ListaProduto produtoItem = ListaProduto();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                    right: -40.0,
                    top: -40.0,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.close),
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: StoreConnector<AppState, ProdutosViewModel>(
                              distinct: true,
                              converter: ProdutosViewModel.fromStore,
                              builder: (context, vm) {
                                if (!vm.hasData) {
                                  return Container();
                                }
                                return DropdownButton<String>(
                                  value: _itemSelecionado,
                                  onChanged: (String novoItemSelecionado) {
                                    setState(() {
                                      this._itemSelecionado =
                                          novoItemSelecionado;
                                      this._nome =  vm.produtos.where((f) => f.id == novoItemSelecionado).toList()[0].nome;
                                    });
                                  },
                                  items: vm.produtos
                                      .map((Produto dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                      value: dropDownStringItem.id,
                                      child: Text(dropDownStringItem.nome),
                                    );
                                  }).toList(),
                                  hint: Text(
                                    AppLocalizations.of(context).selectProduct,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).quantity,
                              contentPadding: EdgeInsets.all(15.0),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintStyle:  TextStyle(color: Colors.black.withAlpha(100)),
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context).enter;
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              produtoItem = produtoItem
                                  .rebuild((p) => p..quantidade = value);
                            },
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).note,
                              contentPadding: EdgeInsets.all(15.0),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintStyle:  TextStyle(color: Colors.black.withAlpha(100)),
                            ),
                            validator: (String value) {
                              return null;
                            },
                            onSaved: (String value) {
                              produtoItem =
                                  produtoItem.rebuild((p) => p..obs = value);
                            },
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            child: Text(AppLocalizations.of(context).add),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                produtoItem = produtoItem.rebuild((p) => p
                                  ..produto = Firestore.instance.document(
                                      ProdutosRepository.PATH +
                                          '/$_itemSelecionado')
                                ..inicialNome = _nome.toString().substring(0,1));
                                produtos.add(produtoItem);
                                _dropDownItemSelected();
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  void _dropDownItemSelected() {
    setState(() {});
  }
}
