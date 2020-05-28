import "package:built_collection/built_collection.dart";
import "package:built_value/built_value.dart";
import 'package:cdma31/model/lista.dart';
import 'package:cdma31/redux/app_state.dart';

import "package:redux/redux.dart";

// ignore: prefer_double_quotes
part 'lista_compras_viewmodel.g.dart';

abstract class ListaComprasViewModel
    implements Built<ListaComprasViewModel, ListaComprasViewModelBuilder> {


  BuiltList<Lista> get listaCompras;

  bool get hasData;


  ListaComprasViewModel._();

  factory ListaComprasViewModel(
      [void Function(ListaComprasViewModelBuilder) updates]) =
  _$ListaComprasViewModel;

  static ListaComprasViewModel fromStore(Store<AppState> store) {
    return ListaComprasViewModel((m) => m
      ..listaCompras = store.state.listaCompras.toBuilder()
      ..hasData = store.state.listaCompras == null ? true : !store.state.buscandoLista
);

  }
}
