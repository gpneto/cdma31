import "package:built_collection/built_collection.dart";
import "package:built_value/built_value.dart";
import 'package:cdma31/model/categoria.dart';
import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/produto.dart';
import 'package:cdma31/redux/app_state.dart';

import "package:redux/redux.dart";

// ignore: prefer_double_quotes
part 'categoria_viewmodel.g.dart';

abstract class CategoriaViewModel
    implements Built<CategoriaViewModel, CategoriaViewModelBuilder> {


  BuiltList<Categoria> get categoria;

  bool get hasData;


  CategoriaViewModel._();

  factory CategoriaViewModel(
      [void Function(CategoriaViewModelBuilder) updates]) =
  _$CategoriaViewModel;

  static CategoriaViewModel fromStore(Store<AppState> store) {
    return CategoriaViewModel((m) => m
      ..categoria = store.state.categoriaonScrean == null ? ListBuilder() :  store.state.categoriaonScrean.toBuilder()
      ..hasData = !store.state.buscandoCategoriasonScrean
);

  }
}
