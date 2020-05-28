import "package:built_collection/built_collection.dart";
import "package:built_value/built_value.dart";
import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/lista_produto.dart';
import 'package:cdma31/redux/app_state.dart';

import "package:redux/redux.dart";

// ignore: prefer_double_quotes
part 'detalhes_compras_viewmodel.g.dart';

abstract class DetalhesComprasViewModel
    implements Built<DetalhesComprasViewModel, DetalhesComprasViewModelBuilder> {


  BuiltList<ListaProduto> get listaProdutosonScrean;

  bool get hasData;


  DetalhesComprasViewModel._();

  factory DetalhesComprasViewModel(
      [void Function(DetalhesComprasViewModelBuilder) updates]) =
  _$DetalhesComprasViewModel;

  static DetalhesComprasViewModel fromStore(Store<AppState> store) {
    return DetalhesComprasViewModel((m) => m
      ..listaProdutosonScrean = store.state.listaProdutosonScrean == null ? ListBuilder() : store.state.listaProdutosonScrean.toBuilder()
      ..hasData = store.state.listaProdutosonScrean == null  ?  false : !store.state.buscandoListaProdutosonScrean
);

  }
}
