import "dart:core";

import 'package:cdma31/model/lista.dart';
import 'package:cdma31/model/lista_add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../application.dart';

class ListaRepository {
  static String PATH_LISTA_COMPRAS = '/users/$userId/listas';

  static const String DATA = "data";
  static const String TOTALITENS = "total_itens";
  static const String STATUS = "status";
  static const String DESCRICAO = "descricao";

  final Firestore firestore;

  const ListaRepository(this.firestore);

  Stream<List<Lista>> getListaComptasStream() {
    return firestore
        .collection(PATH_LISTA_COMPRAS)
        .where("status", isEqualTo: "PENDENTE")
        .snapshots(includeMetadataChanges: true)
        .map((querySnapshot) {
      List<Lista> retorno = List<Lista>();
      if (querySnapshot.documents == null) {
        return retorno;
      }
      return querySnapshot.documents
          .map((documentSnapshot) => fromDoc(documentSnapshot))
          .toList();
    });
  }

  static Lista fromDoc(DocumentSnapshot doc) {
    return Lista((c) => c
      ..id = doc.documentID
      ..data = doc.data[DATA].toDate()
      ..totalItens = doc.data[TOTALITENS]
      ..status = doc.data[STATUS]
      ..descricao = doc.data[DESCRICAO]
      ..produtosRef = doc.reference);
  }

  salvarLista(ListaAdd lista) async {
    //Primeiro Cria a lista com os produtos Seleiconados
    DocumentReference docLista =
        await firestore.collection(PATH_LISTA_COMPRAS).add({
      'data': FieldValue.serverTimestamp(),
      'descricao': lista.descricao,
      'status': 'PENDENTE',
      'total_itens': lista.produtosSelecionados.length
    });

    lista.produtosSelecionados.forEach((l) {
      docLista.collection("produtos").add(
          {'produto': l.produto, 'quantidade': l.quantidade, 'obs': l.obs});
    });
  }

  editaLista(ListaAdd lista) async {
    //Primeiro Cria a lista com os produtos Seleiconados
    await lista.ref.setData({
      'data': FieldValue.serverTimestamp(),
      'descricao': lista.descricao,
      'status': 'PENDENTE',
      'total_itens': lista.produtosSelecionados.length
    }, merge: true);

    //Busca os Produtos que não tem na lista para remover

    //Remove os produtos que não exisge mais na lista
    lista.ref.collection("produtos").getDocuments().then((snapshot) {
      Iterable existeNaoExiste = snapshot.documents.where((snapshotFiltro) =>
      lista.produtosSelecionados
          .toList()
          .where((element) => element.ref == snapshotFiltro.reference)
          .length ==
          0);

      for (DocumentSnapshot ds in existeNaoExiste) {
        ds.reference.delete();
      }
    });

    //Agora Atualiza os outros Registos

    lista.produtosSelecionados.forEach((l) {
      if(l.ref == null ){
        lista.ref.collection("produtos").add({
          'produto': l.produto,
          'quantidade': l.quantidade,
          'obs': l.obs,
          'inicial_nome': l.inicialNome
        });
      }else {
        l.ref.setData({
          'produto': l.produto,
          'quantidade': l.quantidade,
          'obs': l.obs,
          'inicial_nome': l.inicialNome
        }, merge: true);
      }
    });




  }
}
