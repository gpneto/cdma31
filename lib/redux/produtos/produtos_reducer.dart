

import 'package:cdma31/redux/login/auth_actions.dart';
import 'package:cdma31/redux/produtos/produtos_actions.dart';
import 'package:redux/redux.dart';
import "package:built_collection/built_collection.dart";
import '../app_state.dart';

final produtosReducers = <AppState Function(AppState, dynamic)>[
  TypedReducer<AppState, OnProdutosLoaded>(_onProdutos),


];

AppState _onProdutos(AppState state, OnProdutosLoaded action) {
  AppState a = state.rebuild((a) => a..produtosonScrean =  ListBuilder(action.produtos));
  return a;
}
