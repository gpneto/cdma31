import 'dart:ui';

import 'package:cdma31/model/categoria.dart';
import 'package:cdma31/model/categoria.dart';
import 'package:cdma31/util/app_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CardCategoria extends StatelessWidget {
  final Categoria categoria;

  CardCategoria({Key key, this.categoria, contextpai}) {
    context = contextpai;
  }

  static BuildContext context;

  @override
  Widget build(BuildContext context) {
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
      child: Container(
//          padding: EdgeInsets.fromLTRB(15, 0, 5, 8),
        child: Stack(
          children: <Widget>[
            Hero(
              tag: categoria.id + "_background",
              child: Container(
                decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: AssetImage("assets/incidentes/medio.png"),
//                      fit: BoxFit.cover,
//                    ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Column(
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
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: categoria.id + "_title",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        categoria.nome == null ? "" : categoria.nome,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
                  child: getLinhaWhite(
                    AppLocalizations.of(context).description,
                    categoria.descricao,
                    categoria.id + "descricao",
                    alinhamento: CrossAxisAlignment.start,
                    color: Theme.of(context).textTheme.body2.color,),
                ),
              ],
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
      ),
    );
  }
}

class MessagesScrollController extends InheritedWidget {
  final ScrollController scrollController;

  const MessagesScrollController({
    Key key,
    @required Widget child,
    @required this.scrollController,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static MessagesScrollController of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(MessagesScrollController);
}

Widget getLinhaWhite(titulo, subtitulo, tag,
    {alinhamento = CrossAxisAlignment.start,
    overFlow = TextOverflow.ellipsis,
    maxLines = 1000,
    bottomP = 2.0,
    topP = 3.0,
    color}) {
  return Padding(
    padding: EdgeInsets.only(bottom: bottomP, top: topP),
    child: Hero(
        tag: tag,
        transitionOnUserGestures: true,
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          return SingleChildScrollView(
            child: toHeroContext.widget,
          );
        },
        child: Column(
          crossAxisAlignment: alinhamento,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Material(
                    color: Colors.transparent,
                    child: Text(
                      titulo != null ? titulo : "",
                      style: TextStyle(
                          color: Colors.green.shade800, fontSize: 14.0),
                    )),
                Container()
              ],
            ),
            Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(),
                    ),
                  ),
                ]),
            Container(
//              width: 30,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.lightGreen, width: 1.0),
                  ),
                ),
                child: ConstrainedBox(
                    constraints: new BoxConstraints(
                      minWidth: 100.0,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        subtitulo != null ? subtitulo : "",
                        style: color != null
                            ? TextStyle(fontSize: 15, color: color)
                            : TextStyle(fontSize: 15),
                        textAlign: TextAlign.start,
                        maxLines: maxLines,
                        overflow: overFlow,
                      ),
                    )))
          ],
        )),
  );
}

Widget getLinhaWhiteTitulo(titulo, subtitulo, tag,
    {alinhamento = CrossAxisAlignment.start,
    overFlow = TextOverflow.ellipsis,
    maxLines = 1000,
    fontSize = 15.0,
    bottomP = 2.0,
    topP = 3.0,
    color}) {
  return Hero(
      transitionOnUserGestures: true,
      tag: tag,
      child: FittedBox(
          child: Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomP, top: topP),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.lightGreen, width: 1.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: alinhamento,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Material(
                    color: Colors.transparent,
                    child: Text(
                      titulo != null ? titulo : "",
                      style: TextStyle(
                          color: Colors.green.shade800, fontSize: 14.0),
                    )),
                Material(
                    color: Colors.transparent,
                    child: Text(
                      subtitulo != null ? subtitulo : "",
                      style: color != null
                          ? TextStyle(fontSize: 15, color: color)
                          : TextStyle(fontSize: 15),
                      textAlign: TextAlign.start,
                      maxLines: maxLines,
                      overflow: overFlow,
                    )),
              ],
            ),
          ),
        ),
      )));
}

Widget getLinhaWhiteSimple(titulo, subtitulo,
    {alinhamento = CrossAxisAlignment.start,
    overFlow = TextOverflow.ellipsis,
    maxLines = 1000}) {
  return Padding(
    padding: const EdgeInsets.only(left: 0, right: 0, bottom: 1, top: 1),
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.lightGreen, width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: alinhamento,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            titulo != null ? titulo : "",
            style: TextStyle(color: Colors.green.shade800, fontSize: 14.0),
          ),
          Material(
            color: Colors.transparent,
            child: Text(
              subtitulo != null ? subtitulo : "",
              style: TextStyle(fontSize: 15, color: Colors.black),
              textAlign: TextAlign.start,
              maxLines: maxLines,
              overflow: overFlow,
            ),
          ),
        ],
      ),
    ),
  );
}
