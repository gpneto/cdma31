

import 'dart:io';

import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/lista_add.dart';
import 'package:cdma31/model/lista_produto.dart';
import 'package:cdma31/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';



@immutable
class ChangeAvatarAction {
  final File file;
  final User user;

  const ChangeAvatarAction({
    @required this.file,
    @required this.user,
  });
}


class UpdateUserTokenAction {
  final String token;

  UpdateUserTokenAction(this.token);
}



class BuscaListaInicial {
  @override
  String toString() {
    return "BuscaListaInicial";
  }
}


@immutable
class OnListaLoaded {
  final List<Lista> listaCompras;

  const OnListaLoaded(this.listaCompras);

  @override
  String toString() {
    return "OnGroupsLoaded{lista: $listaCompras}";
  }
}


class BuscaListaProdutos {
  final DocumentReference listaProdutosRef;

  BuscaListaProdutos(this.listaProdutosRef);
  @override
  String toString() {
    return "BuscaListaInicial";
  }
}



@immutable
class OnListaProdutosLoaded {
  final List<ListaProduto> listaProdutos;

  const OnListaProdutosLoaded(this.listaProdutos);

  @override
  String toString() {
    return "OnListaProdutosLoaded{lista: $listaProdutos}";
  }
}


class SalvaListaCompras {
  final ListaAdd lista;

  SalvaListaCompras(this.lista);
  @override
  String toString() {
    return "SalvaListaCompras";
  }
}


class EditaLista {
  final ListaAdd lista;

  EditaLista(this.lista);
  @override
  String toString() {
    return "SalvaListaCompras";
  }
}
