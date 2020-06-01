


import 'package:cdma31/data/lista_produtos_repository.dart';
import 'package:cdma31/data/lista_repository.dart';
import 'package:cdma31/redux/app_actions.dart';
import 'package:cdma31/redux/produtos/produtos_actions.dart';
import 'package:cdma31/redux/stream_subscriptions.dart';
import 'package:cdma31/util/logger.dart';
import "package:redux/redux.dart";

import 'app_state.dart';
import 'categoria/categoria_actions.dart';



List<Middleware<AppState>> createStoreMiddleware(  ListaRepository listaRepository, ListaProdutosRepository listaProdutosRepository ) {

  return [
    TypedMiddleware<AppState, BuscaListaInicial>(_loadData(listaRepository)),
    TypedMiddleware<AppState, BuscaListaProdutos>(_loadDataProdutos(listaProdutosRepository)),
    TypedMiddleware<AppState, SalvaListaCompras>(_salvaListaCompras(listaRepository)),
    TypedMiddleware<AppState, EditaLista>(_editaListaCompras(listaRepository)),
  ];
}

void Function(
    Store<AppState> store,
    BuscaListaInicial action,
    NextDispatcher next,
    ) _loadData(
    ListaRepository groupRepository,
    ) {
  return (store, action, next) {
    next(action);

    try {
      listaSubscription?.cancel();
      listaSubscription =
          groupRepository.getListaComptasStream(store.state.user.uid).listen((lista) {
            store.dispatch(OnListaLoaded(lista));

          });

      // Busca os outros cadastros
      store.dispatch(BuscaListaProdutosCadastrados());
      store.dispatch(BuscaListaCategoriaCadastrados());
    } catch (e) {
      Logger.e("Failed to subscribe to lista", e: e, s: StackTrace.current);
    }
  };
}

void Function(
    Store<AppState> store,
    BuscaListaProdutos action,
    NextDispatcher next,
    ) _loadDataProdutos(
    ListaProdutosRepository groupRepository,
    ) {
  return (store, action, next) {
    next(action);

    try {
      listaProdutosSubscription?.cancel();
      listaProdutosSubscription =
          groupRepository.getListaProdutosStream(action.listaProdutosRef).listen((produtos) {
            store.dispatch(OnListaProdutosLoaded(produtos));

          });
    } catch (e) {
      Logger.e("Failed to subscribe to lista", e: e, s: StackTrace.current);
    }
  };
}



void Function(
    Store<AppState> store,
    SalvaListaCompras action,
    NextDispatcher next,
    ) _salvaListaCompras(
    ListaRepository groupRepository,
    ) {
  return (store, action, next) {
    next(action);
    try {
      listaSubscription =
          groupRepository.salvarLista(action.lista,store.state.user.uid);
    } catch (e) {
      Logger.e("Failed to subscribe to lista", e: e, s: StackTrace.current);
    }
  };
}

void Function(
    Store<AppState> store,
    EditaLista action,
    NextDispatcher next,
    ) _editaListaCompras(
    ListaRepository groupRepository,
    ) {
  return (store, action, next) {
    next(action);
    try {
      listaSubscription =
          groupRepository.editaLista(action.lista);
    } catch (e) {
      Logger.e("Failed to subscribe to lista", e: e, s: StackTrace.current);
    }
  };
}