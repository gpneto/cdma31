import 'dart:ui';

import 'package:cdma31/model/lista_produto.dart';
import 'package:cdma31/screen/lista/lista_compras.dart';
import 'package:cdma31/util/app_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../card_lista.dart';

class CardListaProduto extends StatefulWidget {
  final ListaProduto listaProduto;
  final isAdd;

  CardListaProduto({Key key, this.listaProduto, contextpai, this.isAdd}) {
    context = contextpai;
  }

  static BuildContext context;

  @override
  _CardListaProdutoState createState() => _CardListaProdutoState();
}

class _CardListaProdutoState extends State<CardListaProduto>
    with AutomaticKeepAliveClientMixin<CardListaProduto> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    //Tem que que buscar os detalhe

    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
      decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage("assets/incidentes/medio.png"),
//            fit: BoxFit.cover,
//          ),
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      child: StreamBuilder<DocumentSnapshot>(
          stream: widget.listaProduto.produto.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return Container(
//          padding: EdgeInsets.fromLTRB(15, 0, 5, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 5, 5, 8),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(63, 185, 59, 1.0),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    width: double.infinity,
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data["nome"],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          widget.isAdd
                              ? Container()
                              : Checkbox(
                                  value: widget.listaProduto.selecionado == null
                                      ? false
                                      : widget.listaProduto.selecionado,
                                  onChanged: (selecinado) {
                                    widget.listaProduto.ref.setData(
                                        {'selecionado': selecinado},
                                        merge: true);
                                  })
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
                    child: getLinhaWhiteSimple(
                        AppLocalizations.of(context).quantity,
                        '${widget.listaProduto.quantidade} ${snapshot.data["unidade_medida"]}',
                        color: Theme.of(context).textTheme.body2.color),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 8, 5),
                    child: getLinhaWhiteSimple(
                        AppLocalizations.of(context).note,
                        widget.listaProduto.obs,
                        color: Theme.of(context).textTheme.body2.color),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.027, 0.027],
                  colors: [Color.fromRGBO(93, 230, 26, 1), Colors.transparent],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            );
          }),
    );
  }
}
