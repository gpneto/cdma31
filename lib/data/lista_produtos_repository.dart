import "dart:core";

import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/lista_produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListaProdutosRepository {
  static const String PATH = "lista_data";
  static const String OBS = "obs";
  static const String PRODUTO = "produto";
  static const String QUANTIDADE = "quantidade";
  static const String STATUS = "status";
  static const String SELECIONADO = "selecionado";
  static const String INICIAL_NOME = "inicial_nome";

  final Firestore firestore;

  const ListaProdutosRepository(this.firestore);

  Stream<List<ListaProduto>> getListaProdutosStream(DocumentReference ref) {
    return ref.collection("produtos").snapshots(includeMetadataChanges: true).asyncMap((querySnapshot) {
      List<ListaProduto> retorno = List<ListaProduto>();
      if (querySnapshot.documents == null) {
        return retorno;
      }


      return querySnapshot.documents
          .map((documentSnapshot) =>  fromDoc(documentSnapshot) )
          .toList();
    });
  }

  static ListaProduto fromDoc(DocumentSnapshot doc) {
    return ListaProduto((c) => c
      ..id = doc.documentID
      ..ref = doc.reference
      ..selecionado = doc.data[SELECIONADO]
      ..obs = doc.data[OBS]
      ..produto = doc.data[PRODUTO]
      ..quantidade = doc.data[QUANTIDADE]
      ..status = doc.data[STATUS]
      ..inicialNome =  doc.data[INICIAL_NOME]);
  }
}
