import "package:built_value/built_value.dart";
import "package:built_collection/built_collection.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

part 'categoria.g.dart';

abstract class Categoria implements Built<Categoria, CategoriaBuilder> {

  @nullable
  String get id;


  @nullable
  String get status;

  @nullable
  String get nome;

  @nullable
  String get descricao;
  
  @nullable
  DocumentReference get ref;


  Categoria._();

  factory Categoria([void Function(CategoriaBuilder) updates]) = _$Categoria;
}
