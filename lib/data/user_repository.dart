import 'dart:io';


import 'package:cdma31/model/user.dart';
import 'package:cdma31/redux/stream_subscriptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/services.dart';
import 'package:get_version/get_version.dart';



import 'package:http/http.dart' as http;

import 'package:path/path.dart' as path;

import '../app_config.dart';
import 'dbs/sql_db_usuario.dart';
import 'firestore_paths.dart';


class UserRepository {
  static const NAME = "name";
  static const EMAIL = "email";
  static const IMAGE = "image";
  static const UID = "uid";
  static const TOKENS = "tokens_minhas_tarefas_mobile";
  static const STATUS = "status";
  static const VERSAOAPP = "versao_app";
  static const DATA_ACESSO = "data_acesso";
  static const DEVICE = "device";



  final FirebaseAuth _firebaseAuth;
  final Firestore _firestore;

  const UserRepository(
    this._firebaseAuth,
    this._firestore,
  );

  Stream<User> getUserStream(userId) {
    return _firestore
        .collection(FirestorePaths.PATH_USERS)
        .document(userId)
        .snapshots()
        .map((userSnapshot) {
      return fromDoc(userSnapshot);
    });
  }


  Stream<User> getAuthenticationStateChange() {
    return _firebaseAuth.onAuthStateChanged.asyncMap((firebaseUser) {
      return _fromFirebaseUser(firebaseUser);
    });
  }


  Future<User> signIn(String email, String password) async {
    final firebaseUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return await _fromFirebaseUser(firebaseUser.user);
  }


  Future<User> getUserFirebase() async {
    FirebaseUser firebaseUser  = await _firebaseAuth.currentUser();
    return await _fromFirebaseUser(firebaseUser);
  }


  Future<User> getUser(FirebaseUser firebaseUser) async {
    return await _fromFirebaseUser(firebaseUser);
  }

  Future<User> _fromFirebaseUser(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) return Future.value(null);

    //Busca o usuário do banco de dados
    User user;
    try {
       user = await DBProviderUsuario.db.getUser(firebaseUser.uid);
    }catch(e){
      print(e);
    }

    //Se for nulo entao busca do firebase

    if(user == null){
      user =  await getUserStream(firebaseUser.uid).first;
      user = user.rebuild((u) => u
        ..uid = user.uid
        ..name = user.name
        ..email = user.email);

      await DBProviderUsuario.db.newUsuario(user);

    }


    return user;
  }

  Future<void> newUsuario(User user) async {
    DBProviderUsuario.db.newUsuario(user);

    //Salva o Usuário no Firebase
    final documentReference =
    _firestore.document(FirestorePaths.userPath(user.uid));
    await documentReference.setData(toMap(user), merge: true);

  }



  Future<File> _downloadFile(String url, String nome) async {
    var req = await http.Client().get(Uri.parse(url));
    var file = File('$nome');
    await file.create(recursive: true);
    return file.writeAsBytes(req.bodyBytes);
  }

  Future<void> logOut() async {
    cancelAllSubscriptions();
    await updateUserToken(null);
    await _firebaseAuth.signOut();
  }

  Future<void> updateUserToken(String token) async {
    final firebaseUser = await _firebaseAuth.currentUser();
    if (firebaseUser != null) {
      final documentReference =
      _firestore.document(FirestorePaths.userPath(firebaseUser.uid));
      //Adiciona o Token para enviar a notificação a todos os devices do usuário cadatrado
      //Também aciciona o log de ultimo acesso
      // E a versão do aplicativo que está sendo usada


      String platformVersion = "";
// Platform messages may fail, so we use a try/catch PlatformException.
      try {
        platformVersion = await GetVersion.platformVersion;
      } on PlatformException {
        platformVersion = 'Failed to get platform version.';
      }

      if(token!= null ){
        return documentReference.setData({
          DEVICE: platformVersion,
          TOKENS: FieldValue.arrayUnion([token]),
          DATA_ACESSO: {"minhas_tarefas_mobile": FieldValue.serverTimestamp()},
          VERSAOAPP: {"minhas_tarefas_mobile": versaoApp}
        },merge: true);
      }else  {
        return documentReference.setData({
          DEVICE: platformVersion,
          DATA_ACESSO: {"minhas_tarefas_mobile": FieldValue.serverTimestamp()},
          VERSAOAPP: {"minhas_tarefas_mobile": versaoApp}
        },merge: true);
      }

    }
  }

  ///
  /// Allows to update the User, but only the following fields:
  /// - name
  /// - status
  /// - image
  ///
  Future<void> updateUser(User user) async {
    final firebaseUser = await _firebaseAuth.currentUser();
    if (firebaseUser != null) {
      final documentReference =
          _firestore.document(FirestorePaths.userPath(firebaseUser.uid));
      return documentReference.updateData({
        STATUS: user.status,
        NAME: user.name,
        IMAGE: user.image,
      });
    }
  }


  static toMap(User user) {
    return {
      UID: user.uid,
      NAME: user.name,
      EMAIL: user.email,
    };
  }

  static User fromDoc(DocumentSnapshot document) {
    return User((u) => u
      ..uid = document.documentID
      ..name = document[NAME] == null ? document.documentID : document[NAME]
      ..email = document[EMAIL] == null ? document.documentID : document[EMAIL]
      ..image = document[IMAGE]
      ..status = document[STATUS]
      );
  }

}
