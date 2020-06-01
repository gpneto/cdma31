import "dart:core";

import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/lista_produto.dart';
import 'package:cdma31/model/produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../application.dart';

class ProdutosRepository {
  static String PATH = '/users/{user}/produtos';
  static const String NOME = "nome";
  static const String UNIDADE = "unidade_medida";
  static const String STATUS = "status";
  static const String CATEGORIA = "categoria";

  final Firestore firestore;

  const ProdutosRepository(this.firestore);


  static DocumentReference reference(String uid ,String id) =>  Firestore.instance.document(PATH.replaceAll("{user}", uid) + "/$id");

  Stream<List<Produto>> getProdutosStream(String uid) {
    return firestore
        .collection(PATH.replaceAll("{user}", uid))
        .where("status", isEqualTo: "ATIVO")
        .orderBy("nome")
        .snapshots()
        .map((querySnapshot) {
      List<Produto> retorno = List<Produto>();
      if (querySnapshot.documents == null) {
        return retorno;
      }
      return querySnapshot.documents
          .map((documentSnapshot) => fromDoc(documentSnapshot))
          .toList();
    });
  }

  salvarProduto(Produto produto, String uid) async {
    //Se já tiver id então apenas atualiza
    if (produto.ref != null) {
      produto.ref.setData({
        NOME: produto.nome,
        UNIDADE: produto.unidadeMedida,
        STATUS: "ATIVO",
        CATEGORIA: produto.categoria
      }, merge: true);
    } else {
      firestore.collection(PATH.replaceAll("{user}", uid)).add({
        NOME: produto.nome,
        UNIDADE: produto.unidadeMedida,
        STATUS: "ATIVO",
        CATEGORIA: produto.categoria
      });
    }
  }

  removerProduto(DocumentReference produto) {
    produto.setData({"status": "INATIVO"}, merge: true);
  }

  static Produto fromDoc(DocumentSnapshot doc) {
    return Produto((c) => c
      ..id = doc.documentID
      ..nome = doc.data[NOME]
      ..unidadeMedida = doc.data[UNIDADE]
      ..status = doc.data[STATUS]
      ..ref = doc.reference
      ..categoria = doc.data[CATEGORIA]);
  }
}
