import "dart:core";

import 'package:cdma31/model/categoria.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


class CategoriaRepository {
  static String PATH = '/users/{user}/categorias';
  static const String NOME = "nome";
  static const String UNIDADE = "unidade_medida";
  static const String STATUS = "status";
  static const String DESCRICAO = "descricao";


  final Firestore firestore;

  const CategoriaRepository(this.firestore);

  static DocumentReference reference(String uid ,String id) =>  Firestore.instance.document(PATH.replaceAll("{user}", uid) + "/$id");

  Stream<List<Categoria>> getCategoriaStream(String uid) {
    return firestore
        .collection(PATH.replaceAll("{user}", uid))
        .where("status", isEqualTo: "ATIVO")
        .orderBy("nome")
        .snapshots()
        .map((querySnapshot) {
      List<Categoria> retorno = List<Categoria>();
      if (querySnapshot.documents == null) {
        return retorno;
      }
      return querySnapshot.documents
          .map((documentSnapshot) => fromDoc(documentSnapshot))
          .toList();
    });
  }


  salvarCategoria(Categoria categoria,String uid) {
    firestore.collection(PATH.replaceAll("{user}", uid)).add({
      'nome': categoria.nome,
      'descricao': categoria.descricao,
      "status": "ATIVO"
    });
  }

  removerCategoria(DocumentReference categoria) {
    categoria.setData({"status": "INATIVO"}, merge: true);
  }

  static Categoria fromDoc(DocumentSnapshot doc) {
    return Categoria((c) => c
      ..id = doc.documentID
      ..nome = doc.data[NOME]
      ..status = doc.data[STATUS]
      ..descricao = doc.data[DESCRICAO]
      ..ref = doc.reference);
  }
}
