
import "package:built_collection/built_collection.dart";
import "package:built_value/built_value.dart";
import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/lista_produto.dart';
import 'package:cdma31/model/produto.dart';
import 'package:cdma31/model/user.dart';
import 'package:cdma31/screen/login/login_screen_viewmodel.dart';

part 'app_state.g.dart';


abstract class AppState implements Built<AppState, AppStateBuilder> {

  @nullable
  User get user;

  @nullable
  String get fcmToken;

  //********LOGIN
  @nullable
  StateLogin get stateLogin;

  //*******LISTA **/
  BuiltList<Lista> get listaCompras;
  bool get buscandoLista;

  //*******PRODUTOS NA TELA **/
  @nullable
  BuiltList<ListaProduto> get listaProdutosonScrean;
  bool get buscandoListaProdutosonScrean;

  //*******CADASTRO DE PRODUTOS**/
  @nullable
  BuiltList<Produto> get produtosonScrean;
  bool get buscandoProdutosonScrean;


  AppState._();

  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;

  factory AppState.init() => AppState((a) => a ..stateLogin  = StateLogin.init
  ..buscandoLista =false
  ..buscandoListaProdutosonScrean = false
  ..buscandoProdutosonScrean =  false);




}