

import 'package:cdma31/redux/categoria/categoria_actions.dart';
import 'package:cdma31/redux/login/auth_actions.dart';
import 'package:cdma31/redux/produtos/produtos_actions.dart';
import 'package:redux/redux.dart';
import "package:built_collection/built_collection.dart";
import '../app_state.dart';

final categoriasReducers = <AppState Function(AppState, dynamic)>[
  TypedReducer<AppState, OnCategoriaLoaded>(_onCategoria),


];

AppState _onCategoria(AppState state, OnCategoriaLoaded action) {
  AppState a = state.rebuild((a) => a..categoriaonScrean =  ListBuilder(action.categorias)
  ..buscandoCategoriasonScrean = false);
  return a;
}
