import "package:built_value/built_value.dart";
import "package:built_collection/built_collection.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

part 'lista.g.dart';

abstract class Lista implements Built<Lista, ListaBuilder> {
  String get id;

  DateTime get data;

  int get totalItens;

  String get status;

  DocumentReference get produtosRef;

  @nullable
  String get descricao;



  Lista._();

  factory Lista([void Function(ListaBuilder) updates]) = _$Lista;
}
