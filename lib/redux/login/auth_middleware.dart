import 'dart:convert';

import 'package:cdma31/data/user_repository.dart';
import 'package:cdma31/model/user.dart';
import 'package:cdma31/redux/produtos/produtos_actions.dart';
import 'package:cdma31/screen/login/login_screan.dart';
import 'package:cdma31/screen/login/login_screen_viewmodel.dart';
import 'package:cdma31/util/logger.dart';
import 'package:cdma31/util/routes.dart';
import 'package:cdma31/util/scale_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:flutter/widgets.dart";
import "package:redux/redux.dart";

import '../../app_config.dart';
import '../../application.dart';
import '../app_actions.dart';
import '../app_state.dart';
import '../stream_subscriptions.dart';
import 'auth_actions.dart';

/// Authentication Middleware
/// LogIn: Logging user in
/// LogOut: Logging user out
/// VerifyAuthenticationState: Verify if user is logged in

List<Middleware<AppState>> createAuthenticationMiddleware(
  UserRepository userRepository,
  GlobalKey<NavigatorState> navigatorKey,
) {
  return [
    TypedMiddleware<AppState, VerifyAuthenticationState>(
        _verifyAuthState(userRepository, navigatorKey)),
    TypedMiddleware<AppState, LogIn>(_authLogin(userRepository, navigatorKey)),
    TypedMiddleware<AppState, Sign>(_sign(userRepository, navigatorKey)),
    TypedMiddleware<AppState, LogOutAction>(_authLogout(navigatorKey,userRepository))
  ];
}

void Function(
  Store<AppState> store,
  VerifyAuthenticationState action,
  NextDispatcher next,
) _verifyAuthState(
  UserRepository userRepository,
  GlobalKey<NavigatorState> navigatorKey,
) {
  return (store, action, next) {
    next(action);

    userUpdateSubscription?.cancel();
    userUpdateSubscription =
        userRepository.getAuthenticationStateChange().listen((user) async {
      print('[DEBUG] Retorno do getAuthenticationStateChange Login:' +
          DateTime.now().toString());
      if (user == null) {
        cancelAllSubscriptions();
        navigatorKey.currentState
            .pushReplacement(ScaleRoute(page: LoginPage()));
      } else {
        print('[DEBUG] Buscando os Documentos no  Login:' +
            DateTime.now().toString());



        print('[DEBUG]Adiciona o Usuário na Sessao Login:' +
            DateTime.now().toString());

        TargetPlatformNative _getOppositePlatform() {
          if (defaultTargetPlatform == TargetPlatform.iOS) {
            return TargetPlatformNative.iOS;
          } else {
            return TargetPlatformNative.android;
          }
        }

        defaultTargetPlatformNative = _getOppositePlatform();

        store.dispatch(OnAuthenticated(user: user));
        print('[DEBUG] Redireciona para a Tela Principal Log Login:' +
            DateTime.now().toString());

        print('[DEBUG] Adiciona o Log Login:' + DateTime.now().toString());
//        final uid = user.uid;
//        Firestore.instance
//            .collection('listas_compras')
//            .document('log')
//            .collection(uid)
//            .add({
//          'type': 'ACESSO',
//          "mensagem": "Usuário Acessou o App",
//          'createdAt': FieldValue.serverTimestamp()
//        });
        navigatorKey.currentState.pushReplacementNamed(Routes.home);
        store.dispatch(BuscaListaInicial());

      }
    });
  };
}

void Function(
  Store<AppState> store,
  dynamic action,
  NextDispatcher next,

) _authLogout(
  GlobalKey<NavigatorState> navigatorKey,
    UserRepository userRepository
) {
  return (store, action, next) async {
    next(action);
    try {
      await userRepository.logOut();
      cancelAllSubscriptions();
      store.dispatch(OnLogoutSuccess());
      store.dispatch(VerifyAuthenticationState());

    } catch (e) {
      store.dispatch(OnLogoutFail(e));
    }
  };
}

void Function(
  Store<AppState> store,
  LogIn action,
  NextDispatcher next,
) _authLogin(
  UserRepository userRepository,
  GlobalKey<NavigatorState> navigatorKey,
) {
  return (store, action, next) async {
    next(action);

    try {
      final user = await userRepository.signIn(action.user, action.pass);
      store.dispatch(VerifyAuthenticationState());
      action.completer.complete();
    } on PlatformException catch (e) {
      Logger.w("Failed login", e: e);
      store.dispatch(ActionStateLogin(stateLogin: StateLogin.init));
      action.onError(e.message);
    }
  };
}

void Function(
  Store<AppState> store,
  Sign action,
  NextDispatcher next,
) _sign(
  UserRepository userRepository,
  GlobalKey<NavigatorState> navigatorKey,
) {
  return (store, action, next) async {
    next(action);
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: action.email,
        password: action.pass,
      )
          .then((currentUser) async {
        User user = User();
        user = user.rebuild((u) => u
          ..uid = currentUser.user.uid
          ..name = action.user
          ..email = action.email);

        await userRepository.newUsuario(user);


        store.dispatch(VerifyAuthenticationState());
      }).catchError((err) {
        print('error caught: $err');
        Logger.i("Erro ao fazer login no firebase: $err");
        action.onError("Erro ao Acessar: $err");
        action.completer.completeError(err);
        store.dispatch(ActionStateLogin(stateLogin: StateLogin.init));
      });

      action.completer.complete();
    } catch (e) {
      action.onError("Erro ao Acessar: $e");
      store.dispatch(ActionStateLogin(stateLogin: StateLogin.init));
      action.completer.completeError(e);
    }
  };
}

_onTimeout(LogIn action, String mensagem, Store<AppState> store) {
  store.dispatch(ActionStateLogin(stateLogin: StateLogin.init));
  action.onError(
      mensagem == null ? "Erro ao Acessar Servidor do Status Page" : mensagem);
}

class LoginPost {
  final String status;
  final String msg;
  final String token;
  final String displayName;

  LoginPost({this.status, this.msg, this.token, this.displayName});

  factory LoginPost.fromJson(Map<String, dynamic> json) {
    return LoginPost(
        status: json['status'],
        msg: json['msg'],
        token: json['token'],
        displayName: json['displayName']);
  }
}
