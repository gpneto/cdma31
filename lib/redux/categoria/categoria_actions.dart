import "dart:async";
import 'package:cdma31/model/categoria.dart';
import 'package:cdma31/model/categoria.dart';
import 'package:cdma31/model/user.dart';
import 'package:cdma31/screen/login/login_screen_viewmodel.dart';
import 'package:flutter/cupertino.dart';

import "package:meta/meta.dart";

class BuscaListaCategoriaCadastrados {
  BuscaListaCategoriaCadastrados();
  @override
  String toString() {
    return "BuscaListaCategoriaCadastrados";
  }
}


@immutable
class OnCategoriaLoaded {
  final List<Categoria> categorias;

  const OnCategoriaLoaded(this.categorias);

  @override
  String toString() {
    return "OnCategoriaLoaded{lista: $categorias}";
  }
}


@immutable
class SalvarCategoria {
  final Categoria categoria;

  const SalvarCategoria(this.categoria);

  @override
  String toString() {
    return "SalvarCategoria{lista: $categoria}";
  }
}