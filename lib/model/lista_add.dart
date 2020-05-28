import "package:built_value/built_value.dart";
import "package:built_collection/built_collection.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

import 'lista_produto.dart';

part 'lista_add.g.dart';

abstract class ListaAdd implements Built<ListaAdd, ListaAddBuilder> {

  @nullable
  DocumentReference get ref;

  String get descricao;

  @nullable
  BuiltList<ListaProduto> get produtosSelecionados;


  ListaAdd._();

  factory ListaAdd([void Function(ListaAddBuilder) updates]) = _$ListaAdd;
}
