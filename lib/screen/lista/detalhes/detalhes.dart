import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/lista_produto.dart';
import 'package:cdma31/redux/app_state.dart';
import 'package:cdma31/scroll/scrollable_positioned_list.dart';
import 'package:cdma31/util/MyCupertinoPageRoute.dart';
import 'package:cdma31/util/app_localization.dart';
import 'package:cdma31/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart' as intl;
import '../../../app_config.dart';
import '../card_lista.dart';
import '../lista_compras_viewmodel.dart';
import 'card_lista_produto.dart';
import 'detalhes_compras_viewmodel.dart';

class SecondPageRoute extends MyCupertinoPageRoute {
  final Lista lista;

  SecondPageRoute({this.lista})
      : super(
          builder: (BuildContext context) => DetailPage(lista: lista),
        );

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: new FadeTransition(
        opacity: animation,
        child: new FadeTransition(
          opacity: animation,
          child: DetailPage(lista: lista),
        ),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  DetailPage({@required this.lista, Key key}) : super(key: key);

  final Lista lista;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  double percentComplete;
  AnimationController animationBar;
  double barPercent = 0.0;
  Tween<double> animT;
  AnimationController scaleAnimation;

  @override
  void initState() {
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

  List<ListaProduto> produtos;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return StoreConnector<AppState, DetalhesComprasViewModel>(
      distinct: false,
      converter: DetalhesComprasViewModel.fromStore,
      builder: (context, vm) {
        if (vm.listaProdutosonScrean != null) {
          produtos = vm.listaProdutosonScrean.toList();
        }



        List<Widget> slivers = new List<Widget>();
        slivers.add(SliverAppBar(
          backgroundColor: Colors.transparent,
          titleSpacing: 0.0,
          elevation: 10,
          leading: IconButton(
            color: Theme.of(context).iconTheme.color,
            icon: const BackButtonIcon(),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    transitionOnUserGestures: true,
                    tag: widget.lista.id + "_title",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        intl.DateFormat('dd/MM/yyy').format(widget.lista.data),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Theme.of(context).textTheme.body1.color),
                        softWrap: false,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 30,
              ),
            ],
          ),
          pinned: true,
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
                    onPressed: () => Navigator.pushNamed(
                        context, Routes.criarLista, arguments: {
                      'lista': widget.lista,
                      'produtos': produtos
                    }),
//                                    backgroundColor: Colors.transparent,
                    mini: true,
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
            )
          ],
//      bottom: PreferredSize(child: topButton, preferredSize: Size.fromHeight(50.0)),
        ));
        slivers.add(SliverStickyHeaderBuilder(
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[ Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                width: double.infinity,
                child: getLinhaWhite(
                    AppLocalizations.of(context).description,
                    widget.lista.descricao == null ? "" : widget.lista.descricao,
                    widget.lista.id + "_descricao",
                    alinhamento: CrossAxisAlignment.start),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: double.infinity,
                  child: getLinhaWhite(
                    AppLocalizations.of(context).quantityOfProducts,
                    widget.lista.totalItens.toString(),
                    widget.lista.id + "totalItens",
                    alinhamento: CrossAxisAlignment.start,
                    maxLines: 2,
                    overFlow: TextOverflow.clip,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    AppLocalizations.of(context).products + ":",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25.0, color: Colors.green),
                    softWrap: false,
                  ),
                ),
              )]),
        ));
        slivers.add(SliverStickyHeaderBuilder(
          builder: (context, state) => Container(),
          sliver: SliverList(
            delegate: new SliverChildListDelegate(
              vm.hasData ? vm.listaProdutosonScrean.toList().map((e) => CardListaProduto(listaProduto: e, isAdd: false,)).toList()
              :
              [
                  Center(child: CircularProgressIndicator(),),
                ],

            ),
          ),),

        );

        return Stack(
          children: <Widget>[
            Hero(
              transitionOnUserGestures: true,
              tag: widget.lista.id + "_background",
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/fundo_detalhes.jpg"),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
            SimpleScaffold(
              child: Builder(builder: (BuildContext context) {
                return CustomScrollView(
                  slivers: slivers,
                );
              }),
            )
          ],
        );

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Buscando tarefas...",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 17.0),
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
      },
    );
  }
}

class SimpleScaffold extends StatelessWidget {
  const SimpleScaffold({
    Key key,
    this.child,
    this.floatingActionButton,
  }) : super(key: key);

  final Widget child;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.transparent,
        body: child,
        floatingActionButton: floatingActionButton);
  }
}
