import "package:built_value/built_value.dart";
import "package:built_collection/built_collection.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

part 'lista_produto.g.dart';

abstract class ListaProduto implements Built<ListaProduto, ListaProdutoBuilder> {

  @nullable
  String get id;

  @nullable
  DocumentReference get ref;

  @nullable
  DocumentReference get produto;

  @nullable
  String get quantidade;

  @nullable
  String get inicialNome;

  @nullable
  bool get selecionado;

  @nullable
  String get status;

  @nullable
  String get obs;

  ListaProduto._();

  factory ListaProduto([void Function(ListaProdutoBuilder) updates]) = _$ListaProduto;
}
