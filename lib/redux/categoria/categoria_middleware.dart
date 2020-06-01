

import 'package:cdma31/data/categoria_repository.dart';

import 'package:cdma31/data/categoria_repository.dart';
import 'package:cdma31/redux/categoria/categoria_actions.dart';
import 'package:cdma31/util/logger.dart';
import 'package:redux/redux.dart';

import '../app_state.dart';
import '../stream_subscriptions.dart';
import 'categoria_actions.dart';

List<Middleware<AppState>> createCategoriaMiddleware( CategoriaRepository categoriaRepository ) {

  return [
    TypedMiddleware<AppState, BuscaListaCategoriaCadastrados>(_loadDataCategoria(categoriaRepository)),
    TypedMiddleware<AppState, SalvarCategoria>(_salvarCategoria(categoriaRepository)),


  ];
}

void Function(
    Store<AppState> store,
    BuscaListaCategoriaCadastrados action,
    NextDispatcher next,
    ) _loadDataCategoria(
    CategoriaRepository categoriaRepository,
    ) {
  return (store, action, next) {
    next(action);

    try {
      categoriaSubscription?.cancel();
      categoriaSubscription =
          categoriaRepository.getCategoriaStream(store.state.user.uid).listen((lista) {
            store.dispatch(OnCategoriaLoaded(lista));

          });
    } catch (e) {
      Logger.e("Failed to subscribe to lista", e: e, s: StackTrace.current);
    }
  };
}

void Function(
    Store<AppState> store,
    SalvarCategoria action,
    NextDispatcher next,
    ) _salvarCategoria(
    CategoriaRepository categoriaRepository,
    ) {
  return (store, action, next) {
    next(action);

    try {

          categoriaRepository.salvarCategoria(action.categoria,store.state.user.uid);
    } catch (e) {
      Logger.e("Failed to subscribe to lista", e: e, s: StackTrace.current);
    }
  };
}

