

import 'package:cdma31/data/lista_produtos_repository.dart';
import 'package:cdma31/data/produtos_repository.dart';
import 'package:cdma31/redux/produtos/produtos_actions.dart';
import 'package:cdma31/util/logger.dart';
import 'package:redux/redux.dart';

import '../app_state.dart';
import '../stream_subscriptions.dart';

List<Middleware<AppState>> createProdutosMiddleware( ProdutosRepository produtosRepository ) {

  return [
    TypedMiddleware<AppState, BuscaListaProdutosCadastrados>(_loadDataProdutos(produtosRepository)),
    TypedMiddleware<AppState, SalvarProduto>(_salvarProduto(produtosRepository)),


  ];
}

void Function(
    Store<AppState> store,
    BuscaListaProdutosCadastrados action,
    NextDispatcher next,
    ) _loadDataProdutos(
    ProdutosRepository produtosRepository,
    ) {
  return (store, action, next) {
    next(action);

    try {
      produtosSubscription?.cancel();
      produtosSubscription =
          produtosRepository.getProdutosStream().listen((lista) {
            store.dispatch(OnProdutosLoaded(lista));

          });
    } catch (e) {
      Logger.e("Failed to subscribe to lista", e: e, s: StackTrace.current);
    }
  };
}

void Function(
    Store<AppState> store,
    SalvarProduto action,
    NextDispatcher next,
    ) _salvarProduto(
    ProdutosRepository produtosRepository,
    ) {
  return (store, action, next) {
    next(action);

    try {

          produtosRepository.salvarProduto(action.produto);
    } catch (e) {
      Logger.e("Failed to subscribe to lista", e: e, s: StackTrace.current);
    }
  };
}

