import "dart:core";

import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/lista_produto.dart';
import 'package:cdma31/model/produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../application.dart';

class ProdutosRepository {
  static String PATH = '/users/$userId/produtos';
  static const String NOME = "nome";
  static const String UNIDADE = "unidade_medida";
  static const String STATUS = "status";

  final Firestore firestore;

  const ProdutosRepository(this.firestore);

  Stream<List<Produto>> getProdutosStream() {
    return firestore
        .collection(PATH)
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

  salvarProduto(Produto produto) {
    firestore.collection(PATH).add({
      'nome': produto.nome,
      "unidade_medida": produto.unidadeMedida,
      "status": "ATIVO"
    });
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
      ..ref = doc.reference);
  }
}
