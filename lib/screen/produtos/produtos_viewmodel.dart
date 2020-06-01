import "package:built_collection/built_collection.dart";
import "package:built_value/built_value.dart";
import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/produto.dart';
import 'package:cdma31/redux/app_state.dart';

import "package:redux/redux.dart";

// ignore: prefer_double_quotes
part 'produtos_viewmodel.g.dart';

abstract class ProdutosViewModel
    implements Built<ProdutosViewModel, ProdutosViewModelBuilder> {


  BuiltList<Produto> get produtos;

  bool get hasData;


  ProdutosViewModel._();

  factory ProdutosViewModel(
      [void Function(ProdutosViewModelBuilder) updates]) =
  _$ProdutosViewModel;

  static ProdutosViewModel fromStore(Store<AppState> store) {
    return ProdutosViewModel((m) => m
      ..produtos = store.state.produtosonScrean == null ? ListBuilder() :  store.state.produtosonScrean.toBuilder()
      ..hasData =  !store.state.buscandoProdutosonScrean
);

  }
}
