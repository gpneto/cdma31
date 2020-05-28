


import 'package:cdma31/model/lista_produto.dart';
import 'package:cdma31/redux/produtos/produtos_reducer.dart';
import 'package:cdma31/redux/user/user_reducer.dart';
import "package:redux/redux.dart";
import "package:built_collection/built_collection.dart";
import "package:built_value/built_value.dart";

import 'app_actions.dart';
import 'app_state.dart';
import 'login/auth_reducer.dart';

/// Reducers specify how the application"s state changes in response to actions
/// sent to the store.
///
/// Each reducer returns a new [AppState].
///
final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, OnListaLoaded>(_onListaLoaded),
  TypedReducer<AppState, OnListaProdutosLoaded>(_onListaProdutosLoaded),
  ...authReducers,
  ...userReducers,
  ...produtosReducers
]);


AppState _onListaLoaded(AppState state, OnListaLoaded action) {
  if (action.listaCompras.isNotEmpty) {
    return state.rebuild((a) => a
      ..listaCompras =  ListBuilder(action.listaCompras));
  } else {
    return state.rebuild((a) => a
      ..listaCompras = ListBuilder());
  }
}

AppState _onListaProdutosLoaded(AppState state, OnListaProdutosLoaded action) {
  if (action.listaProdutos.isNotEmpty) {
    action.listaProdutos.sort(( a, b) {
      return '${(a as ListaProduto).inicialNome}'.compareTo('${(b as ListaProduto).inicialNome }');
    });
    return state.rebuild((a) => a
      ..listaProdutosonScrean =  ListBuilder(action.listaProdutos));
  } else {
    return state.rebuild((a) => a
      ..listaProdutosonScrean = ListBuilder());
  }
}
