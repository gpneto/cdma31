import "dart:async";
import 'package:cdma31/model/produto.dart';
import 'package:cdma31/model/user.dart';
import 'package:cdma31/screen/login/login_screen_viewmodel.dart';
import 'package:flutter/cupertino.dart';

import "package:meta/meta.dart";

class BuscaListaProdutosCadastrados {
  BuscaListaProdutosCadastrados();
  @override
  String toString() {
    return "BuscaListaProdutosCadastrados";
  }
}


@immutable
class OnProdutosLoaded {
  final List<Produto> produtos;

  const OnProdutosLoaded(this.produtos);

  @override
  String toString() {
    return "OnProdutosLoaded{lista: $produtos}";
  }
}


@immutable
class SalvarProduto {
  final Produto produto;

  const SalvarProduto(this.produto);

  @override
  String toString() {
    return "SalvarProduto{lista: $produto}";
  }
}