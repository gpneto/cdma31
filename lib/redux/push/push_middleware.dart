import "dart:io";

import 'package:cdma31/data/user_repository.dart';
import 'package:cdma31/redux/login/auth_actions.dart';
import 'package:flutter/cupertino.dart';

import "package:firebase_messaging/firebase_messaging.dart";
import "package:redux/redux.dart";

import '../app_actions.dart';
import '../app_state.dart';




List<Middleware<AppState>> createPushMiddleware(
  UserRepository userRespository,
  FirebaseMessaging firebaseMessaging,
  GlobalKey<NavigatorState> navigatorKey,


) {
  return [
    TypedMiddleware<AppState, UpdateUserTokenAction>(
        _updateUserAction(userRespository)),
    TypedMiddleware<AppState, OnAuthenticated>(
        _setTokenAfterLogin(userRespository)),

  ];
}

void Function(
  Store<AppState> store,
  UpdateUserTokenAction action,
  NextDispatcher next,
) _updateUserAction(UserRepository userRepository) {
  return (store, action, next) async {
    next(action);
    try {
      await userRepository.updateUserToken(action.token);
    } catch (e) {
//      Logger.e("Failed to update token", e: e, s: StackTrace.current);
    }
  };
}

void Function(
  Store<AppState> store,
  OnAuthenticated action,
  NextDispatcher next,
) _setTokenAfterLogin(UserRepository userRepository) {
  return (store, action, next) async {
    next(action);
    try {
      /// Set the token after the user is authenticated if the token exists
      if (store.state.fcmToken != null) {
        await userRepository.updateUserToken(store.state.fcmToken);
      }else{
        await userRepository.updateUserToken(null);
      }
    } catch (e) {
//      Logger.e("Failed to update token", e: e, s: StackTrace.current);
    }
  };
}
