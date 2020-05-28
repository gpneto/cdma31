import "package:built_value/built_value.dart";
import "package:built_collection/built_collection.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

part 'produto.g.dart';

abstract class Produto implements Built<Produto, ProdutoBuilder> {

  @nullable
  String get id;

  @nullable
  String get path;


  @nullable
  String get status;

  @nullable
  String get nome;

  @nullable
  String get unidadeMedida;

  @nullable
  DocumentReference get ref;


  Produto._();

  factory Produto([void Function(ProdutoBuilder) updates]) = _$Produto;
}
